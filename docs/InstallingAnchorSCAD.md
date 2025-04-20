# Installing AnchorSCAD

AnchorSCAD comes in two versions, one is the core library (`anchorscad-core`) with a set of base shapes and utilities, and the other is the full AnchorSCAD package (`anchorscad`) that includes the core library and a broader set of models.

To install the **core library** from PyPI use the following command:
```
pip install anchorscad-core
```
(Note: The full `anchorscad` package including additional models might not be available on PyPI; check the project repository for installation instructions if needed.) Anchorscad-core package contains all the `anchorscad` tools so in most cases, the yet to be released [`anchorscad`](https://github.com/owebeeone/anchorscad) package is not necessary.

You will also need the following prerequisites:

-   **[Python](https://www.python.org/) 3.10 or higher**
-   **(Optional) [OpenSCAD](https://openscad.org/)**: Required *only* if you need to render 
`.scad` files or use OpenSCAD features not yet supported by [PythonOpenSCAD](https://github.com/owebeeone/pythonopenscad). AnchorSCAD can generate meshes directly. If installing OpenSCAD, the a recent development snapshot is recommended (the latest release version from 2021 is no longer reccomended). For multi-part/material `.3mf` export, you need a version with the experimental **`lazy-union`** feature enabled (typically a recent development snapshot).
-   **(Optional) [Graphviz](https://graphviz.org/)**: Required *only* if you want to generate `.dot` or `.svg` graph visualizations of your model hierarchy using `anchorscad_main --graph_write` or `--svg_write`. Highly reccomended though.

AnchorSCAD uses [PythonOpenSCAD](https://github.com/owebeeone/pythonopenscad.git) which leverages the `manifold3d` library to generate meshes directly. This allows viewing models using the built-in `ad_viewer` without needing OpenSCAD installed. See the main [README section on `ad_viewer`](../README.md#viewing-models-with-ad_viewer) for details.

If you want to run from source, you will need to clone the appropriate GitHub repository (`anchorscad-core` or `anchorscad`) and install the dependencies listed in `pyproject.toml`.

This software is provided under the terms of the LGPL V2.1 license. See the [License](#_f2cn9t1bbfvs) section in this document for more information.

# Requirements if Running from Source
All the required PIP packages are provided in the `pyproject.toml` file within the respective source repository (e.g., [anchorscad/pyproject.toml](https://github.com/owebeeone/anchorscad-core/blob/main/pyproject.toml) - ensure you are looking at the correct repository and branch).

[Git](https://git-scm.com/) is also required for cloning the source repositories.

It is highly recommended that a Python IDE be used. While not endorsing any IDE in particular, I have  VS Code work sufficiently well. An old fashioned simple editor and command line execution of shape modules may be used if that is a preference.

## Linux (Debian, Ubuntu, Raspberry Pi OS)

On Linux (Debian, Ubuntu, Raspberry Pi etc based distros), the following commands pasted into a terminal running bash should result in a working environment. Adjust package names (`openscad`, `graphviz`) if needed for your distribution, and remember they are optional depending on your needs.

```bash
sudo apt update
# Install prerequisites (OpenSCAD/Graphviz are optional)
sudo apt install python3 python3-pip git [openscad] [graphviz]

mkdir -p ~/git
cd ~/git

# Clone the desired repository (core or full)
# git clone https://github.com/owebeeone/anchorscad-core.git ; cd anchorscad-core
# OR
git clone https://github.com/owebeeone/anchorscad.git ; cd anchorscad

# Install Python dependencies
pip3 install .
```

## Windows
Download and install the latest versions of:

-   [Python](https://www.python.org/) 3.10 or higher
-   (Optional) [OpenSCAD](https://openscad.org/) - Latest stable release or development snapshot (see notes above).
-   (Optional) [Graphviz](https://graphviz.org/)

Ensure Python and pip are added to your system's PATH during installation.

After installing prerequisites, start a new Command Prompt (`cmd`) or PowerShell terminal and run the following:

```
cd %USERPROFILE%
mkdir git   # Don't run if the git directory already exists.
cd git
REM Either install the core library or the full package
- git clone https://github.com/owebeeone/anchorscad-core.git
- cd anchorscad-core
REM OR OR
git clone https://github.com/owebeeone/anchorscad.git
cd anchorscad

REM Install dependencies defined in pyproject.toml
pip install .
REM For development including testing tools, use:
REM pip install -e ".[dev]"
```
 
## Testing The Installation
To verify the core functionality, you can try rendering a built-in example module using `anchorscad_main`:
```bash
python -m anchorscad.core --shape Box --write
```
This will run the default example for the `Box` shape and create output files (like `.scad`, `.stl`) in the `examples_out` directory (because of `--write`).

To test the direct mesh viewing capability (requires necessary dependencies installed, like `manifold3d` and a viewer backend):
```bash
python -m anchorscad.ad_viewer --module anchorscad --shape Box
```
This should open a window displaying the default Box example.

You can also run a longer test across multiple modules using the runner:

```bash
python -m anchorscad.runner.anchorscad_runner <folder_to_scan>
```
(Replace `<folder_to_scan>` with the path to your AnchorSCAD models, e.g., `src/anchorscad` if running from a source clone).

To browse the generated files from the runner in a local web server:

```bash
python -m anchorscad.runner.anchorscad_runner <folder_to_scan> --browse
```

The generated files will reside in a folder named `generated` in the folder you ran the command from.

# Running AnchorSCAD Modules


You can now check out the [Quick Start](https://docs.google.com/document/u/0/d/1p-qAE5oR-BQ2jcotNhv5IGMNw_UzNxbYEiZat76aUy4/edit) instructions to start building your models.

# License
[AnchorSCAD](https://github.com/owebeeone/anchorscad.git) is available under the terms of the [GNU LESSER GENERAL PUBLIC LICENSE](https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html#SEC1).

Copyright (C) 2022 Gianni Mariani

[AnchorSCAD](https://github.com/owebeeone/anchorscad.git) and [PythonOpenScad](https://github.com/owebeeone/pythonopenscad.git) is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

