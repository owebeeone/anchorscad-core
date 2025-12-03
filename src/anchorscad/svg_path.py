'''
SVG Path Import Module

Imports SVG path data into AnchorSCAD Path objects.
Supports SVG transforms, coordinate system conversion, and unit handling.
'''

from abc import ABC, abstractmethod
from pathlib import Path
from typing import IO, Union
import math
import re
import logging
from xml.etree import ElementTree as ET

from datatrees import datatree, dtfield
import anchorscad_lib.linear as l
from anchorscad_lib.linear import GMatrix, GVector, IDENTITY, translate, scale, rotZ
import numpy as np

from anchorscad.extrude import PathBuilder, Path as ExtrudePath, LinearExtrude
import anchorscad.core as core
from svgpathtools import parse_path, Path as SVGPath, Line, CubicBezier, QuadraticBezier, Arc

# Set up logging
logger = logging.getLogger(__name__)


class SVGParseError(Exception):
    """Raised when SVG parsing fails."""
    pass


class SVGErrorHandler(ABC):
    """Abstract base class for handling SVG import errors and warnings."""
    
    @abstractmethod
    def handle_unsupported_element(self, element_name: str, element_attrs: dict) -> None:
        """Called when encountering an unsupported SVG element (e.g., <text>, <image>)."""
        pass
    
    @abstractmethod
    def handle_unsupported_path_command(self, command: str, params: list) -> None:
        """Called when encountering an unsupported path command."""
        pass
    
    @abstractmethod
    def handle_malformed_path_data(self, path_id: str | None, element_id: str | None, error: Exception) -> None:
        """Called when path data cannot be parsed."""
        pass
    
    @abstractmethod
    def handle_arc_approximation(self, path_id: str | None, reason: str) -> None:
        """Called when an elliptical arc must be approximated with Bezier curves."""
        pass
    
    @abstractmethod
    def handle_missing_size_info(self, used_bounds: tuple[float, float]) -> None:
        """Called when SVG lacks viewBox/width/height and bounds are calculated from paths."""
        pass
    
    @abstractmethod
    def handle_transform_error(self, transform_str: str, error: Exception) -> None:
        """Called when a transform attribute cannot be parsed."""
        pass


class DefaultSVGErrorHandler(SVGErrorHandler):
    """Default error handler that logs warnings and continues processing."""
    
    def handle_unsupported_element(self, element_name: str, element_attrs: dict) -> None:
        logger.warning(f"Unsupported SVG element: <{element_name}>, skipping")
    
    def handle_unsupported_path_command(self, command: str, params: list) -> None:
        logger.warning(f"Unsupported path command: {command} with params {params}")
    
    def handle_malformed_path_data(self, path_id: str | None, element_id: str | None, error: Exception) -> None:
        path_str = f" (id={path_id})" if path_id else ""
        logger.warning(f"Malformed path data{path_str}: {error}, skipping")
    
    def handle_arc_approximation(self, path_id: str | None, reason: str) -> None:
        path_str = f" (id={path_id})" if path_id else ""
        logger.info(f"Approximating elliptical arc{path_str}: {reason}")
    
    def handle_missing_size_info(self, used_bounds: tuple[float, float]) -> None:
        logger.info(f"SVG lacks size info, using calculated bounds: {used_bounds}")
    
    def handle_transform_error(self, transform_str: str, error: Exception) -> None:
        logger.warning(f"Transform parse error for '{transform_str}': {error}, using identity")


def _parse_svg_unit(value: str, dpi: float) -> float:
    """Parse SVG unit string and convert to AnchorSCAD units."""
    if not value or value == 'none':
        return 0.0
    
    # Remove whitespace
    value = value.strip()
    
    # Try to parse as number first
    try:
        return float(value)
    except ValueError:
        pass
    
    # Parse unit suffix
    unit_match = re.match(r'^([+-]?\d*\.?\d+(?:[eE][+-]?\d+)?)\s*([a-zA-Z%]+)?$', value)
    if not unit_match:
        raise ValueError(f"Invalid unit format: {value}")
    
    num_str, unit = unit_match.groups()
    num = float(num_str)
    
    if unit is None or unit == 'px':
        return num
    elif unit == 'in':
        return num * dpi
    elif unit == 'cm':
        return num * dpi / 2.54
    elif unit == 'mm':
        return num * dpi / 25.4
    elif unit == 'pt':
        return num * dpi / 72.0
    elif unit == 'pc':
        return num * dpi / 6.0
    elif unit == 'em' or unit == 'ex':
        # Default to 12pt font size
        return num * dpi / 72.0 * 12.0
    elif unit == '%':
        # Percentage - will need context to resolve
        return num / 100.0
    else:
        raise ValueError(f"Unsupported unit: {unit}")


def _parse_viewbox(viewbox_str: str) -> tuple[float, float, float, float] | None:
    """Parse SVG viewBox attribute."""
    if not viewbox_str:
        return None
    
    try:
        parts = viewbox_str.strip().split()
        if len(parts) == 4:
            return tuple(float(x) for x in parts)
    except (ValueError, AttributeError):
        pass
    
    return None


def _target_transform(extents: np.array, target: np.array) -> GMatrix:
    """
    Calculate a transform to scale and translate the extents to the target bounds
    maintaining the aspect ratio of the extents.
    
    extents is a 2x2 array of the extents of the path. (min point, max point)
    target is a 2x2 array of the target bounds. (min point, max point)
    
    Returns a GMatrix that can be used to transform the extents to the target bounds
    but keeping the aspect ratio of the extents. One dimension will be scaled to fit 
    the target while the other dimension will be scaled to maintain the aspect ratio.
    """
    size = extents[1] - extents[0]
    aspect = size[0] / size[1]
    target_size = target[1] - target[0]
    target_aspect = target_size[0] / target_size[1]
    
    if aspect > target_aspect:
        scale_v = target_size[0] / size[0]
    else:
        scale_v = target_size[1] / size[1]
    
    centre = np.mean(extents, axis=0)
    target_centre = np.mean(target, axis=0)
    
    return translate((target_centre[0], target_centre[1], 0)) * scale(scale_v) * translate((-centre[0], -centre[1], 0))


@datatree
class SVGPathImporter:
    """
    Imports SVG paths into AnchorSCAD Path objects.
    Maintains state for transform stack, error handling, and coordinate conversion.
    """
    
    error_handler: SVGErrorHandler = dtfield(
        default_factory=lambda: DefaultSVGErrorHandler(),
        doc='Error handler for unsupported elements and malformed data'
    )
    target_bounds: tuple[float, float] | None = dtfield(
        default=None,
        doc='Optional (width, height) tuple for scaling when SVG lacks size info'
    )
    dpi: float = dtfield(
        default=96.0,
        doc='Dots per inch for unit conversion (default: 96.0, standard web DPI)'
    )
    
    # Fields set during processing (init=False)
    path_builder: PathBuilder = dtfield(
        default_factory=lambda: PathBuilder(multi=True),
        init=False,
        doc='PathBuilder instance for constructing the Path object'
    )
    transform_stack: list[GMatrix] = dtfield(
        default_factory=lambda: [IDENTITY],
        init=False,
        doc='Stack of accumulated transforms from nested <g> elements'
    )
    coord_transform: GMatrix | None = dtfield(
        default=None,
        init=False,
        doc='Final coordinate system transformation (Y-flip, viewBox, scaling)'
    )
    svg_root: ET.Element | None = dtfield(
        default=None,
        init=False,
        doc='Parsed SVG root element'
    )
    view_box: tuple[float, float, float, float] | None = dtfield(
        default=None,
        init=False,
        doc='SVG viewBox as (x, y, width, height) tuple'
    )
    svg_size: tuple[float, float] | None = dtfield(
        default=None,
        init=False,
        doc='SVG size as (width, height) tuple'
    )
    element_no: int = dtfield(
        default=0,
        init=False,
        doc='Identifier for the element being imported (if not provided)'
    )
    path_no: int = dtfield(
        default=0,
        init=False,
        doc='Path item number'
    )
    
    def import_svg(
        self,
        svg_input: str | Path | IO[str],
        path_id: str | None = None
    ) -> ExtrudePath:
        """
        Main entry point: imports SVG and returns Path object.
        
        Resets processing state and imports the SVG.
        
        Args:
            svg_input: SVG content (string, file path, or file-like object)
            path_id: Optional path element ID to import (None = all paths)
        
        Returns:
            Path object with imported paths
        """
        # Reset processing state
        self.path_builder = PathBuilder(multi=True)
        self.transform_stack = [IDENTITY]
        self.coord_transform = None
        self.svg_root = None
        self.view_box = None
        self.svg_size = None
        self.element_no = 0
        
        # Parse SVG structure
        self.svg_root = self._parse_svg(svg_input)
        
        # Extract SVG metadata (viewBox, size, etc.)
        self._extract_svg_metadata()
        
        # Build coordinate system transformation
        self._build_coordinate_transform()
        
        # Process SVG elements
        self._process_element(self.svg_root, path_id)
        
        # Add construction to the path to make it easier to attach to other shapes.
        path: ExtrudePath = self.path_builder.build()
        extents = np.array(path.extents())
        centre = np.mean(extents, axis=0)
        with self.path_builder.construction() as cb:
            cb.move(extents[0])
            cb.line((extents[1][0], extents[0][1]), name=(path_id, 'base'))
            cb.line(extents[1], name=(path_id, 'rhs'))
            cb.line((extents[0][0], extents[1][1]), name=(path_id, 'top'))
            cb.line(extents[0], name=(path_id, 'lhs'))
            
            cb.move(centre, name=(path_id, 'centre'))
            cb.line((centre[0], extents[1][1]), name=(path_id, 'centre_up'))
            cb.move(centre)
            cb.line((extents[1][0], centre[1]), name=(path_id, 'centre_rhs'))
            
        result_path = self.path_builder.build()
        
        target_extents = self.get_target_extents()
        if target_extents is not None:
            target_transform = _target_transform(extents, target_extents)
            result_path = result_path.transform(target_transform)
    
        # Build and return Path
        return result_path
   
    def get_target_extents(self) -> np.array:
        """Get the target extents as a 2x2 array.
        If the target bounds is a single value assume it is a size and return a new size [0,0], [sizex, sizey]
        """
        if self.target_bounds is not None:
            if np.shape(self.target_bounds) == (2,):
                target = self.target_bounds
                return np.array([[0, 0], [target[0], target[1]]])
            else:
                return np.array(self.target_bounds)
        return None
    
    def _parse_svg(self, svg_input: str | Path | IO[str]) -> ET.Element:
        """Parse SVG input into XML element tree."""
        try:
            if isinstance(svg_input, (str, Path)):
                # Check if it's a file path or XML string
                if isinstance(svg_input, Path) or (isinstance(svg_input, str) and '\n' not in svg_input and len(svg_input) < 2000):
                    # Likely a file path
                    try:
                        tree = ET.parse(svg_input)
                        return tree.getroot()
                    except (FileNotFoundError, ET.ParseError, OSError):
                        # Try as XML string
                        return ET.fromstring(svg_input)
                else:
                    # XML string
                    return ET.fromstring(svg_input)
            else:
                # File-like object
                tree = ET.parse(svg_input)
                return tree.getroot()
        except ET.ParseError as e:
            raise SVGParseError(f"Failed to parse SVG: {e}") from e
    
    def _extract_svg_metadata(self) -> None:
        """Extract viewBox, width, height from SVG root element."""
        if self.svg_root is None:
            return
        
        # Parse viewBox
        viewbox_str = self.svg_root.get('viewBox', '')
        self.view_box = _parse_viewbox(viewbox_str)
        
        # Parse width and height
        width_str = self.svg_root.get('width', '')
        height_str = self.svg_root.get('height', '')
        
        width = None
        height = None
        
        if width_str:
            try:
                width = _parse_svg_unit(width_str, self.dpi)
            except (ValueError, TypeError):
                pass
        
        if height_str:
            try:
                height = _parse_svg_unit(height_str, self.dpi)
            except (ValueError, TypeError):
                pass
        
        if width is not None and height is not None:
            self.svg_size = (width, height)
        elif self.view_box is not None:
            # Use viewBox dimensions
            self.svg_size = (self.view_box[2], self.view_box[3])
    
    def _build_coordinate_transform(self) -> None:
        """Build the final coordinate system transformation (Y-flip, viewBox, scaling)."""
        transforms = []
        
        # Get SVG dimensions for Y-flip
        svg_height = self.svg_size[1] if self.svg_size else 0.0
        
        # ViewBox translation (if present)
        if self.view_box is not None:
            vx, vy, vw, vh = self.view_box
            if vx != 0 or vy != 0:
                transforms.append(translate(GVector([-vx, -vy, 0])))
            # Update svg_height if not set
            if not self.svg_size:
                svg_height = vh
        
        # Y-flip: reflect about horizontal axis
        # In SVG: y increases downward, in AnchorSCAD: y increases upward
        # Flip: y_new = svg_height - y_old
        if svg_height > 0:
            # Translate to center, scale Y by -1, translate back
            flip_transform = (
                translate(GVector([0, svg_height, 0])) *
                scale([1, -1, 1])
            )
            transforms.append(flip_transform)

        # Compose all transforms
        if transforms:
            result = IDENTITY
            for t in transforms:
                result = result * t
            self.coord_transform = result
        else:
            self.coord_transform = IDENTITY
    
    def _process_element(
        self,
        element: ET.Element,
        path_id: str | None = None
    ) -> None:
        """
        Recursively process SVG elements.
        Handles <g> groups and <path> elements separately.
        """
        # Remove namespace from tag
        tag = element.tag.split('}')[-1] if '}' in element.tag else element.tag
        self.element_no += 1
        self.path_no = 0
        
        if tag == 'g':
            self._process_group(element, path_id)
        elif tag == 'path':
            self._process_path(element, path_id)
        elif tag == 'svg':
            # Process children of root SVG element
            for child in element:
                self._process_element(child, path_id)
        else:
            # Unsupported element
            self.error_handler.handle_unsupported_element(
                tag, dict(element.attrib)
            )
    
    def _process_group(
        self,
        group_element: ET.Element,
        path_id: str | None = None
    ) -> None:
        """
        Process a <g> (group) element.
        Pushes transform onto stack, processes children, then pops transform.
        """
        # Parse transform attribute
        transform_str = group_element.get('transform', '')
        transform = self._parse_transform(transform_str)
        
        # Push transform onto stack (compose with current)
        current_transform = self.transform_stack[-1]
        new_transform = current_transform * transform
        self.transform_stack.append(new_transform)
        
        try:
            # Process all children
            for child in group_element:
                self._process_element(child, path_id)
        finally:
            # Always pop transform stack
            self.transform_stack.pop()
    
    def _process_path(
        self,
        path_element: ET.Element,
        path_id: str | None = None
    ) -> None:
        """
        Process a <path> element.
        Converts SVG path data to PathBuilder operations.
        """
        # Check if this path should be imported
        element_id = path_element.get('id')
        
        # Get path data
        path_data = path_element.get('d', '')
        if not path_data:
            return
        
        try:
            # Parse path commands using svgpathtools
            # Apply current transform stack to all coordinates
            # Convert to PathBuilder operations
            self._convert_path_data(path_data, path_id, element_id)
        except Exception as e:
            self.error_handler.handle_malformed_path_data(path_id, element_id, e)
    
    def _parse_transform(self, transform_str: str) -> GMatrix:
        """
        Parse SVG transform string and return GMatrix.
        Handles: matrix, translate, scale, rotate, skewX, skewY
        """
        if not transform_str or not transform_str.strip():
            return IDENTITY
        
        try:
            # Parse transform string - may contain multiple transforms
            # Format: "transform1(...) transform2(...) ..."
            transform_pattern = r'(\w+)\s*\(([^)]*)\)'
            matches = re.findall(transform_pattern, transform_str)
            
            if not matches:
                return IDENTITY
            
            result = IDENTITY
            
            for transform_type, params_str in matches:
                params_str = params_str.strip()
                params = [float(x.strip()) for x in re.split(r'[,\s]+', params_str) if x.strip()]
                
                if transform_type == 'matrix' and len(params) == 6:
                    # matrix(a, b, c, d, e, f)
                    a, b, c, d, e, f = params
                    # SVG 2x3 matrix to 3D GMatrix
                    # SVG: [[a, c, e], [b, d, f]]
                    # GMatrix: [[a, c, 0, e], [b, d, 0, f], [0, 0, 1, 0], [0, 0, 0, 1]]
                    matrix = GMatrix([
                        [a, c, 0, e],
                        [b, d, 0, f],
                        [0, 0, 1, 0],
                        [0, 0, 0, 1]
                    ])
                    result = result * matrix
                
                elif transform_type == 'translate':
                    if len(params) == 2:
                        x, y = params
                        result = result * translate(GVector([x, y, 0]))
                    elif len(params) == 1:
                        x = params[0]
                        result = result * translate(GVector([x, 0, 0]))
                
                elif transform_type == 'scale':
                    if len(params) == 2:
                        x, y = params
                        result = result * scale([x, y, 1])
                    elif len(params) == 1:
                        s = params[0]
                        result = result * scale([s, s, 1])
                
                elif transform_type == 'rotate':
                    if len(params) == 3:
                        angle, cx, cy = params
                        # Rotate about point (cx, cy)
                        result = result * (
                            translate(GVector([cx, cy, 0])) *
                            rotZ(degrees=angle) *
                            translate(GVector([-cx, -cy, 0]))
                        )
                    elif len(params) == 1:
                        angle = params[0]
                        # Rotate about origin
                        result = result * rotZ(degrees=angle)
                
                elif transform_type == 'skewX':
                    if len(params) == 1:
                        angle = params[0]
                        tan_val = math.tan(math.radians(angle))
                        skew_matrix = GMatrix([
                            [1, tan_val, 0, 0],
                            [0, 1, 0, 0],
                            [0, 0, 1, 0],
                            [0, 0, 0, 1]
                        ])
                        result = result * skew_matrix
                
                elif transform_type == 'skewY':
                    if len(params) == 1:
                        angle = params[0]
                        tan_val = math.tan(math.radians(angle))
                        skew_matrix = GMatrix([
                            [1, 0, 0, 0],
                            [tan_val, 1, 0, 0],
                            [0, 0, 1, 0],
                            [0, 0, 0, 1]
                        ])
                        result = result * skew_matrix
            
            return result
            
        except Exception as e:
            self.error_handler.handle_transform_error(transform_str, e)
            return IDENTITY
    
    def _apply_transforms(self, point: tuple[float, float]) -> tuple[float, float]:
        """Apply transform stack and coordinate transform to a 2D point."""
        # Convert to 3D point
        point_3d = GVector([point[0], point[1], 0])
        
        # Apply transform stack
        current_transform = self.transform_stack[-1]
        transformed = current_transform * point_3d
        
        # Apply coordinate system transform
        if self.coord_transform is not None:
            transformed = self.coord_transform * transformed
        
        return (transformed.x, transformed.y)
    
    def _make_name(self, path_id: str | None, element_id: str | None) -> tuple[str, int, int]:
        """
        Make a name for the path element.
        """
        self.path_no += 1
        if element_id is None:
            element_id = self.element_no
        if path_id is not None:
            return (path_id, self.element_no, self.path_no)
        return (self.element_no, self.path_no)
    
    def _convert_path_data(self, path_data: str, path_id: str | None, element_id: str | None) -> None:
        """
        Convert SVG path data string to PathBuilder operations.
        Applies transforms and coordinate conversion.
        """
        try:
            # Parse path using svgpathtools
            svg_path = parse_path(path_data)
            
            # Track current position for relative commands
            current_pos = None
            last_control = None  # For smooth curves
            
            # Each path starts with a move
            first_point = True
            
            for segment in svg_path:
                
                if isinstance(segment, Line):
                    start = (segment.start.real, segment.start.imag)
                    end = (segment.end.real, segment.end.imag)
                    
                    # Apply transforms
                    start_transformed = self._apply_transforms(start)
                    end_transformed = self._apply_transforms(end)
                    
                    if first_point:
                        self.path_builder.move(start_transformed, name=self._make_name(path_id, element_id))
                        first_point = False
                    
                    self.path_builder.line(end_transformed, name=self._make_name(path_id, element_id))
                    current_pos = end
                    last_control = None
                
                elif isinstance(segment, CubicBezier):
                    # Cubic Bezier: 4 control points
                    p0 = (segment.start.real, segment.start.imag)
                    p1 = (segment.control1.real, segment.control1.imag)
                    p2 = (segment.control2.real, segment.control2.imag)
                    p3 = (segment.end.real, segment.end.imag)
                    
                    # Apply transforms
                    p0_t = self._apply_transforms(p0)
                    p1_t = self._apply_transforms(p1)
                    p2_t = self._apply_transforms(p2)
                    p3_t = self._apply_transforms(p3)
                    
                    if first_point:
                        self.path_builder.move(p0_t, name=self._make_name(path_id, element_id))
                        first_point = False
                    
                    self.path_builder.spline([p1_t, p2_t, p3_t], name=self._make_name(path_id, element_id))
                    current_pos = p3
                    last_control = p2  # For smooth curves
                
                elif isinstance(segment, QuadraticBezier):
                    # Quadratic Bezier: 3 control points
                    p0 = (segment.start.real, segment.start.imag)
                    p1 = (segment.control.real, segment.control.imag)
                    p2 = (segment.end.real, segment.end.imag)
                    
                    # Apply transforms
                    p0_t = self._apply_transforms(p0)
                    p1_t = self._apply_transforms(p1)
                    p2_t = self._apply_transforms(p2)
                    
                    if first_point:
                        self.path_builder.move(p0_t, name=self._make_name(path_id, element_id))
                        first_point = False
                    
                    self.path_builder.qspline([p1_t, p2_t], name=self._make_name(path_id, element_id))
                    current_pos = p2
                    last_control = p1  # For smooth curves
                
                elif isinstance(segment, Arc):
                    # Elliptical arc
                    start = (segment.start.real, segment.start.imag)
                    end = (segment.end.real, segment.end.imag)
                    
                    # Check if it's a circular arc (rx == ry and no rotation)
                    rx = abs(segment.radius.real)
                    ry = abs(segment.radius.imag)
                    rotation = segment.rotation
                    
                    # Approximate arc with Bezier curves
                    # svgpathtools Arc can be converted to a path with bezier segments
                    reason = f"Arc (rx={rx:.3f}, ry={ry:.3f}, rotation={rotation:.3f})"
                    if abs(rx - ry) < 1e-6 and abs(rotation) < 1e-6:
                        reason = "Circular arc approximated with Bezier"
                    
                    self.error_handler.handle_arc_approximation(path_id, reason)
                    
                    # Convert arc to path and then to bezier segments
                    # Use the Arc's point() method to sample points and create bezier approximation
                    # Or convert the arc to a path and process its segments
                    arc_path = SVGPath([segment])
                    
                    # Sample the arc and create bezier approximation
                    # For simplicity, sample at t=0, 0.33, 0.67, 1.0 and create cubic bezier
                    try:
                        # Get points along the arc
                        t_samples = [0.0, 0.33, 0.67, 1.0]
                        points = []
                        for t in t_samples:
                            pt = segment.point(t)
                            points.append((pt.real, pt.imag))
                        
                        # Create cubic bezier approximation
                        # Use the sampled points as control points
                        p0 = points[0]
                        p1 = points[1]
                        p2 = points[2]
                        p3 = points[3]
                        
                        # Apply transforms
                        p0_t = self._apply_transforms(p0)
                        p1_t = self._apply_transforms(p1)
                        p2_t = self._apply_transforms(p2)
                        p3_t = self._apply_transforms(p3)
                        
                        if first_point:
                            self.path_builder.move(p0_t, name=self._make_name(path_id, element_id))
                            first_point = False
                        
                        # Use spline with control points
                        # Adjust control points for better approximation
                        # Simple approach: use sampled points as control points
                        self.path_builder.spline([p1_t, p2_t, p3_t], name=self._make_name(path_id, element_id))
                        
                    except Exception as e:
                        # Fallback: simple line approximation
                        start_t = self._apply_transforms(start)
                        end_t = self._apply_transforms(end)
                        
                        if first_point:
                            self.path_builder.move(start_t, name=self._make_name(path_id, element_id))
                            first_point = False
                        
                        self.path_builder.line(end_t, name=self._make_name(path_id, element_id))
                    
                    current_pos = end
                    last_control = None
                
                else:
                    # Unknown segment type
                    self.error_handler.handle_unsupported_path_command(
                        type(segment).__name__, []
                    )
        
        except Exception as e:
            raise SVGParseError(f"Failed to parse path data: {e}") from e


def svg_to_path(
    svg_input: str | Path | IO[str],
    path_id: str | None = None,
    error_handler: SVGErrorHandler | None = None,
    target_bounds: tuple[float, float] | None = None,
    dpi: float = 96.0
) -> ExtrudePath:
    """
    Converts SVG path data to an AnchorSCAD Path object.
    
    This is a convenience function that creates an SVGPathImporter instance
    and calls its import_svg() method.
    
    Args:
        svg_input: Either:
            - A string containing SVG XML content
            - A file path (str or pathlib.Path) to an SVG file
            - A file-like object (IO[str]) containing SVG content
        path_id: Optional. If specified, only import the path element with this id.
                 If None, imports all path elements found in the SVG.
        error_handler: Optional instance of SVGErrorHandler ABC. If provided, handles
                      errors and warnings for unsupported elements and malformed data.
                      If None, uses default behavior (warn and skip unsupported elements).
        target_bounds: Optional (width, height) tuple. If SVG lacks viewBox/width/height,
                      scale the imported paths to fit within these bounds while preserving
                      aspect ratio. If None and size info missing, use raw coordinates.
        dpi: Dots per inch for unit conversion. Default 96.0 (standard web DPI).
             Used to convert SVG units (px, in, cm, mm, pt, pc) to AnchorSCAD units.
    
    Returns:
        A Path object with multi=True, containing all imported paths.
        Each SVG <path> element becomes a separate sub-path (via move operations).
    
    Raises:
        FileNotFoundError: If svg_input is a file path that doesn't exist.
        ValueError: If the SVG content is invalid or contains unsupported elements.
        SVGParseError: If SVG parsing fails.
    """
    importer = SVGPathImporter(
        error_handler=error_handler,
        target_bounds=target_bounds,
        dpi=dpi
    )
    return importer.import_svg(svg_input, path_id)


EXAMPLE_SVG = """\
<?xml version="1.0" encoding="UTF-8"?>
<svg width="278.672" height="360.43799" version="1.1" viewBox="0 0 278.67201 360.43799" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:cc="http://creativecommons.org/ns#" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  
  <g fill="#e82127"><path transform="translate(-28.524,-64.797)" d="m28.524 388.986c0.812 3.167 3.554 6.404 7.316 7.215h11.37l0.58 0.229v28.691h7.1v-28.691l0.645-0.229h11.38c3.804-0.98 6.487-4.048 7.285-7.215v-0.07h-45.676v0.07"/><path transform="translate(-28.524,-64.797)" d="m98.795 425.202h27.011c3.758-0.747 6.551-4.058 7.334-7.263h-41.679c0.778 3.206 3.612 6.516 7.334 7.263"/><path transform="translate(-28.524,-64.797)" d="m98.795 410.485h27.011c3.758-0.741 6.551-4.053 7.334-7.262h-41.679c0.778 3.21 3.612 6.521 7.334 7.262"/><path transform="translate(-28.524,-64.797)" d="m98.795 396.163h27.011c3.758-0.749 6.551-4.058 7.334-7.265h-41.679c0.778 3.207 3.612 6.516 7.334 7.265"/><path transform="translate(-28.524,-64.797)" d="m160.398 396.094h24.954c3.762-1.093 6.921-3.959 7.691-7.136h-39.64v21.415h32.444v7.515l-25.449 0.02c-3.988 1.112-7.37 3.79-9.057 7.327l2.062-0.038h39.415v-21.944h-32.42v-7.159"/><path transform="translate(-28.524,-64.797)" d="m245.319 425.206c3.543-1.502 5.449-4.1 6.179-7.14h-31.517l0.02-29.118-7.065 0.02v36.238h32.383"/><path transform="translate(-28.524,-64.797)" d="m272.845 396.192h27.02c3.753-0.746 6.544-4.058 7.331-7.262h-41.681c0.779 3.205 3.611 6.516 7.33 7.262"/><path transform="translate(-28.524,-64.797)" d="m266.601 403.28v21.912h7.027v-14.589h25.575v14.589h7.022v-21.874l-39.624-0.038"/>
    
  </g>
  <g fill="#e82127">
    <path transform="translate(-33.796,-64.797)" d="m173.146 317.299 35.476-199.519c33.815 0 44.481 3.708 46.021 18.843 0 0 22.684-8.458 34.125-25.636-44.646-20.688-89.505-21.621-89.505-21.621l-26.176 31.882 0.059-4e-3 -26.176-31.883s-44.86 0.934-89.5 21.622c11.431 17.178 34.124 25.636 34.124 25.636 1.549-15.136 12.202-18.844 45.79-18.868l35.762 199.548"/>
    <path transform="translate(-33.796,-64.797)" d="m173.132 80.157c36.09-0.276 77.399 5.583 119.687 24.014 5.652-10.173 7.105-14.669 7.105-14.669-46.227-18.289-89.518-24.548-126.797-24.705-37.277 0.157-80.566 6.417-126.787 24.705 0 0 2.062 5.538 7.1 14.669 42.28-18.431 83.596-24.29 119.687-24.014h5e-3"/>
  </g>
<metadata><rdf:RDF><cc:Work rdf:about=""><dc:subject><rdf:Bag><rdf:li>Tesla</rdf:li></rdf:Bag></dc:subject></cc:Work></rdf:RDF></metadata></svg>
"""

@datatree
@core.shape
class SvgPathShape(core.CompositeShape):
    """
    A shape that imports an SVG path and extrudes it.
    """
    
    error_handler: SVGErrorHandler = dtfield(default_factory=lambda: DefaultSVGErrorHandler())
    path_id: str = dtfield(default='examp', doc='The ID of the path to import')
    target_bounds: tuple[float, float] = dtfield(default=(30, 30), doc='The target bounds of the shape')
    svg_input: str = core.dtfield(EXAMPLE_SVG, doc='The SVG input to import')
    svg_path_node: core.Node[ExtrudePath] = core.ShapeNode(svg_to_path)
    path: ExtrudePath = core.dtfield(self_default=lambda s: s.svg_path_node())
    h: float = core.dtfield(10, doc='Height of the shape')
    extrude_node: core.Node[LinearExtrude] = core.ShapeNode(LinearExtrude)
    
    EXAMPLE_SHAPE_ARGS = core.args(
        h=10,
        )
    EXAMPLE_ANCHORS = ()
    
    def build(self) -> core.Maker:
        shape = self.extrude_node()
        maker = shape.solid('extrusion').at()
        return maker
    
# Uncomment the line below to default to writing OpenSCAD files
# when anchorscad_main is run with no --write or --no-write options.
MAIN_DEFAULT = core.ModuleDefault(all=True)

if __name__ == '__main__':
    core.anchorscad_main()