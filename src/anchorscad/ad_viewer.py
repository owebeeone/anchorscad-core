import importlib
from typing import Callable
from pythonopenscad.posc_main import posc_main, PoscMainRunner
import pythonopenscad as posc
from anchorscad import Shape, render


def make_poscbase(
    shape_clz: type[Shape], example_name: str = "default"
) -> Callable[[], posc.PoscBase]:
    """
    Convert an Anchorscad shape to a PythonOpenSCAD object.
    """
    maker, shape = shape_clz.example(example_name)

    def make_poscbase():
        result = render(maker)
        return result.rendered_shape

    return make_poscbase


def main():
    runner = PoscMainRunner(items=None, script_path=None)

    runner.parser.add_argument(
        "--example", type=str, default="default", help="The example name to use for the shape."
    )

    runner.parser.add_argument(
        "--module", type=str, default="anchorscad", help="The module name to import the shape from."
    )

    runner.parser.add_argument(
        "--shape", type=str, default="AnnotatedCoordinates", help="The shape class name to use."
    )

    args = runner.args

    module = importlib.import_module(args.module)
    shape_clz = getattr(module, args.shape)
    posc_maker = make_poscbase(shape_clz, args.example)
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
        sys.argv = [
            sys.argv[0],
            "--module",
            "anchorscad",
            "--shape",
            "AnnotatedCoordinates",
            "--example",
            "default",
        ]
    main()
