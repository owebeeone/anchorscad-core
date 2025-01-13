# Installing AnchorSCAD

AnchorSCAD comes in two version, one is the core library (anchorscad-core) with a set of models that can be used to build other models. The other is the full AnchorSCAD package that includes the core library and a broader set of models.

To install AnchorSCAD from PyPI use the following command:
```
pip install anchorscad
```

To install the core AnchorSCAD package use the following command:
```
pip install anchorscad-core
```
You will also need to install the following non [PyPi PIP](https://pypi.org/project/pip/) packages:

- [Python](https://www.python.org/) 3.10 or higher
- [OpenSCAD](https://openscad.org/) 2021.01 or higher - Reccomend using a 2025 Development Snapshot for way better performance.
- [Graphviz](https://graphviz.org/) 2.30.2 or higher (likely works with earlier versions)

If you want to run it from source, you will to clone the [AnchorSCAD-Core Github](https://github.com/owebeeone/anchorscad-core.git) repository and install the dependencies.

This software is provided under the terms of the LGPL V2.1 license. See the [License](#_f2cn9t1bbfvs) section in this document for more information.

# Requirements if Sunning from Source
All the required PIP packages are provided in the [requirements.txt](https://github.com/owebeeone/anchorscad/blob/master/src/anchorscad/requirements.txt) in the [AnchorSCAD Github](https://github.com/owebeeone/anchorscad.git) repository.

[Git](https://git-scm.com/) is also required for downloading the [AnchorSCAD](https://github.com/owebeeone/anchorscad.git) repositories and also for contributing any models to [AnchorSCAD](https://github.com/owebeeone/anchorscad.git)‘s anchorcad_models package or bug fixes or improvements.

It is highly recommended that a Python IDE be used. While not endorsing any IDE in particular, I have  VS Code work sufficiently well. An old fashioned simple editor and command line execution of shape modules may be used if that is a preference.

## Linux (Debian, Ubuntu, Raspberry Pi OS)

On Linux (Debian, Ubuntu, Raspberry Pi etc based distros), the following commands pasted into a terminal running bash should result in a working environment.

```
sudo apt install openscad graphviz python3 git
mkdir -p ~/git
cd ~/git

# Either install the core library or the full package
- git clone https://github.com/owebeeone/anchorscad-core.git ; cd anchorscad-core
# OR
git clone https://github.com/owebeeone/anchorscad.git ; cd anchorscad

pip3 install -r src/anchorscad*/requirements.txt
```

## Windows
Download and install the latest versions of:

- [Python](https://www.python.org/) 3.9 or higher
- [OpenSCAD](https://openscad.org/) 2021.01 or higher - Use the 2023.12.22 Development Snapshot for better performance.
- [Graphviz](https://graphviz.org/) 2.30.2 or higher (likely works with earlier versions)

After installing those packages, start a new “cmd” shell terminal and run the following:

```
cd %USERPROFILE%
mkdir git   # Don’t run if the git directory already exists.
cd git
REM Either install the core library or the full package
- git clone https://github.com/owebeeone/anchorscad-core.git
- cd anchorscad-core
REM OR OR
git clone https://github.com/owebeeone/anchorscad.git
cd anchorscad

pip3 install -r src/anchorscad*/requirements.txt
```
 
## Testing The Installation
To verify that it is installed you can run a module like so:
```
	python3 -m anchorscad.extrude
```
This will run the module and either print a summary of the results or depending on the module settings, create output files in `examples_out`.

Or you can run a longer test where every shape is run and images of all example shapes are created.

```
python3 -m anchorscad.runner.anchorscad\_runner <folder to recursively search for modules>
```

If you want to browse the generated files, you can start a web server to view the files in your browser.

```
python3 -m anchorscad.runner.anchorscad\_runner <folder to recursively search for modules> --browse
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

