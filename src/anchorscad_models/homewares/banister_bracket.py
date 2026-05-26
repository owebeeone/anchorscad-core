'''
Created on 18-Dec-2025

@author: gianni

A simple banister bracket for mounting other parts without drilling into the banister.
'''

import anchorscad as ad
from anchorscad_models.screws.CountersunkScrew import CountersunkScrew
from anchorscad_models.basic.regular_prism import RegularPrism
from anchorscad_models.basic.box_side_bevels import BoxSideBevels


@ad.datatree
class BanisterBracketPath:
    '''The 2D Path for the banister bracket.'''
    
    w: float = ad.dtfield(88, doc='Width of the banister')
    d: float = ad.dtfield(88, doc='Depth of the banister')
    t: float = ad.dtfield(12, doc='Thickness of the bracket')
    split_d: float = ad.dtfield(60, doc='Depth of the split')
    chamfer_w: float = ad.dtfield(0.25, doc='Width of the chamfer')
    bevel_r: float = ad.dtfield(6, doc='Radius of the bevel')
    side: str = ad.dtfield(None, doc='Side of the bracket')
    
    
    def build(self) -> ad.Path:
        builder = ad.PathBuilder()
        
        side = self.side
        if side == 'left':
            split_s = self.split_d
        elif side == 'right':
            split_s = self.d - self.split_d
        else:
            raise ValueError(f'Side {side} not supported.')
            
        builder.move((split_s, 0), name="start", direction=(1, 0))
        builder.line((self.chamfer_w, 0), f'base_{side}')
        builder.line((0, self.chamfer_w), f'base_{side}_chamfer')
        builder.line((0, self.w - self.chamfer_w), f'{side}')
        builder.line((self.chamfer_w, self.w), f'top_{side}_chamfer')
        builder.line((split_s, self.w), f'top_{side}')
        builder.line((split_s, self.w + self.t), f'top_{side}_cut')
        builder.line((self.bevel_r - self.t, self.w + self.t), f'{side}_top')
        builder.arc_tangent_radius_sweep(self.bevel_r, 90, side=True, name=f'{side}_top_bevel')
        stroke_length = self.w - 2 * self.bevel_r + 2 * self.t
        builder.stroke(stroke_length, name=f'{side}_outer')
        builder.arc_tangent_radius_sweep(self.bevel_r, 90, side=True, name=f'{side}_base_bevel')
        base_stroke_length = split_s - self.bevel_r + self.t
        builder.stroke(base_stroke_length, name=f'{side}_base_outer')
        builder.line((split_s, 0), f'base_{side}_cut')
        
        with builder.construction() as construct:
            construct.move((self.d / 2, self.w / 2))
            construct.line((self.d / 2, 0), 'centre_line')

        return builder.build()
    
@ad.datatree
@ad.shape
class TearCylinder(ad.CompositeShape):
    '''The mount hole for the banister bracket.'''
    
    r: float = ad.dtfield(10, doc='Radius of the mount hole.')
    h: float = ad.dtfield(11.71)
    cage_node: ad.ShapeNode[ad.Cylinder]
    extrude_node: ad.ShapeNode[ad.LinearExtrude] = ad.ShapeNode(ad.LinearExtrude, 'h')
    
    angle: ad.Angle = ad.dtfield(ad.angle(35), doc='Angle of the tear.')
    
    EXAMPLE_SHAPE_ARGS=ad.args(fn=32)
    
    def build(self) -> ad.Maker:
        maker = self.cage_node().solid('cage').transparent(True).colour("olive", 0.5).at('base')
        
        builder = ad.PathBuilder()
        
        angle = ad.angle(self.angle)
        
        sinr, cosr = angle.sinr_cosr()
        tear_tr = self.r / cosr
        
        with builder.construction() as construct:
            construct.move((0, 0))
            construct.line((0, tear_tr), 'centre_line')
        
        builder.move((0, tear_tr))
        builder.line((sinr * self.r, cosr * self.r), 'tear_right')
        builder.arc_tangent_radius_sweep(
            self.r, angle.degrees() * 2 - 360, 
            side=False,
            name='tear_arc')
        builder.line((0, tear_tr), 'tear_left')
        
        path = builder.build()
        shape = self.extrude_node(path=path)
        tear_maker = shape.solid('tear').at('centre_line', 0)
        
        maker.add_at(tear_maker, 'base', post=ad.ROTX_270)
        
        return maker
    
@ad.shape
@ad.datatree
class BanisterBracketMountHole(ad.CompositeShape):
    '''The mount hole for the banister bracket.'''
    
    r: float = ad.dtfield(4.2 / 2, doc='Radius of the mount hole.')
    h: float = ad.dtfield(11.71)
    cyl_node: ad.ShapeNode[TearCylinder]
    
    nut_nsides: int = ad.dtfield(6, doc='Number of sides of the nut.')
    nut_h: float = ad.dtfield(3.2, doc='Height of the nut hole.')
    nut_r: float = ad.dtfield(self_default=lambda s:(7.3 / 2) / ad.angle(30).sinr_cosr()[1], doc='Radius of the nut.')
    nut_node: ad.Node[RegularPrism] = ad.ShapeNode(RegularPrism, prefix='nut_')
        
    EXAMPLE_SHAPE_ARGS=ad.args(fn=64)
    EXAMPLE_ANCHORS=(
        ad.surface_args('nut', 'side', 0, 0.5),
        ad.surface_args('nut', 'side', 3, 0.5),
    )
    
    def build(self) -> ad.Maker:
        cyl_shape = self.cyl_node()
        maker = cyl_shape.composite('cyl').at()
        
        nut_shape = self.nut_node()
        maker.add_at(nut_shape.solid('nut').at('base'), 'base')
        
        # s0 = maker.at('nut', "side", 0, 0.5)
        # s3 = maker.at('nut', "side", 3, 0.5)
        # print(f'Distance between s0 and s3: {ad.distance_between(s0, s3)}')
        
        return maker
    
@ad.shape
@ad.datatree
class BanisterBracket(ad.CompositeShape):
    '''The banister bracket.'''
    
    path_node: ad.Node[BanisterBracketPath] = ad.ShapeNode(
        BanisterBracketPath, exclude=['side'])
    h: float = ad.dtfield(35, doc='Height of the bracket')
    path_left: ad.Path = ad.dtfield(self_default=lambda s: s.path_node(side='left').build())
    path_right: ad.Path = ad.dtfield(self_default=lambda s: s.path_node(side='right').build())
    
    extrude_left_node: ad.Node[ad.LinearExtrude] = ad.ShapeNode(
        ad.LinearExtrude, {'path': 'path_left'}, expose_all=True)
    extrude_right_node: ad.Node[ad.LinearExtrude] = ad.ShapeNode(
        ad.LinearExtrude, {'path': 'path_right'}, expose_all=True)
    
    screw_shaft_overall_length: float = ad.dtfield(80, doc='Overall screw shaft length.')
    screw_shaft_thru_length: float = ad.dtfield(35, doc='Through length for screw shaft.')
    screw_size_name: str = ad.dtfield('WOOD_10g', doc='Screw designation for the countersunk holes.')
    screw_hole_node: ad.ShapeNode[CountersunkScrew] = ad.ShapeNode(CountersunkScrew, prefix='screw_')
    
    screw_offset: float = ad.dtfield(10, doc='Offset of the screws from the centre of the bracket.')
    
    mount_hole_h: float = ad.dtfield(self_default=lambda s: s.t + s.epsilon, doc='Height of the mount hole.')
    mount_hole_node: ad.ShapeNode[BanisterBracketMountHole] = ad.ShapeNode(
         BanisterBracketMountHole, prefix='mount_hole_')

    mount_hole_sep: float = ad.dtfield((32.7 + 22.2) / 2, doc='Separation of the mount holes.')
    bracket_h : float = 29.1
    bracket_w : float = 41.0
    mount_hole_offset: float = ad.dtfield(self_default=lambda s: 
        (s.bracket_h - 19.9 - 3.6) / 2 + 19.9 - s.bracket_h / 2, 
        doc='Offset of the mount holes from the centre of the bracket.')
    
    split_left: bool = ad.dtfield(False, doc='Split the left side of the bracket.')
    split_depth: float = ad.dtfield(20, doc='Depth of the split.')
    
    epsilon: float = ad.dtfield(0.01, doc='Epsilon value for the bracket.')
    
    EXAMPLE_SHAPE_ARGS=ad.args(fn=32)
    
    EXAMPLES_EXTENDED={
        'split': ad.ExampleParams(shape_args=ad.args(fn=32, split_left=True, split_depth=20)),
    }
    
    def build(self) -> ad.Maker:
        cage_size = (self.w, self.d, self.h)
        cage_shape = ad.Box(cage_size)
        maker = cage_shape.cage('cage').transparent(True).colour("green", 0.5).at('centre')
        
        shape_left = self.extrude_left_node()
        maker.add_at(shape_left
                     .solid('left')
                     .part(ad.Part('left', 10))
                     .colour((1.0, 0.4, 1.0))
                     .at('centre_line'),
                     'face_centre', 'base', post=ad.ROTX_270)
        shape_right = self.extrude_right_node()
        maker.add_at(shape_right
                     .solid('right')
                     .part(ad.Part('right', 5))
                     .colour((1.0, 0.6, 1.0))
                     .at('centre_line'),
                     'face_centre', 'top', post=ad.ROTX_270)

        outer_cage_size = (cage_size[0] + 2 * self.t, cage_size[1] + 2 * self.t, cage_size[2])
        outer_cage_shape = ad.Box(outer_cage_size)
        outer_cage_maker = outer_cage_shape.solid('outer_cage').transparent(True).colour("cyan", 0.5).at('centre')
        maker.add_at(outer_cage_maker, 'cage', 'centre')
        
        screw_shape = self.screw_hole_node()
        
        for j in range(2):
            offset = -self.screw_offset if j == 0 else self.screw_offset
            for i, anchor in enumerate((('back', 1), ('back', 3))):
                screw_maker = screw_shape.composite(('screw', i, j)).at('top')
                maker.add_at(
                    screw_maker, 
                    'outer_cage', 'face_edge', *anchor, 
                    post=ad.translate((offset, self.t / 2, -self.bevel_r)) * ad.ROTX_180)
        
        
        mount_hole_shape = self.mount_hole_node()
        
        #print(f'mount_hole_offset: {self.mount_hole_offset}')
        for i in range(2):
            mount_hole_maker = mount_hole_shape.hole(('mount_hole', i)).at('base', post=ad.ROTZ_90)
            trans = -self.mount_hole_sep / 2 if i == 0 else self.mount_hole_sep / 2
            maker.add_at(
                mount_hole_maker, 
                'right', 'right', 0.5, rh=0.5, post=ad.translate((trans, self.mount_hole_offset, 0))
            )
            
        if self.split_left:
            split_size = (self.w - 2 * self.split_depth, self.t + self.epsilon, self.h + self.epsilon)
            split_shape = ad.Box(split_size)
            split_maker = split_shape.hole('split').colour("red", 0.5).at('face_edge', 'front', 0)
            maker.add_at(split_maker, 'left', 'left', 0.5)
        return maker
    
@ad.datatree
class HookSpacerPathBiulder:
    w: float = ad.dtfield(33.3, doc='Width of the spacer.')
    d: float = ad.dtfield(77.5, doc='Height of the spacer.')
    
    def build(self) -> ad.Path:
        
        linear_edge_len = self.d - self.w
        
        r = self.w / 2
        
        builder = ad.PathBuilder()
        builder.move((-r, 0))
        builder.line((-r, linear_edge_len / 2), 'upper_left')
        builder.arc_tangent_radius_sweep(r, -180, side=False, name='upper_arc')
        builder.line((r, 0), 'upper_right')
        builder.line((r, -linear_edge_len / 2), 'lower_right')
        builder.arc_tangent_radius_sweep(r, -180, side=False, name='lower_arc')
        builder.line((-r, 0), 'lower_left')
        
        with builder.construction() as construct:
            construct.move((0, -linear_edge_len / 2 -r))
            construct.line((0, linear_edge_len / 2 + r), 'centre_line')
        
        return builder.build()
    
@ad.shape
@ad.datatree
class HookSpacer(ad.CompositeShape):
    path_node: ad.Node[HookSpacerPathBiulder] = ad.ShapeNode(HookSpacerPathBiulder)
    path: ad.Path = ad.dtfield(self_default=lambda s: s.path_node().build())
    h: float = ad.dtfield(30, doc='Height of the spacer.')
    extrude_node: ad.ShapeNode[ad.LinearExtrude]
    
    mount_hole_sep: float = ad.dtfield((43.23 + 53.39) / 2, doc='Separation of the mount holes.')
    
    t: float = ad.dtfield(3, doc='Thickness of the cavity wallS')
    base_t: float = ad.dtfield(6, doc='Thickness of the base.')
    cavity_size: tuple[float, float, float] = ad.dtfield(
        self_default=lambda s: (s.w - 2 * s.t, 40, s.h - s.base_t), doc='Size of the cavity.')
    cavity_bevel_radius: float = ad.dtfield(6, doc='Radius of the bevels on the cavity.')
    cavity_node: ad.ShapeNode[BoxSideBevels] = ad.ShapeNode(BoxSideBevels, prefix='cavity_')
    
    base_mount_hole_r: float = ad.dtfield(4.3 / 2, doc='Radius of the mount hole in the base.')
    base_mount_hole_h: float = ad.dtfield(self_default=
        lambda s: s.base_t + 2 * s.epsilon, doc='Height of the base mount hole in the base.')
    base_mount_hole_node: ad.ShapeNode[ad.Cylinder] = ad.ShapeNode(ad.Cylinder, prefix='base_mount_hole_')
    base_mount_hole_sep: float = ad.dtfield(
        self_default=lambda s: s.cavity_size[1] - 10, doc='Separation of the mount holes in the base.')
    
    mount_hole_r: float = ad.dtfield(4.1 / 2, doc='Radius of the mount hole in the top.')
    mount_hole_h: float = ad.dtfield(25, doc='Height of the mount hole in the top.')
    mount_hole_node: ad.ShapeNode[ad.Cylinder] = ad.ShapeNode(ad.Cylinder, prefix='mount_hole_')
    
    epsilon: float = ad.dtfield(0.01, doc='Epsilon value for the bracket.')
    
    EXAMPLE_SHAPE_ARGS=ad.args(fn=64)
    
    def build(self) -> ad.Maker:
        shape = self.extrude_node()
        maker = shape.solid('spacer').at('centre_line', 0.5, post=ad.ROTX_90)
        
        cavity_shape = self.cavity_node()
        maker.add_at(
            cavity_shape.hole('cavity').colour("red").at('face_centre', 'top'),
            'centre_line', 0.5,
            post=ad.tranY(-self.epsilon) * ad.ROTX_90 * ad.ROTZ_90)
    
        base_mount_hole_shape = self.base_mount_hole_node()
        for i in range(2):
            trans = -self.base_mount_hole_sep / 2 if i == 0 else self.base_mount_hole_sep / 2
            maker.add_at(
                base_mount_hole_shape.hole(('base_mount_hole', i))
                    .colour("blue").at('base', post=ad.tranZ(-self.epsilon)),
                'centre_line', 0.5, rh=1,
                post=ad.tranX(trans) * ad.ROTX_270)
            
        mount_hole_shape = self.mount_hole_node()
        for i in range(2):
            trans = -self.mount_hole_sep / 2 if i == 0 else self.mount_hole_sep / 2
            maker.add_at(
                mount_hole_shape.hole(('mount_hole', i))
                    .colour("green").at('base', post=ad.tranZ(-self.epsilon)),
                'centre_line', 0.5,
                post=ad.tranX(trans) * ad.ROTX_270 * ad.tranZ(self.mount_hole_h / 2))
        return maker

# Uncomment the line below to default to writing OpenSCAD files
# when anchorscad_main is run with no --write or --no-write options.
MAIN_DEFAULT = ad.ModuleDefault(all=True)

if __name__ == '__main__':
    ad.anchorscad_main()
