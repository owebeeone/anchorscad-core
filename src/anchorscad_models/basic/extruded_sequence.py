'''
Created on 2025-05-12

@author: gianni
'''

from abc import ABC, abstractmethod
from typing import Any
import anchorscad as ad


class SequenceItem(ABC):
    @abstractmethod
    def extrusion(self) -> ad.Shape:
        pass
    
    @abstractmethod
    def transform_path(self, path: ad.Path, m: ad.GMatrix) -> ad.Path:
        pass
    
    @abstractmethod
    def anchor_adjust(self) -> ad.GMatrix:
        pass
    
    def get_extrude_path(self, path: ad.Path) -> ad.Path:
        if self.path_xform or self.anchor:
            m: ad.GMatrix = self.path_xform if self.path_xform else ad.IDENTITY
            if self.anchor:
                m = m * self.anchor.apply_to_path(path).I
            
            return self.transform_path(path, m)
        return path

@ad.datatree
class RotateSequenceItem(SequenceItem):
    r: float
    angle: float = 0
    anchor: ad.PathAnchor | None = None
    path_xform: ad.GMatrix | None = None
    node: ad.ShapeNode[ad.RotateExtrude] = ad.ShapeNode(
        ad.RotateExtrude, 
        {'path_fn': 'path_fn', 'use_polyhedrons' : 'use_polyhedrons'}, 
        exclude={'path', 'angle'}, 
        prefix='rex_', 
        expose_all=True)
    
    def transform_path(self, path: ad.Path, m: ad.GMatrix) -> ad.Path:
        return path.transform_for_rotate_extrude(m, radius=self.r)

    def extrusion(self, path: ad.Path) -> ad.Shape:
        extrude_path = self.get_extrude_path(path)
        return self.node(path=extrude_path, angle=self.angle)
    
    def anchor_adjust(self) -> ad.GMatrix:
        return ad.IDENTITY

@ad.datatree
class LinearSequenceItem(SequenceItem):
    h: float = 0
    anchor: ad.PathAnchor | None = None
    path_xform: ad.GMatrix | None = None
    node: ad.ShapeNode[ad.LinearExtrude] = ad.ShapeNode(
        ad.LinearExtrude,
        {'path_fn': 'path_fn', 'use_polyhedrons' : 'use_polyhedrons'}, 
        exclude={'path', 'h'}, expose_all=True, prefix='lex_')

    def extrusion(self, path: ad.Path) -> ad.Shape:
        extrude_path = self.get_extrude_path(path)
        return self.node(path=extrude_path, h=self.h)
    
    def transform_path(self, path: ad.Path, m: ad.GMatrix) -> ad.Path:
        return path.transform(m)
    
    def anchor_adjust(self) -> ad.GMatrix:
        return ad.IDENTITY
    
@ad.datatree
class ExtrudedSequenceBuilder:
    '''
    Builds an extruded sequence.
    '''
    items: list[SequenceItem] = ad.field(default_factory=list)
    lnode: ad.ShapeNode[LinearSequenceItem] = \
        ad.ShapeNode(LinearSequenceItem, exclude={'h', 'anchor'})
    rnode: ad.ShapeNode[RotateSequenceItem] = \
        ad.ShapeNode(RotateSequenceItem, exclude={'r', 'anchor'})
    
    def linear(self, 
               h: float, 
               anchor: ad.PathAnchor | None = None, 
               path_xform: ad.GMatrix | None = None,
               **kwargs) -> 'ExtrudedSequenceBuilder':
        item = self.lnode(h, anchor, path_xform, **kwargs)
        self.items.append(item)
        return self
    
    def rotate(self, 
               r: float, 
               angle: ad.Angle | float, 
               anchor: ad.PathAnchor | None = None, 
               path_xform: ad.GMatrix | None = None,
               **kwargs) -> 'ExtrudedSequenceBuilder':
        item = self.rnode(r, angle, anchor, path_xform, **kwargs)
        self.items.append(item)
        return self
    
    def reset(self) -> 'ExtrudedSequenceBuilder':
        self.items = []
        return self
    
    def build(self) -> tuple[SequenceItem, ...]:
        assert len(self.items) > 0, 'No items to build'
        return tuple(self.items)

@ad.shape
@ad.datatree
class ExtrudedSequence(ad.CompositeShape):
    '''
    Given a path, creates a sequence of extruded shapes.
    '''
    path: ad.Path
    
    sequence: tuple[SequenceItem, ...]
    
    EXAMPLE_SHAPE_ARGS=ad.args(
        path = (ad.PathBuilder()
            .move((0, 0))
            .line((10, 0), 'line1')
            .spline(((10, 10), (10, 8), (0, 8)), name='spline1', cv_len=(15, 1))
            .line((0, 0), 'line2')
            .build()),
        sequence=ExtrudedSequenceBuilder(fn=16, path_fn=8, use_polyhedrons=False)
            .linear(11, anchor=ad.PathAnchor.anchor('line1', t=0.5), path_xform=ad.scale(1))
            .rotate(r=5, angle=ad.angle(60), anchor=ad.PathAnchor.anchor('line1', t=0.5))
            .rotate(r=25, angle=ad.angle(90), fn=64,anchor=ad.PathAnchor.anchor('spline1', t=0.25))
            .linear(11, anchor=ad.PathAnchor.anchor('line1', t=0.5))
            .linear(11, anchor=ad.PathAnchor.anchor('spline1', t=0.25))
            .linear(11, anchor=ad.PathAnchor.anchor('line1', t=0.75))
            .rotate(r=25, 
                    angle=ad.angle(90), 
                    anchor=ad.PathAnchor.anchor('spline1', t=0.5), 
                    path_xform=ad.ROTZ_180,
                    fn=64)
            .build()
        )
    EXAMPLE_ANCHORS=(
        ad.surface_args(('item', 0), 'path_op', 2, 0.5, ex_end=True, linear_compat=True),
        ad.surface_args(('item', 1), 'path_op', 2, 0.5, ex_end=False, linear_compat=True),
        )

    def build(self) -> ad.Maker:
        item0 = self.sequence[0]
        shape0 = item0.extrusion(self.path)
        last_item_name = ('item', 0)
        maker = shape0.solid(last_item_name).at('path_op', linear_compat=True,post=item0.anchor_adjust())

        for n, item in enumerate(self.sequence[1:]):
            shape = item.extrusion(self.path)
            this_item_name = ('item', n + 1)

            this_maker = shape.solid(this_item_name).at(
                'path_op', ex_end=False, linear_compat=True)
            
            maker.add_at(this_maker, 
                         last_item_name, 'path_op', ex_end=True, linear_compat=True)
            last_item_name = this_item_name
        
        return maker

@ad.shape
@ad.datatree
class TestExtrusionAnchors(ad.CompositeShape):
    '''
    Given a path, creates a sequence of extruded shapes.
    '''
    path: ad.Path
    h: float
    ex_node: ad.ShapeNode[ad.LinearExtrude]
    
    EXAMPLE_SHAPE_ARGS=ad.args(
        h=10,
        #angle=ad.angle(60),
        path = (ad.PathBuilder()
            .move((0, 0))
            .line((10, 0), 'line1')
            .spline(((10, 10), (10, 10), (0, 10)), name='spline1', cv_len=(10, 3))
            .line((0, 0), 'line2')
            .build()),
        )
    EXAMPLE_ANCHORS=(
        ad.surface_args('test', 'spline1', 0.5, ex_end=True, linear_compat=True),
        )    
    def build(self) -> ad.Maker:
        #path = self.path.transform_for_rotate_extrude(ad.rotZ(45), radius=5)
        path = self.path.transform(ad.rotZ(45))
        shape = self.ex_node(path=path)
        maker = shape.solid('test').at('line1', 0.5, ex_end=False, linear_compat=True)
        return maker

# Uncomment the line below to default to writing OpenSCAD files
# when anchorscad_main is run with no --write or --no-write options.
MAIN_DEFAULT=ad.ModuleDefault(all=2, write_stl_mesh_files=False)

if __name__ == "__main__":
    ad.anchorscad_main()
