'''
Created on 11-Dec-2025

@author: gianni

A simple leg extension sleeve with parameterized interference fit.
'''

import anchorscad as ad
from anchorscad_models.screws.CountersunkScrew import CountersunkScrew


@ad.datatree
class LegExtensionPath:
    '''The 2D Path for the leg extension sleeve for rotate_extrude.'''

    # Inner pipe radius (25.2 mm diameter / 2).
    r: float = ad.dtfield((25.4 + 0.8) / 2, doc='The radius of the table leg pipe.')
    # Sleeve length along the pipe (overlap).
    w: float = ad.dtfield(35 + 40, doc='The length of the extension overlap.')
    # Bevel radius for edges.
    br: float = ad.dtfield(1.5, doc='The radius of the bevel.')
    # Wall thickness derived from desired outer diameter (42.2 mm diameter / 2 minus inner radius).
    t: float = ad.dtfield(42.5 / 2 - 25.2 / 2, doc='The wall thickness of the extension.')
    # Base thickness at the closed end.
    tb: float = ad.dtfield(35, doc='The thickness of the base of the extension.')
    # Interference ridge settings.
    ih: float = ad.dtfield(0.4, doc='Interference ridge height.')
    iw: float = ad.dtfield(10, doc='Interference ridge width.')
    io: float = ad.dtfield(20, doc='Interference offset from top of sleeve path.')
    irel_len: float = ad.dtfield(0.4, doc='Interference ridge spline relative length.')
    
    bevel_fn: int = ad.dtfield(8, doc='The number of facets for the bevels.')

    def build(self) -> ad.Path:
        builder = ad.PathBuilder(reverse=False)

        end_ridge = self.w - (self.iw + self.io)
        assert end_ridge >= self.tb, f"Interference ridge too wide by {self.tb - end_ridge}."

        mid_ridge = end_ridge + self.iw / 2
        
        bevel_metadata = ad.ModelAttributes(fn=self.bevel_fn)

        (builder.move((0, 0))
         .line((-(self.r + self.t - self.br), 0), 'base')
         .arc_tangent_radius_sweep(self.br, -90, name='base_bevel', metadata=bevel_metadata)
         .stroke(self.w - 2 * self.br, name='outer_side')
         .arc_tangent_radius_sweep(self.br, -90, name='outer_top_bevel', metadata=bevel_metadata)
         .stroke(self.t - 2 * self.br, name='outer_top')
         .arc_tangent_radius_sweep(self.br, -90, name='inner_top_bevel', metadata=bevel_metadata)
         .stroke(self.io - self.br, name='upper_inner_side')
         .spline(
             ((-self.r + self.ih, mid_ridge + 1), (-self.r + self.ih, mid_ridge)),
             cv_len=(1, 1),
             rel_len=self.irel_len,
             name='upper_ridge')
         .spline(
             ((-self.r, end_ridge + 1), (-self.r, end_ridge)),
             cv_len=(1, 1),
             rel_len=self.irel_len,
             name='lower_ridge')
         .line((-self.r, self.tb), 'lower_inner_side')
         .line((0, self.tb - 8), 'inner_base')
         .line((0, 0), 'centre_axis')
         )

        return builder.build()


@ad.shape
@ad.datatree
class LegExtensionBase(ad.CompositeShape):
    '''
    A simple leg extension sleeve.
    '''

    # All parameters are injected from LegExtensionPath.
    path_node: ad.Node = ad.dtfield(ad.ShapeNode(LegExtensionPath))
    path: ad.Path = ad.dtfield(self_default=lambda s: s.path_node().build())
    use_polyhedrons: bool = ad.dtfield(True, doc='Use polyhedrons instead of rotate_extrude.')

    # Injected parameter "path" from RotateExtrude will pick up the self_default path.
    rotate_extrude_node: ad.Node = ad.ShapeNode(ad.RotateExtrude)

    fn: int = ad.dtfield(32, doc='The number of facets for the rotate_extrude.')

    EXAMPLE_SHAPE_ARGS = ad.args()
    EXAMPLE_ANCHORS = ()

    def build(self) -> ad.Maker:
        # Build the rotate_extrude shape and name it.
        shape = self.rotate_extrude_node()
        maker = shape.solid('leg_extension').at()
        return maker


@ad.shape
@ad.datatree
class LegExtension(ad.CompositeShape):
    '''
    A simple leg extension sleeve.
    '''

    base_node: ad.ShapeNode[LegExtensionBase] = ad.ShapeNode(LegExtensionBase)
    base: LegExtensionBase = ad.dtfield(self_default=lambda s: s.base_node())

    screw_shaft_overall_length: float = ad.dtfield(70, doc='Overall screw shaft length.')
    screw_shaft_thru_length: float = ad.dtfield(35, doc='Through length for screw shaft.')
    screw_size_name: str = ad.dtfield('WOOD_10g', doc='Screw designation for the countersunk holes.')
    screw_hole_node: ad.ShapeNode[CountersunkScrew] = ad.ShapeNode(CountersunkScrew, prefix='screw_')

    epsilon: float = ad.dtfield(0.01, doc='The epsilon value for cutting the test box.')
    fn: int = ad.dtfield(128, doc='The number of facets for the screw holes.')

    screw_positions: ad.AnchorArgs = (
        ad.surface_args('outer_top', 0.5, angle=0),
        ad.surface_args('outer_top', 0.5, angle=90),
        ad.surface_args('outer_top', 0.5, angle=180),
        ad.surface_args('outer_top', 0.5, angle=270),
    )

    EXAMPLE_SHAPE_ARGS = ad.args(screw_as_solid=False)
    EXAMPLE_ANCHORS = ()

    def build(self) -> ad.Maker:
        maker = self.base.solid('base').at()

        screw_shape = self.screw_hole_node()

        for i, anchor in enumerate(self.screw_positions):
            screw_maker = screw_shape.composite(('screw', i)).at('top', post=ad.tranZ(-self.epsilon))
            maker.add_at(screw_maker, anchor=anchor)

        return maker





# Uncomment the line below to default to writing OpenSCAD files
# when anchorscad_main is run with no --write or --no-write options.
MAIN_DEFAULT = ad.ModuleDefault(all=True)

if __name__ == "__main__":
    ad.anchorscad_main()
