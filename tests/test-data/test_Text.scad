// Start: lazy_union
default_5_default_5();
// End: lazy_union

// Modules.

// 'PartMaterial undef-default - undef-default'
module default_5_default_5() {
  // 'None : _combine_solids_and_holes'
  union() {
    // 'default_text'
    multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, -2.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'default_text : _combine_solids_and_holes'
      union() {
        // 'default_text'
        linear_extrude(height=4.0) {
          translate(v=[0.0, 0.0, -2.0]) {
            text(text="Hello", size=10.0, halign="left", valign="bottom", spacing=1.0, direction="ltr", $fn=10);
          }
        }
      }
    }
    // 'scaled_text'
    multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, 1.0, 0.0, -20.0], [0.0, 0.0, 10.0, 0.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'scaled_text : _combine_solids_and_holes'
      union() {
        // 'scaled_text'
        linear_extrude(height=4.0) {
          translate(v=[0.0, 0.0, -2.0]) {
            text(text="Hello", size=10.0, halign="left", valign="bottom", spacing=1.0, direction="ltr", $fn=20);
          }
        }
      }
    }
  }
} // end module default_5_default_5

