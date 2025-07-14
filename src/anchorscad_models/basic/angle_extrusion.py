'''
Created on 2025-07-14

@author: gianni
'''

import anchorscad as ad


@ad.datatree
class AngleExtrusionPathBuilder:
    '''A path builder for an angle extrusion.'''
    
    w: float=ad.dtfield(15, doc='Width of block')
    d: float=ad.dtfield(15, doc='Height of block')
    t: float=ad.dtfield(5, doc='Thickness of block')
    ibr: float=ad.dtfield(0.5, doc='Inner bevel radius')
    obr: float=ad.dtfield(0.3, doc='Outer bevel radius')
    ocbr: float=ad.dtfield(0.1, doc='Outer corner bevel radius')
    icbr: float=ad.dtfield(1.0, doc='Inner corner bevel radius')
    
    def build(self) -> ad.Path:
        builder = (ad.PathBuilder()
                .move((self.w - self.obr, 0))
                .line((self.ocbr, 0), 'outer-base')
                .arc_tangent_radius_sweep(self.ocbr, sweep_angle=-90, name='outer-corner')
                .stroke(self.d - self.obr - self.ocbr, name='outer-side')
                .arc_tangent_radius_sweep(self.obr, sweep_angle=-90, name='outer-bevel-top')
                .stroke(self.t - self.obr - self.ibr, name='top')
                .arc_tangent_radius_sweep(self.ibr, sweep_angle=-90, name='inner-bevel-top')
                .stroke(self.d - self.ibr - self.icbr - self.t, name='inner-side')
                .arc_tangent_radius_sweep(self.icbr, sweep_angle=90, side=True, name='inner-corner')
                .stroke(self.w - self.ibr - self.icbr - self.t, name='inner-base')
                .arc_tangent_radius_sweep(self.ibr, sweep_angle=-90, name='inner-bevel-base')
                .stroke(self.t - self.obr - self.ibr, name='side')
                .arc_tangent_radius_sweep(self.obr, sweep_angle=-90, name='outer-bevel-base')
        )
        
        with builder.construction() as construct:
            construct.move((self.w, 0))
            construct.line((0, 0), 'construct-base')
            construct.line((0, self.d), 'construct-side')

                    
        return builder.build()


@ad.shape
@ad.datatree
class AngleExtrusion(ad.CompositeShape):
    '''
    <description>
    '''
    path_builder: ad.Node = ad.ShapeNode(AngleExtrusionPathBuilder)
    path: ad.Path=ad.dtfield(self_default=lambda s: s.path_builder().build())
    
    h: float=ad.dtfield(30, doc='Height of the shape')
    
    extrude_node: ad.Node=ad.ShapeNode(ad.LinearExtrude)
    
    
    EXAMPLE_SHAPE_ARGS=ad.args(fn=32)
    EXAMPLE_ANCHORS=()

    def build(self) -> ad.Maker:
        shape = self.extrude_node()
        maker = shape.solid('extrusion').at()
        return maker



# Uncomment the line below to default to writing OpenSCAD files
# when anchorscad_main is run with no --write or --no-write options.
MAIN_DEFAULT=ad.ModuleDefault(all=True)

if __name__ == "__main__":
    ad.anchorscad_main()
