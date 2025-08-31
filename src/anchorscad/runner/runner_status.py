'''
Created on 22 Jan 2022

@author: gianni
'''

from collections import defaultdict
from dataclasses import dataclass, field
from dataclasses_json import dataclass_json
from typing import Optional

@dataclass_json
@dataclass
class SourceRepo:
    """A dataclass to hold Git repository information for a file."""
    repo_name: Optional[str]=None
    commit_id: Optional[str]=None
    file_path_in_repo: Optional[str]=None
    service: Optional[str]=None
    origin: Optional[str]=None
    is_on_origin: Optional[bool]=False

    def get_url(self, line_number: Optional[int] = None) -> str:
        """
        Generates a URL to the file in the repository.

        Args:
            line_number (Optional[int]): An optional line number to include in the URL.

        Returns:
            str: The fully-formed URL to the file, and optionally to a specific line.
                 Returns a message if the git service is not supported.
        """
        base_url = ""
        line_suffix = ""

        if self.service == 'github':
            base_url = f"https://github.com/{self.repo_name}/blob/{self.commit_id}{self.file_path_in_repo}"
            if line_number:
                line_suffix = f"#L{line_number}"
        elif self.service == 'gitlab':
            base_url = f"https://gitlab.com/{self.repo_name}/-/blob/{self.commit_id}{self.file_path_in_repo}"
            if line_number:
                line_suffix = f"#L{line_number}"
        elif self.service == 'bitbucket':
            base_url = f"https://bitbucket.org/{self.repo_name}/src/{self.commit_id}{self.file_path_in_repo}"
            if line_number:
                line_suffix = f"#lines-{line_number}"
        else:
            return f"Unsupported Git service: {self.service}"

        return base_url + line_suffix

    def get_raw_url(self) -> str:
        """
        Generates the raw content URL for the file, suitable for HTTP GET requests.

        Returns:
            str: The raw content URL or an error message if the service is not supported.
        """
        if self.service == 'github':
            return f"https://raw.githubusercontent.com/{self.repo_name}/{self.commit_id}{self.file_path_in_repo}"
        elif self.service == 'gitlab':
            return f"https://gitlab.com/{self.repo_name}/-/raw/{self.commit_id}{self.file_path_in_repo}"
        elif self.service == 'bitbucket':
            # Note: Bitbucket's raw URL is often the same as its src URL, but this is more explicit.
            return f"https://bitbucket.org/{self.repo_name}/raw/{self.commit_id}{self.file_path_in_repo}"
        else:
            return f"Unsupported Git service for raw URL: {self.service}"

    def fetch_contents(self) -> Optional[str]:
        """
        Fetches the file contents from the remote repository via an HTTP request.

        This method requires the 'requests' library to be installed.

        Returns:
            Optional[str]: The text content of the file, or None if the request fails.
        
        Raises:
            ImportError: If the 'requests' library is not installed.
        """
        try:
            import requests
        except ImportError:
            # We make requests an optional dependency, only required for fetch_contents()
            requests = None
    
        if not requests:
            raise ImportError("The 'requests' library is required to fetch contents. Please install it with 'pip install requests'.")

        raw_url = self.get_raw_url()
        if raw_url.startswith('Unsupported'):
            print(f"Cannot fetch contents: {raw_url}")
            return None

        try:
            response = requests.get(raw_url)
            response.raise_for_status()  # Raise an exception for bad status codes (4xx or 5xx)
            return response.text
        except requests.exceptions.RequestException as e:
            print(f"Error fetching file contents from {raw_url}: {e}")
            return None

@dataclass_json
@dataclass
class RunnerExamplePartResults(object):
    '''
    Status type for a part of an example of a shape.
    '''
    part_name: Optional[str]=None # The part name.
    scad_file: Optional[str]=None
    stl_file: Optional[str]=None # The STL file.
    f3mf_file: Optional[str]=None # The 3MF file (possibly multi-part/material).
    png_file: Optional[str]=None # The PNG image file.
    openscad_err_file: Optional[str]=None # The OpenSCAD stderr file.
    openscad_out_file: Optional[str]=None # The OpenSCAD stdout file.


@dataclass_json
@dataclass
class RunnerExampleResults(object):
    '''
    Status type for an example of a shape.
    '''
    example_name: str
    error_str: str='' # '' indicates no error.
    output_file_name: Optional[str]=None # Python stdout of running the example.
    output_file_size: Optional[int]=None # Size of the output file.
    source_snippet_file: Optional[str]=None # The source snippet file.
    source_line_number: Optional[int]=None # The source line number.
    source_repo_path: Optional[str]=None # The source repository path.
    error_file_name: Optional[str]=None # Python stderr of running the example.
    error_file_size: Optional[int]=None # Size of the error file.
    scad_file: Optional[str]=None # The OpenSCAD file.
    stl_file: Optional[str]=None # The STL file.
    f3mf_file: Optional[str]=None # The 3MF file (possibly multi-part/material).
    png_file: Optional[str]=None # The PNG image file.
    openscad_err_file: Optional[str]=None # The OpenSCAD stderr file.
    openscad_out_file: Optional[str]=None # The OpenSCAD stdout file.
    graph_file: Optional[str]=None # The graphviz .dot file for the model.
    graph_svg_dot_file: Optional[str]=None # The graphviz .svg file for the model.
    graph_svg_file: Optional[str]=None
    path_html_file: Optional[str]=None # The HTML file for the 2D extrusion paths
    shape_pickle_file: Optional[str]=None # The pickled shape object.
    injected_fields_html_file: Optional[str]=None # The datatree field provenance HTML file.
    parts_model_files: dict[str, RunnerExamplePartResults]=field(
         default_factory=lambda : defaultdict(RunnerExamplePartResults))


@dataclass_json
@dataclass
class RunnerShapeResults(object):
    '''
    Status type for a shape class run.
    '''
    class_name: str
    examples_with_error_output_count: int=0
    example_results: list[RunnerExampleResults]=field(default_factory=list)


@dataclass_json
@dataclass
class RunnerModuleExampleRef(object):
    '''
    A reference to a module+example.
    '''
    module_name: str
    class_name: str
    example_name: str
    

@dataclass_json
@dataclass
class RunnerModuleStatus(object):
    '''
    Status type for a module run.
    '''
    module_name: str
    shape_results: list[RunnerShapeResults]
    examples_with_error_output: list[RunnerModuleExampleRef]
    exit_status: Optional[int]=None
    incomplete: bool=False
    module_load_error: list[str]=None
    source_repo: Optional[SourceRepo]=None
    source_file: Optional[str]=None  # The source file copy if not in repo.
 
@dataclass_json
@dataclass
class RunnerStatus(object):
    '''
    Status type for a complete run.
    '''
    dirs: list[str]
    elapsed_time: float
    module_status: list[RunnerModuleStatus]
    examples_with_error_output: list[RunnerModuleExampleRef]

   

@dataclass_json
@dataclass
class RunnerModuleStatus2(RunnerModuleStatus):
    other_thing: str=None


def main():
    
    example_part = RunnerExamplePartResults('part1', 'scad1', 'stl1', 'f3mf1', 'png1', 'oe1', 'oo1')
    
    sp = example_part.to_json(indent=4)
    example_part_1 = RunnerExamplePartResults.from_json(sp)
    
    example = RunnerModuleStatus(
        'mod_name',
        (RunnerShapeResults('shape1',               
            0,
            (RunnerExampleResults('ex_name11', 'sf', 'gf', 0, 'pf', 0, 'stl',
                parts_model_files={
                    'part1': RunnerExamplePartResults('part1', 'scad1', 'stl1', 'f3mf1', 'png1', 'oe1', 'oo1'),
                    'part2': RunnerExamplePartResults('part2', 'scad2', 'stl2', 'f3mf2', 'png2', 'oe2', 'oo2')}),
             RunnerExampleResults('ex_name12', 'sf', 'gf', 0, 'pf', 0, 'stl',
                parts_model_files={
                    'part1': RunnerExamplePartResults('part1', 'scad1', 'stl1', 'f3mf1', 'png1', 'oe1', 'oo1'),
                    'part2': RunnerExamplePartResults('part2', 'scad2', 'stl2', 'f3mf2', 'png2', 'oe2', 'oo2')}))),
        RunnerShapeResults('shape2', 
            0,
            (RunnerExampleResults('ex_name21', 'sf', 'gf', 0, 'pf', 0, 'stl'),
             RunnerExampleResults('ex_name22', 'sf', 'gf', 0, 'pf', 0, 'stl'))),
        ),
        examples_with_error_output=[],
        exit_status=0,
        incomplete=False,
        module_load_error=[],
    )

    s = example.to_json(indent=4)
    js = RunnerModuleStatus.from_json(s)

    print(s)
    print(js)
    print(js.to_json(indent=4))

if __name__ == "__main__":
    main()
