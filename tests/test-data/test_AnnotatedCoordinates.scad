// Start: lazy_union
default_5_default_5();
// End: lazy_union

// Modules.

// 'PartMaterial undef-default - undef-default'
module default_5_default_5() {
  // 'None : _combine_solids_and_holes'
  union() {
    // 'coordinates : _combine_solids_and_holes'
    union() {
      // 'coords : _combine_solids_and_holes'
      union() {
        // 'x_arrow'
        multmatrix(m=[[0.0, 0.0, -1.0, -3.0], [0.0, -1.0, 0.0, 0.0], [-1.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 1.0]]) {
          // 'x_arrow'
          color(c=[1.0, 0.0, 0.0, 1.0]) {
            // 'x_arrow : _combine_solids_and_holes'
            union() {
              // 'stem'
              multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [-0.0, -1.0, -0.0, -0.0], [-0.0, -0.0, -1.0, -0.0], [0.0, 0.0, 0.0, 1.0]]) {
                // 'stem : _combine_solids_and_holes'
                union() {
                  // 'stem'
                  cylinder(h=10.0, r1=0.75, r2=0.75, center=false, $fn=27);
                }
              }
              // 'head'
              multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, -1.0, 0.0, 0.0], [0.0, 0.0, -1.0, -10.0], [0.0, 0.0, 0.0, 1.0]]) {
                // 'head : _combine_solids_and_holes'
                union() {
                  // 'head'
                  cylinder(h=3.0, r1=1.5, r2=0.0, center=false, $fn=27);
                }
              }
            }
          }
        }
        // 'y_arrow'
        multmatrix(m=[[-1.0, 0.0, 0.0, 0.0], [0.0, 0.0, -1.0, -3.0], [0.0, -1.0, 0.0, 0.0], [0.0, 0.0, 0.0, 1.0]]) {
          // 'y_arrow'
          color(c=[0.0, 0.5019607843137255, 0.0, 1.0]) {
            // 'y_arrow : _combine_solids_and_holes'
            union() {
              // 'stem'
              multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [-0.0, -1.0, -0.0, -0.0], [-0.0, -0.0, -1.0, -0.0], [0.0, 0.0, 0.0, 1.0]]) {
                // 'stem : _combine_solids_and_holes'
                union() {
                  // 'stem'
                  cylinder(h=10.0, r1=0.75, r2=0.75, center=false, $fn=27);
                }
              }
              // 'head'
              multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, -1.0, 0.0, 0.0], [0.0, 0.0, -1.0, -10.0], [0.0, 0.0, 0.0, 1.0]]) {
                // 'head : _combine_solids_and_holes'
                union() {
                  // 'head'
                  cylinder(h=3.0, r1=1.5, r2=0.0, center=false, $fn=27);
                }
              }
            }
          }
        }
        // 'z_arrow'
        multmatrix(m=[[0.0, -1.0, 0.0, 0.0], [-1.0, 0.0, 0.0, 0.0], [0.0, 0.0, -1.0, -3.0], [0.0, 0.0, 0.0, 1.0]]) {
          // 'z_arrow'
          color(c=[0.0, 0.0, 1.0, 1.0]) {
            // 'z_arrow : _combine_solids_and_holes'
            union() {
              // 'stem'
              multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [-0.0, -1.0, -0.0, -0.0], [-0.0, -0.0, -1.0, -0.0], [0.0, 0.0, 0.0, 1.0]]) {
                // 'stem : _combine_solids_and_holes'
                union() {
                  // 'stem'
                  cylinder(h=10.0, r1=0.75, r2=0.75, center=false, $fn=27);
                }
              }
              // 'head'
              multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, -1.0, 0.0, 0.0], [0.0, 0.0, -1.0, -10.0], [0.0, 0.0, 0.0, 1.0]]) {
                // 'head : _combine_solids_and_holes'
                union() {
                  // 'head'
                  cylinder(h=3.0, r1=1.5, r2=0.0, center=false, $fn=27);
                }
              }
            }
          }
        }
      }
      // 'x'
      multmatrix(m=[[1.0, 0.0, 0.0, 11.0], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
        // 'x : _combine_solids_and_holes'
        union() {
          // 'x'
          linear_extrude(height=1.0) {
            translate(v=[0.0, 0.0, -0.5]) {
              text(text="x", size=3.0, halign="left", valign="bottom", spacing=1.0, direction="ltr", $fn=27);
            }
          }
        }
      }
      // 'y'
      multmatrix(m=[[0.0, 0.0, 1.0, -0.5], [1.0, 0.0, 0.0, 11.0], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 0.0, 1.0]]) {
        // 'y : _combine_solids_and_holes'
        union() {
          // 'y'
          linear_extrude(height=1.0) {
            translate(v=[0.0, 0.0, -0.5]) {
              text(text="y", size=3.0, halign="left", valign="bottom", spacing=1.0, direction="ltr", $fn=27);
            }
          }
        }
      }
      // 'z'
      multmatrix(m=[[0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [1.0, 0.0, 0.0, 11.0], [0.0, 0.0, 0.0, 1.0]]) {
        // 'z : _combine_solids_and_holes'
        union() {
          // 'z'
          linear_extrude(height=1.0) {
            translate(v=[0.0, 0.0, -0.5]) {
              text(text="z", size=3.0, halign="left", valign="bottom", spacing=1.0, direction="ltr", $fn=27);
            }
          }
        }
      }
    }
  }
} // end module default_5_default_5

