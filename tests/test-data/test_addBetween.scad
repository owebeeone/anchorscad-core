// Start: lazy_union
default_5_default_5();
// End: lazy_union

// Modules.

// 'PartMaterial undef-default - undef-default'
module default_5_default_5() {
  // 'None : _combine_solids_and_holes'
  union() {
    // 'inner'
    %multmatrix(m=[[1.0, 0.0, 0.0, -15.0], [0.0, 1.0, 0.0, -15.0], [0.0, 0.0, 1.0, -15.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'inner : _combine_solids_and_holes'
      union() {
        // 'inner'
        cube(size=[30.0, 30.0, 30.0]);
      }
    }
    // 'outer'
    %multmatrix(m=[[1.0, 0.0, 0.0, -25.0], [0.0, 1.0, 0.0, -25.0], [0.0, 0.0, 1.0, -25.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'outer : _combine_solids_and_holes'
      union() {
        // 'outer'
        cube(size=[50.0, 50.0, 50.0]);
      }
    }
    // 'in_between'
    multmatrix(m=[[0.24253562503633266, -0.6755205294731982, 0.6963106238227915, -15.000000000000007], [-0.9701425001453323, -0.16888013236829977, 0.17407765595569738, 15.000000000000027], [3.5780469036154014e-16, -0.7177405625652729, -0.6963106238227915, 15.000000000000007], [0.0, 0.0, 0.0, 1.0]]) {
      // 'in_between'
      color(c=[1.0, 0.0, 0.0, 1.0]) {
        // 'in_between : _combine_solids_and_holes'
        union() {
          // 'in_between'
          cylinder(h=57.445626465380286, r1=5.0, r2=0.0, center=false);
        }
      }
    }
    // ('face_text', 'inner', 0)
    multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, 0.0, -1.0, -15.0], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 0.0, 1.0]]) {
      // ('face_text', 'inner', 0)
      color(c=[0.0, 1.0, 0.0, 1.0]) {
        // "('face_text', 'inner', 0) : _combine_solids_and_holes"
        union() {
          // ('face_text', 'inner', 0)
          linear_extrude(height=1.0) {
            translate(v=[0.0, 0.0, -0.5]) {
              text(text="0", size=10.0, halign="left", valign="bottom", spacing=1.0, direction="ltr");
            }
          }
        }
      }
    }
    // ('face_text', 'inner', 1)
    multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, -1.0, 0.0, 0.0], [0.0, 0.0, -1.0, -15.0], [0.0, 0.0, 0.0, 1.0]]) {
      // ('face_text', 'inner', 1)
      color(c=[0.0, 1.0, 0.0, 1.0]) {
        // "('face_text', 'inner', 1) : _combine_solids_and_holes"
        union() {
          // ('face_text', 'inner', 1)
          linear_extrude(height=1.0) {
            translate(v=[0.0, 0.0, -0.5]) {
              text(text="1", size=10.0, halign="left", valign="bottom", spacing=1.0, direction="ltr");
            }
          }
        }
      }
    }
    // ('face_text', 'inner', 2)
    multmatrix(m=[[0.0, 0.0, -1.0, -15.0], [-1.0, 0.0, 0.0, 0.0], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 0.0, 1.0]]) {
      // ('face_text', 'inner', 2)
      color(c=[0.0, 1.0, 0.0, 1.0]) {
        // "('face_text', 'inner', 2) : _combine_solids_and_holes"
        union() {
          // ('face_text', 'inner', 2)
          linear_extrude(height=1.0) {
            translate(v=[0.0, 0.0, -0.5]) {
              text(text="2", size=10.0, halign="left", valign="bottom", spacing=1.0, direction="ltr");
            }
          }
        }
      }
    }
    // ('face_text', 'inner', 3)
    multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, 0.0, 1.0, 15.0], [0.0, -1.0, 0.0, 0.0], [0.0, 0.0, 0.0, 1.0]]) {
      // ('face_text', 'inner', 3)
      color(c=[0.0, 1.0, 0.0, 1.0]) {
        // "('face_text', 'inner', 3) : _combine_solids_and_holes"
        union() {
          // ('face_text', 'inner', 3)
          linear_extrude(height=1.0) {
            translate(v=[0.0, 0.0, -0.5]) {
              text(text="3", size=10.0, halign="left", valign="bottom", spacing=1.0, direction="ltr");
            }
          }
        }
      }
    }
    // ('face_text', 'inner', 4)
    multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, 15.0], [0.0, 0.0, 0.0, 1.0]]) {
      // ('face_text', 'inner', 4)
      color(c=[0.0, 1.0, 0.0, 1.0]) {
        // "('face_text', 'inner', 4) : _combine_solids_and_holes"
        union() {
          // ('face_text', 'inner', 4)
          linear_extrude(height=1.0) {
            translate(v=[0.0, 0.0, -0.5]) {
              text(text="4", size=10.0, halign="left", valign="bottom", spacing=1.0, direction="ltr");
            }
          }
        }
      }
    }
    // ('face_text', 'inner', 5)
    multmatrix(m=[[0.0, 0.0, 1.0, 15.0], [1.0, 0.0, 0.0, 0.0], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 0.0, 1.0]]) {
      // ('face_text', 'inner', 5)
      color(c=[0.0, 1.0, 0.0, 1.0]) {
        // "('face_text', 'inner', 5) : _combine_solids_and_holes"
        union() {
          // ('face_text', 'inner', 5)
          linear_extrude(height=1.0) {
            translate(v=[0.0, 0.0, -0.5]) {
              text(text="5", size=10.0, halign="left", valign="bottom", spacing=1.0, direction="ltr");
            }
          }
        }
      }
    }
    // 'here_text'
    multmatrix(m=[[0.0, 0.0, 1.0, 25.0], [0.0, -1.0, 0.0, 25.0], [1.0, 0.0, 0.0, -25.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'here_text : _combine_solids_and_holes'
      union() {
        // 'here_text'
        linear_extrude(height=1.0) {
          translate(v=[0.0, 0.0, -0.5]) {
            text(text="Here", size=10.0, halign="left", valign="bottom", spacing=1.0, direction="ltr");
          }
        }
      }
    }
  }
} // end module default_5_default_5

