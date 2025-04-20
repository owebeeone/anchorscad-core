# Multi-Material and Multi-Part Support in AnchorSCAD

## Introduction
The current development version of OpenSCAD has minimal support for generating multiple models
from a single .scad file. This is called "Lazy Union". The implicit union for all top level shapes 
are rendered as separate models into 3mf files. AnchorSCAD now uses this experimental openscad
"lazy union" feature together with new `Part`, `Material`, and `MaterialMap` attributes to create Lazy Union enabled files.

This allows a single AnchorSCAD model to define multiple distinct objects, potentially with different materials, which can be useful for multi-material printing, defining support structures, or creating complex assemblies.

(Note that the lazy-union feature needs to be enabled in the Preferences->Features menu or
the '--enable lazy-union' CLI option.)


## Part, Material, and MaterialMap Classes
AnchorSCAD uses three core classes to manage multi-part and multi-material rendering:

1.  **`anchorscad.Part`**: Defines a distinct part of the model. It has a `name` and a `priority`. Parts allow grouping related shapes. By default, shapes belong to the `DEFAULT_PART`.
2.  **`anchorscad.Material`**: Defines a material assigned to a shape. It includes a `name`, `priority`, and a `kind` (typically `PHYSICAL_MATERIAL_KIND` or `NON_PHYSICAL_MATERIAL_KIND`). By default, shapes use `DEFAULT_EXAMPLE_MATERIAL`.
3.  **`anchorscad.MaterialMap`**: Allows remapping materials for shapes within a specific context, useful for reusing designs with different material assignments.

Internally, the renderer uses a `PartMaterial` combination to track each geometric entity.

### Priority and Volume Conflict Resolution ("Curing")

When different parts or materials overlap in space, AnchorSCAD resolves conflicts using priorities. The resolution happens based on the combined `PartMaterial` priority:

*   **Part Priority First**: Parts with higher priority take precedence over parts with lower priority.
*   **Material Priority Second**: Within the same Part priority, materials with higher priority take precedence over materials with lower priority.

During rendering, if a `PartMaterial` combination (A) has a higher priority than another `PartMaterial` combination (B), and B's material `kind` is `PHYSICAL_MATERIAL_KIND`, the volume of A will be subtracted from the volume of B using the OpenSCAD `difference()` operation. This prevents overlapping volumes for distinct physical parts/materials.

### Physical vs. Non-Physical Materials

Materials with `kind=NON_PHYSICAL_MATERIAL_KIND` (like the default `COORDINATES_MATERIAL` used for anchors) are excluded from the volume subtraction process. They can overlap with physical parts and are typically used for non-printable elements like:
*   Visual aids (e.g., example anchors)
*   Slicer modifiers (e.g., support blockers/enforcers, variable infill regions)

These non-physical parts are often rendered as separate objects in the final output file (e.g., 3MF).

### Default Parts and Materials

All example shapes are generated with the part named `"default"` (priority 5.0) and the material named `"default"` (priority 5.0). Example anchors are rendered with the part `"default"` and the material named `"anchor"` (which is non-physical).


## Rendering Multi-Part/Multi-Material Models
Parts and Materials can be assigned to a model using the `.part()` and `.material()` attribute functions, respectively. The model below is a simple "sphere on box". The box and sphere are assigned different materials, and both belong to the default part.

Notably, the `box` material is given a higher priority (10) than the `sphere` material (9). Since both belong to the same default part (priority 5), the material priority dictates the conflict resolution. The box volume will be subtracted from the sphere volume where they overlap.

The EXAMPLE_ANCHOR is rendered using the "anchor" material and hence will have both the box
and sphere removed.

```python
@ad.shape
@ad.datatree
class MultiMaterialTest(ad.CompositeShape):
    '''
    A basic test of multi-material support. Basically a box with a sphere on top.
    The box and sphere are different materials.
    '''
    xy: float=30
    z: float=10
    
    size: tuple=ad.dtfield(
        doc='The (x,y,z) size of ShapeName',
        self_default=lambda s: (s.xy, s.xy, s.z))
    
    # A node that builds a box from the size tuple. See:
    # https://github.com/owebeeone/anchorscad/blob/master/docs/datatrees_docs.md
    box_node: ad.Node=ad.dtfield(ad.ShapeNode(ad.Box, 'size'))
    
    sphere_r: float=ad.dtfield(self_default=lambda s: s.xy/2)
    
    shpere_node: ad.Node=ad.dtfield(ad.ShapeNode(ad.Sphere, prefix='sphere_'))
    
    EXAMPLE_SHAPE_ARGS=ad.args(xy=20, z=10)
    EXAMPLE_ANCHORS=(
        ad.surface_args('sphere', 'top'),)

    def build(self) -> ad.Maker:
        
        box_shape = self.box_node()
        maker = box_shape.solid('box') \
                .material(ad.Material('box', priority=10)) \
                .at('face_centre', 'base', post=ad.ROTX_180)
        maker.add_at(
            self.shpere_node()
                    .solid('sphere')
                    .material(ad.Material('sphere', priority=9))
                    .at('top', rh=1.4),
            'face_centre', 'top')

        return maker
```

The following OpenSCAD code is generated from the `MultiMaterialTest` example. AnchorSCAD's `PartMarterialResolver` processes the shapes based on their assigned parts and materials, applying priority rules.

Key points about the generated code:
*   **Modular Structure:** The code defines separate `module` blocks for each unique combination of `PartMaterial` encountered. The module names follow the pattern `<part>_<part_priority>_<material>_<material_priority>` (with potentially `_cured` or `_non_physical` suffixes), making it easier to identify the origin of each geometric piece.
*   **Curing:** The `default_5_sphere_9_cured` module demonstrates the conflict resolution. Because the `box` material (priority 10) is higher than the `sphere` material (priority 9) within the same `default` part (priority 5), the `default_5_box_10` module's geometry is subtracted from the `default_5_sphere_9` module's geometry using `difference()`.
*   **Non-Physical Parts:** The `default_5_non_physical_20_non_physical_non_physical` module corresponds to the default `EXAMPLE_ANCHOR` specified in the Python code, which uses the non-physical `COORDINATES_MATERIAL` (`anchor`, priority 20). It appears as a separate entity.
*   **Lazy Union:** The top-level `lazy_union` section simply calls the relevant modules. This structure, combined with OpenSCAD's experimental feature, allows generating a 3MF file containing multiple, individually addressable models (the box, the cured sphere, and the non-physical anchor).

```openscad
// Start: lazy_union
default_5_box_10();
default_5_sphere_9_cured();
default_5_non_physical_20_non_physical_non_physical();
// End: lazy_union

// Modules.

// 'PartMaterial undef-default - box 10'
module default_5_box_10() {
  // 'None : _combine_solids_and_holes'
  union() {
    // 'default : _combine_solids_and_holes'
    union() {
      // 'box'
      multmatrix(m=[[1.0, 0.0, 0.0, -10.0], [0.0, 1.0, 0.0, -10.0], [0.0, 0.0, 1.0, 0.0], [0.0, 0.0, 0.0, 1.0]]) {
        // 'box : _combine_solids_and_holes'
        union() {
          // 'box'
          cube(size=[20.0, 20.0, 10.0]);
        }
      }
    }
  }
} // end module default_5_box_10

// 'PartMaterial undef-default - non_physical 20 non-physical'
module default_5_non_physical_20_non_physical_non_physical() {
  // 'None : _combine_solids_and_holes'
  union() {
    // 'default : _combine_solids_and_holes'
    union() {
      // 'sphere_non_physical'
      multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, 19.0], [0.0, 0.0, 0.0, 1.0]]) {
        // 'sphere_non_physical : _combine_solids_and_holes'
        union() {
          // 'sphere_non_physical'
          sphere(r=10.0);
        }
      }
    }
  }
} // end module default_5_non_physical_20_non_physical_non_physical

// 'PartMaterial undef-default - sphere 9'
module default_5_sphere_9() {
  // 'None : _combine_solids_and_holes'
  union() {
    // 'default : _combine_solids_and_holes'
    union() {
      // 'sphere'
      multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, 14.0], [0.0, 0.0, 0.0, 1.0]]) {
        // 'sphere : _combine_solids_and_holes'
        union() {
          // 'sphere'
          sphere(r=10.0);
        }
      }
    }
  }
} // end module default_5_sphere_9

// 'PartMaterial undef-default - sphere 9'
module default_5_sphere_9_cured() {
  difference() {
    default_5_sphere_9();
    default_5_box_10();
  }
} // end module default_5_sphere_9_cured
```

### Physical vs. Combined Output

AnchorSCAD can also generate output containing *only* the physical parts. This is useful if the non-physical elements (like anchors or slicer modifiers) are not desired in the final geometry file sent to the slicer.

The "physical" output file's `lazy_union` section would omit calls to modules generated from non-physical materials. Note the absence of the `default_5_non_physical_20_non_physical_non_physical()` call below compared to the full output shown previously:

```openscad
// Start: lazy_union
default_5_box_10();
default_5_sphere_9_cured();
// End: lazy_union
... rest of definitions
```

## Slicer Support

Both Prusa and Orca slicers will import geometry from an OpenSCAD generated 3mf file, however to ensure the Z axis is not broken when loading the file you must respond "Yes" to the dialog that says: 

```
This file contains several objects positioned at multiple heights.
Instead of considering them as multiple objects, should 
the file be loaded as a single object having multiple parts?
```

Sadly, this limits the ability to turn off and on various parts of the model. For example, example-anchors should in theory not be sliced as they're just for a visual cues however the
"part type" setting can be used to cause it not to be rendered in the final gcode.

Also, Orca's method for selecting a part is somewhat unintuitive compared to Prusa slicer. Some more serious UI work needs to be done here.

Here is a screenshot of Orca showing the sliced test model.

![Multi Material](assets/multu-material-examp.png?raw=true)

## Future

If OpenSCAD keeps the experimental lazy-union support into the next release, I think this
level of part and material support is sufficient for AnchorSCAD to be useful.

I want to automate the workflow even more. AnchorSCAD has a generic 3mf file reader/writer 
that extends the datatrees/dataclasses module into xdatatrees. The goal is to make it simpler
to generate 3mf project files directly. I'm hoping to one day render directly to printer
without having to fire up the GUI for the slicer. In particular, filament to material mapping
somewhat difficult since material names are lost using the lazy-union feature, though part information might help mitigate this.

