'''
Created on 12 Jul 2022

@author: gianni
'''

import anchorscad as ad
from anchorscad.core import Cylinder
from anchorscad.models.screws.CountersunkScrew import FlatSunkScrew
from anchorscad.models.hinges.Hinge import Hinge

@ad.datatree
class LidPath:
    big_lid_r: float=ad.dtfield(75, 'Radius of big lid')
    small_lid_h: float=ad.dtfield(24.7, 'Depth of small lid')
    big_lid_w: float=ad.dtfield(127.4 / 2, 'Half the width of big lid flat')
    small_lid_w: float=ad.dtfield(103.7 / 2, 'Half the width of small lid flat')

    def build(self) -> ad.Path:
        builder = (
            ad.PathBuilder()
            .move((0, 0))
            .line((-self.small_lid_w, 0), 'origin_to_lip')
            .arc_points(middle=(0, self.small_lid_h),
                        last=(self.small_lid_w, 0),
                        direction=False,
                        name='small_lid_arc')
            .line((self.big_lid_w, 0), 'lip_rhs')
            .arc_points_radius(last=(-self.big_lid_w, 0),
                               radius=self.big_lid_r,
                               name='big_lid_arc')
            .line((-self.small_lid_w, 0), 'lip_lhs')
            )
        return builder.build()

@ad.shape
@ad.datatree
class LidExtrusion(ad.CompositeShape):
    path_node: ad.Node=ad.Node(LidPath)
    h: float=ad.dtfield(12, 'Thickness of the lid')
    path: ad.Path=ad.dtfield(
            self_default=lambda s: s.path_node().build(), 
            doc='Lid polygon',
            init=False)
    extrude_node: ad.Node=ad.dtfield(
            ad.ShapeNode(ad.LinearExtrude, 
                     {'fn': 'lid_fn'},
                     expose_all=True),
            init=False)
    
    EXAMPLE_SHAPE_ARGS=ad.args(lid_fn=128)
    EXAMPLE_ANCHORS=()

    def build(self) -> ad.Maker:
        shape = self.extrude_node()
        maker = shape.solid('lid').at()
        return maker
    
 
@ad.shape
@ad.datatree
class LidWithScrewHoles(ad.CompositeShape):
    lid_extrusion_node: ad.Node=ad.ShapeNode(LidExtrusion)
    
    screw_spacing: float=ad.dtfield(
                                (35.6 + 30.1) / 2,
                                'Space betweeen screwholes')
    screwhole_d: float=ad.dtfield(1.9, 'Diameter of screwhole')
    
    screw_shaft_overall_length: float=ad.dtfield(16,
                                                 'Overall screw length')
    screw_shaft_thru_length: float=ad.dtfield(16,
                                              'Screwhole depth')
    screw_tap_shaft_dia_delta: float=0
    screw_size_name: float="M2.6"
    screw_head_depth_factor: float=1.1
    screw_include_tap_shaft: float=False
    screw_include_thru_shaft: float=False
    screw_as_solid: float=False
    screw_screw_node : ad.Node=ad.dtfield(
        ad.ShapeNode(FlatSunkScrew, 
                     {'fn': 'screw_fn',
                      'fa': 'screw_fa',
                      'fs': 'screw_fs'},
                     expose_all=True,
                     prefix='screw_'),
        init=False)
    
    x_fac: float=ad.dtfield(
            self_default=lambda s : s.screw_spacing / 2,
            doc='X translation factor')
    y_fac: float=ad.dtfield(
            self_default=lambda s : s.h - 4.2 - s.screwhole_d / 2,
            doc='Y translation factor')
    z_fac: float=ad.dtfield(-8, 'Z translation factor')
    
    
    EXAMPLE_SHAPE_ARGS=ad.args(lid_fn=128, screw_as_solid=False)
    EXAMPLE_ANCHORS=(ad.surface_args('sh2', 'top'),)
    
    def build(self) -> ad.Maker:
        screwhole = self.screw_screw_node()
        screwhole_assembly = screwhole.composite('sh1').at(
                'centre', post=ad.translate((self.x_fac,
                                             self.y_fac,
                                             self.z_fac)))
        screwhole_assembly.add_at(screwhole.composite('sh2').at(
                'centre', post=ad.translate((-self.x_fac,
                                             self.y_fac,
                                             self.z_fac))))
        
        shape = self.lid_extrusion_node()
        maker = shape.solid('lid').at()
        
        maker.add_at(screwhole_assembly,
                     'small_lid_arc', 0.5, rh=1)
        return maker
    
    
@ad.shape
@ad.datatree
class SplitLid(ad.CompositeShape):    
    lid_node: ad.Node=ad.dtfield(
            ad.ShapeNode(LidWithScrewHoles), init=False)
    lid_side: bool=False
    
    cut_box_size: tuple=ad.dtfield(
            self_default=lambda s: (
                s.big_lid_w * 2,
                s.sep,
                s.h + s.epsilon * 2), 
            doc='Size of cutbox')
    cut_box_node: ad.Node=ad.ShapeNode(ad.Box, prefix='cut_box_')
    
    sep: float=ad.dtfield(0.15, 'Separation factor for the two lid parts')
    
    epsilon: float=0.01
        
    _GEN_TEST_ARGS = lambda lid_side: \
        ad.args(lid_fn=128, lid_side=lid_side)
    
    EXAMPLE_SHAPE_ARGS=_GEN_TEST_ARGS(False)
    EXAMPLE_ANCHORS=()
    EXAMPLES_EXTENDED={
        'example2': ad.ExampleParams(
            shape_args=_GEN_TEST_ARGS(True))}

     
    def build(self) -> ad.Maker:
        maker = self.lid_node().solid('lid').at()
        maker.add_at(self.cut_box_node().hole('cut_box')
                     .at('face_edge', 'front', 0), 
                     'origin_to_lip', post=ad.ROTY_180 * ad.tranY(-self.epsilon))
        return maker


@ad.shape
@ad.datatree
class HingedLid(ad.CompositeShape):  
    lid_node: ad.Node=ad.dtfield(
            ad.ShapeNode(SplitLid), init=False)
    
    hinge_bar_h: float=ad.dtfield(
            self_default=lambda s: s.small_lid_w * 2 - 20,
            doc='Length of hinge component')  
    hinge_node: ad.Node=ad.dtfield(
            ad.ShapeNode(Hinge, {'sep': 'sep'},
                         prefix='hinge_',
                         expose_all=True), 
            init=False)
    
    EXAMPLE_SHAPE_ARGS=ad.args(
            hinge_seg_count=14,
            lid_fn=512,
            screw_fn=32,
            fn=128)
    EXAMPLE_ANCHORS=()
    
    def build(self) -> ad.Maker:
        lid_shape = self.lid_node()
        maker = lid_shape.solid('lid').at()
        hinge_shape = self.hinge_node()
        maker.add_at(hinge_shape.composite('hinge').at('centre'),
                     'cut_box', 'face_centre', 'top',
                     post=ad.ROTY_90)
        
        return maker    


# Uncomment the line below to default to writing OpenSCAD files
# when anchorscad_main is run with no --write or --no-write options.
MAIN_DEFAULT=ad.ModuleDefault(True)

if __name__ == "__main__":
    ad.anchorscad_main()