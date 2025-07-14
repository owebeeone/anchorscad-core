import importlib
from typing import Callable
from anchorscad.renderer import PartMaterial
from pythonopenscad.posc_main import posc_main, PoscMainRunner
import pythonopenscad as posc
from anchorscad import Shape, render, find_all_shape_classes


def make_poscbase(
    shape_clz: type[Shape], 
    example_name: str = "default",
    part_name: str = None,
    material_name: str = None
) -> Callable[[], posc.PoscBase]:
    """
    Convert an Anchorscad shape to a PythonOpenSCAD object.
    """
    try:
        maker, shape = shape_clz.example(example_name)
    except KeyError:
        if hasattr(shape_clz, 'EXAMPLES_EXTENDED'):
            available_examples = ['default'] + list(shape_clz.EXAMPLES_EXTENDED.keys())
        else:
            available_examples = ['default']
        raise ValueError(f"Example {example_name} not found in shape {shape_clz.__name__}. "
                         f"Available examples: {available_examples}")

    def make_model():
        result = render(maker)
        if part_name is None:
            shape = result.rendered_shape
        else:
            for name, physical in result.parts.keys():
                if name == part_name:
                    shape = result.parts[(name, physical)]
                    break
            else:
                raise ValueError(
                    f"Part {part_name} not found in rendered parts. "
                    f"Available parts: {[name for name, _ in result.parts.keys()]}, "
                    f"(Keys: {list(result.parts.keys())})"
                )
        if material_name is None:
            return shape
        
        modules = []
        materials = set()
        if isinstance(shape, posc.LazyUnion):
            for child in shape.children():
                part_material = child.getDescriptor()
                if isinstance(part_material, PartMaterial):
                    name = part_material.get_material().name
                    if name == material_name:
                        modules.append(child)
                    materials.add(name)
        if len(modules) == 0:
            raise ValueError(f"Material {material_name} not found in shape. "
                             f"Available materials: {materials}")

        return posc.LazyUnion()(*modules)
    return make_model


def main():
    runner = PoscMainRunner(items=None, script_path=None)

    runner.parser.add_argument(
        "--example", type=str, default="default", 
        help="The example name to use for the shape."
    )

    runner.parser.add_argument(
        "--module", type=str, default="anchorscad", 
        help="The module name to import the shape from."
    )

    runner.parser.add_argument(
        "--shape", type=str, default="AnnotatedCoordinates", 
        help="The shape class name to use."
    )
    
    runner.parser.add_argument(
        "--part", type=str, default=None, 
        help="The part name to use. If not provided, the part name will "
             "be the combined file containing all parts."
    )

    runner.parser.add_argument(
        "--material", type=str, default=None, 
        help="The material name to use. If not provided, all materials will be used."
    )

    args = runner.args

    module = importlib.import_module(args.module)
    try:
        shape_clz = getattr(module, args.shape)
    except AttributeError:
        print(f"Shape class {args.shape} not found in module {args.module}.", 
              file=sys.stderr)
        shape_names = [clz.__name__ for clz in find_all_shape_classes(module)]
        print(f"Available classes: {shape_names}", file=sys.stderr)
        raise

    posc_maker = make_poscbase(shape_clz, args.example, args.part, args.material)
    runner.items = [posc_maker]
    runner.script_path = module.__file__
    runner.run()


if __name__ == "__main__":
    import sys

    if len(sys.argv) == 1:
        pass
        # sys.argv = [
        #     sys.argv[0],
        #     "--module",
        #     "anchorscad",
        #     "--shape",
        #     "Sphere",
        #     "--example",
        #     "default",
        # ]
        # sys.argv = [
        #     sys.argv[0],
        #     "--module",
        #     "anchorscad_models.cases.rpi.rpi4",
        #     "--shape",
        #     "RaspberryPi4Case",
        #     "--example",
        #     "bottom",
        # ]
        # sys.argv = [
        #     sys.argv[0],
        #     "--module",
        #     "anchorscad.tests.multi_material_test",
        #     "--shape",
        #     "MultiMaterialTest",
        #     "--example",
        #     "default",
        #     "--part",
        #     "default",
        #     "--material",
        #     "sphere",
        # ]       
        sys.argv = [
            sys.argv[0],
            "--module",
            "anchorscad_models.multimaterial.mm_test1",
            "--shape",
            "MultiMaterialTest",
            "--example",
            "default",
            "--part",
            "part0",
            # "--material",
            # "mat2",
        ]
        # sys.argv = [
        #     sys.argv[0],
        #     "--module",
        #     "anchorscad",
        #     "--shape",
        #     "LinearExtrude",
        #     "--example",
        #     "default",
        #     # "--part",
        #     # "default",
        # ]
    main()
