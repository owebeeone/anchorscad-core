'''
Created on 18 Sep 2025

@author: gianni
'''

import anchorscad as ad


@ad.shape
@ad.datatree
class Eyelet(ad.CompositeShape):
    '''
    A circular eyelet: a thin disk with a concentric hole.
    Defaults: thickness 1.5 mm, hole diameter 5 mm, edge margin 1.5 mm.
    '''
    t: float = ad.dtfield(1.5, 'Thickness of the disk (mm)')
    hole_d: float = ad.dtfield(5.0, 'Diameter of the eye hole (mm)')
    edge: float = ad.dtfield(1.5, 'Radial margin from hole to outer edge (mm)')
    fn: int = ad.dtfield(128, 'Number of facets for cylinders')
    epsilon: float = ad.dtfield(0.01, 'Epsilon to avoid coplanar tearing')

    # Derived radii/heights so we can inject them via ShapeNode mappings.
    inner_r: float = ad.dtfield(5 / 2,
                                doc='Inner radius of the eyelet (from hole_d)')
    outer_r: float = ad.dtfield(30 / 2,
                                doc='Outer radius of the eyelet (inner_r + edge)')
    inner_h: float = ad.dtfield(self_default=lambda s: s.t + s.epsilon * 2,
                                doc='Hole height (slightly larger to avoid coplanar tearing)')
    outer_h: float = ad.dtfield(self_default=lambda s: s.t,
                                doc='Outer cylinder height (same as thickness)')

    outer_cyl_node: ad.Node = ad.ShapeNode(ad.Cylinder, prefix='outer_')
    inner_cyl_node: ad.Node = ad.ShapeNode(ad.Cylinder, prefix='inner_')
    
    hole_offset: float = ad.dtfield(1.5, 'Offset of the hole from the edge')

    # Glue cone depressions (on one face)
    glue_count: int = ad.dtfield(7, 'Number of glue cones placed radially')
    glue_r_top: float = ad.dtfield(3.0, 'Glue cone top radius (mm)')
    glue_r_base: float = ad.dtfield(4.0, 'Glue cone base radius (mm)')
    glue_h: float = ad.dtfield(self_default=lambda s: s.t / 2,
                               doc='Glue cone depth/height (mm)')
    glue_angle_offset: float = ad.dtfield(45.0, 'Angular offset for glue cone pattern (deg)')

    glue_cone_node: ad.Node = ad.ShapeNode(ad.Cone, prefix='glue_')
    

    EXAMPLE_SHAPE_ARGS = ad.args()
    EXAMPLE_ANCHORS = (
    )

    def build(self) -> ad.Maker:
        outer = self.outer_cyl_node()
        maker = outer.solid('outer').at('centre')

        inner = self.inner_cyl_node()
        maker.add_at(
            inner.hole('inner').at('surface', 0, rh=0.5), 
            'surface', 0, rh=0.5, post=ad.tranZ(-self.hole_offset))

        # Add glue cone holes on the top face in a radial pattern using surface anchors
        if self.glue_count:
            cone = self.glue_cone_node()
            for i in range(self.glue_count - 1):
                angle = (
                    self.glue_angle_offset 
                    + (i + 1) * (360.0 - 2 * self.glue_angle_offset) / self.glue_count)
                maker.add_at(
                    cone.hole(('glue', i + 1)).at('surface', 0, tangent=False, rh=1),
                    'outer', 'surface', self.outer_h, angle,
                    post=ad.translate((0, self.epsilon, -self.hole_offset))
                )
            maker.add_at(
                cone.hole(('glue', 0)).at('top'),
                'outer', 'top',
                post=ad.tranZ(self.epsilon)
            )

        return maker

    @ad.anchor('Inner surface anchor (normal outward)')
    def inner_surface(self, *args, **kwds):
        return self.maker.at('inner', 'surface', *args, **kwds) * ad.ROTX_180


# Uncomment to default to writing OpenSCAD files on anchorscad_main.
MAIN_DEFAULT=ad.ModuleDefault(all=True)

if __name__ == '__main__':
    ad.anchorscad_main()

