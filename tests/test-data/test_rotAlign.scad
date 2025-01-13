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
                cylinder(h=10.0, r1=0.75, r2=0.75, center=false);
              }
            }
            // 'head'
            multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, -1.0, 0.0, 0.0], [0.0, 0.0, -1.0, -10.0], [0.0, 0.0, 0.0, 1.0]]) {
              // 'head : _combine_solids_and_holes'
              union() {
                // 'head'
                cylinder(h=3.0, r1=1.5, r2=0.0, center=false);
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
                cylinder(h=10.0, r1=0.75, r2=0.75, center=false);
              }
            }
            // 'head'
            multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, -1.0, 0.0, 0.0], [0.0, 0.0, -1.0, -10.0], [0.0, 0.0, 0.0, 1.0]]) {
              // 'head : _combine_solids_and_holes'
              union() {
                // 'head'
                cylinder(h=3.0, r1=1.5, r2=0.0, center=false);
              }
            }
          }
        }
      }
    }
    // 'preserve_axis'
    multmatrix(m=[[1.0, 0.0, 0.0, 17.320508075688775], [0.0, 1.0, 0.0, 17.320508075688775], [0.0, 0.0, 1.0, 17.320508075688775], [0.0, 0.0, 0.0, 1.0]]) {
      // 'preserve_axis'
      color(c=[1.0, 0.0, 0.0, 1.0]) {
        // 'preserve_axis : _combine_solids_and_holes'
        union() {
          // 'preserve_axis'
          sphere(r=1.0);
        }
      }
    }
    // ('text', 'preserve_axis')
    multmatrix(m=[[0.7071067811865475, -0.7071067811865475, 0.0, 17.320508075688775], [0.7071067811865475, 0.7071067811865475, 0.0, 17.320508075688775], [0.0, 0.0, 1.0, 17.320508075688775], [0.0, 0.0, 0.0, 1.0]]) {
      // ('text', 'preserve_axis')
      color(c=[1.0, 0.0, 0.0, 1.0]) {
        // "('text', 'preserve_axis') : _combine_solids_and_holes"
        union() {
          // ('text', 'preserve_axis')
          linear_extrude(height=1.0) {
            translate(v=[0.0, 0.0, -0.5]) {
              text(text="preserve_axis", size=10.0, halign="left", valign="bottom", spacing=1.0, direction="ltr");
            }
          }
        }
      }
    }
    // 'o_align_pres_axis'
    multmatrix(m=[[1.0, 0.0, 0.0, 21.213203435596434], [0.0, 1.0, 0.0, 2.4980018054066022e-15], [0.0, 0.0, 1.0, -21.213203435596437], [0.0, 0.0, 0.0, 1.0]]) {
      // 'o_align_pres_axis'
      color(c=[0.0, 1.0, 0.0, 1.0]) {
        // 'o_align_pres_axis : _combine_solids_and_holes'
        union() {
          // 'o_align_pres_axis'
          sphere(r=1.0);
        }
      }
    }
    // ('text', 'o_align_pres_axis')
    multmatrix(m=[[0.7071067811865475, -0.7071067811865475, 0.0, 21.213203435596434], [0.7071067811865475, 0.7071067811865475, 0.0, 2.51214793389404e-15], [0.0, 0.0, 1.0, -21.213203435596437], [0.0, 0.0, 0.0, 1.0]]) {
      // ('text', 'o_align_pres_axis')
      color(c=[0.0, 1.0, 0.0, 1.0]) {
        // "('text', 'o_align_pres_axis') : _combine_solids_and_holes"
        union() {
          // ('text', 'o_align_pres_axis')
          linear_extrude(height=1.0) {
            translate(v=[0.0, 0.0, -0.5]) {
              text(text="o_align_pres_axis", size=10.0, halign="left", valign="bottom", spacing=1.0, direction="ltr");
            }
          }
        }
      }
    }
    // 'plane_axis'
    multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, 30.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'plane_axis'
      color(c=[0.0, 0.0, 1.0, 1.0]) {
        // 'plane_axis : _combine_solids_and_holes'
        union() {
          // 'plane_axis'
          sphere(r=1.0);
        }
      }
    }
    // ('text', 'plane_axis')
    multmatrix(m=[[0.7071067811865475, -0.7071067811865475, 0.0, 0.0], [0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, 30.0], [0.0, 0.0, 0.0, 1.0]]) {
      // ('text', 'plane_axis')
      color(c=[0.0, 0.0, 1.0, 1.0]) {
        // "('text', 'plane_axis') : _combine_solids_and_holes"
        union() {
          // ('text', 'plane_axis')
          linear_extrude(height=1.0) {
            translate(v=[0.0, 0.0, -0.5]) {
              text(text="plane_axis", size=10.0, halign="left", valign="bottom", spacing=1.0, direction="ltr");
            }
          }
        }
      }
    }
    // 'on_plane'
    multmatrix(m=[[1.0, 0.0, 0.0, 21.213203435596427], [0.0, 1.0, 0.0, 21.213203435596427], [0.0, 0.0, 1.0, 0.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'on_plane'
      color(c=[1.0, 1.0, 0.0, 1.0]) {
        // 'on_plane : _combine_solids_and_holes'
        union() {
          // 'on_plane'
          sphere(r=1.0);
        }
      }
    }
    // ('text', 'on_plane')
    multmatrix(m=[[0.7071067811865475, -0.7071067811865475, 0.0, 21.213203435596427], [0.7071067811865475, 0.7071067811865475, 0.0, 21.213203435596427], [0.0, 0.0, 1.0, 0.0], [0.0, 0.0, 0.0, 1.0]]) {
      // ('text', 'on_plane')
      color(c=[1.0, 1.0, 0.0, 1.0]) {
        // "('text', 'on_plane') : _combine_solids_and_holes"
        union() {
          // ('text', 'on_plane')
          linear_extrude(height=1.0) {
            translate(v=[0.0, 0.0, -0.5]) {
              text(text="on_plane", size=10.0, halign="left", valign="bottom", spacing=1.0, direction="ltr");
            }
          }
        }
      }
    }
    // 't1_o_align_pres_axis'
    multmatrix(m=[[1.0, 0.0, 0.0, 10.606601717798217], [0.0, 1.0, 0.0, -10.606601717798217], [0.0, 0.0, 1.0, -25.98076211353317], [0.0, 0.0, 0.0, 1.0]]) {
      // 't1_o_align_pres_axis'
      color(c=[1.0, 0.0, 1.0, 1.0]) {
        // 't1_o_align_pres_axis : _combine_solids_and_holes'
        union() {
          // 't1_o_align_pres_axis'
          sphere(r=1.0);
        }
      }
    }
    // ('text', 't1_o_align_pres_axis')
    multmatrix(m=[[0.7071067811865475, -0.7071067811865475, 0.0, 10.606601717798217], [0.7071067811865475, 0.7071067811865475, 0.0, -10.606601717798217], [0.0, 0.0, 1.0, -25.98076211353317], [0.0, 0.0, 0.0, 1.0]]) {
      // ('text', 't1_o_align_pres_axis')
      color(c=[1.0, 0.0, 1.0, 1.0]) {
        // "('text', 't1_o_align_pres_axis') : _combine_solids_and_holes"
        union() {
          // ('text', 't1_o_align_pres_axis')
          linear_extrude(height=1.0) {
            translate(v=[0.0, 0.0, -0.5]) {
              text(text="t1_o_align_pres_axis", size=10.0, halign="left", valign="bottom", spacing=1.0, direction="ltr");
            }
          }
        }
      }
    }
    // 'on_plane_align_pres_axis'
    multmatrix(m=[[1.0, 0.0, 0.0, 28.900283633463903], [0.0, 1.0, 0.0, -7.687080197867473], [0.0, 0.0, 1.0, 2.3837793389683677], [0.0, 0.0, 0.0, 1.0]]) {
      // 'on_plane_align_pres_axis'
      color(c=[0.0, 1.0, 1.0, 1.0]) {
        // 'on_plane_align_pres_axis : _combine_solids_and_holes'
        union() {
          // 'on_plane_align_pres_axis'
          sphere(r=1.0);
        }
      }
    }
    // ('text', 'on_plane_align_pres_axis')
    multmatrix(m=[[0.7071067811865475, -0.7071067811865475, 0.0, 28.900283633463903], [0.7071067811865475, 0.7071067811865475, 0.0, -7.687080197867473], [0.0, 0.0, 1.0, 2.3837793389683677], [0.0, 0.0, 0.0, 1.0]]) {
      // ('text', 'on_plane_align_pres_axis')
      color(c=[0.0, 1.0, 1.0, 1.0]) {
        // "('text', 'on_plane_align_pres_axis') : _combine_solids_and_holes"
        union() {
          // ('text', 'on_plane_align_pres_axis')
          linear_extrude(height=1.0) {
            translate(v=[0.0, 0.0, -0.5]) {
              text(text="on_plane_align_pres_axis", size=10.0, halign="left", valign="bottom", spacing=1.0, direction="ltr");
            }
          }
        }
      }
    }
    // 'new_align_preserve_axis'
    multmatrix(m=[[1.0, 0.0, 0.0, 21.213203435596427], [0.0, 1.0, 0.0, -21.21320343559643], [0.0, 0.0, 1.0, -3.71993147696305e-16], [0.0, 0.0, 0.0, 1.0]]) {
      // 'new_align_preserve_axis'
      color(c=[1.0, 0.0, 0.0, 1.0]) {
        // 'new_align_preserve_axis : _combine_solids_and_holes'
        union() {
          // 'new_align_preserve_axis'
          sphere(r=1.0);
        }
      }
    }
    // ('text', 'new_align_preserve_axis')
    multmatrix(m=[[0.7071067811865475, -0.7071067811865475, 0.0, 21.213203435596427], [0.7071067811865475, 0.7071067811865475, 0.0, -21.21320343559643], [0.0, 0.0, 1.0, -3.71993147696305e-16], [0.0, 0.0, 0.0, 1.0]]) {
      // ('text', 'new_align_preserve_axis')
      color(c=[1.0, 0.0, 0.0, 1.0]) {
        // "('text', 'new_align_preserve_axis') : _combine_solids_and_holes"
        union() {
          // ('text', 'new_align_preserve_axis')
          linear_extrude(height=1.0) {
            translate(v=[0.0, 0.0, -0.5]) {
              text(text="new_align_preserve_axis", size=10.0, halign="left", valign="bottom", spacing=1.0, direction="ltr");
            }
          }
        }
      }
    }
    // '  new_preserve_axis'
    multmatrix(m=[[1.0, 0.0, 0.0, 17.320508075688775], [0.0, 1.0, 0.0, 17.320508075688778], [0.0, 0.0, 1.0, 17.320508075688778], [0.0, 0.0, 0.0, 1.0]]) {
      // '  new_preserve_axis'
      color(c=[0.0, 1.0, 0.0, 1.0]) {
        // '  new_preserve_axis : _combine_solids_and_holes'
        union() {
          // '  new_preserve_axis'
          sphere(r=1.0);
        }
      }
    }
    // ('text', '  new_preserve_axis')
    multmatrix(m=[[0.7071067811865475, -0.7071067811865475, 0.0, 17.320508075688775], [0.7071067811865475, 0.7071067811865475, 0.0, 17.320508075688778], [0.0, 0.0, 1.0, 17.320508075688778], [0.0, 0.0, 0.0, 1.0]]) {
      // ('text', '  new_preserve_axis')
      color(c=[0.0, 1.0, 0.0, 1.0]) {
        // "('text', '  new_preserve_axis') : _combine_solids_and_holes"
        union() {
          // ('text', '  new_preserve_axis')
          linear_extrude(height=1.0) {
            translate(v=[0.0, 0.0, -0.5]) {
              text(text="  new_preserve_axis", size=10.0, halign="left", valign="bottom", spacing=1.0, direction="ltr");
            }
          }
        }
      }
    }
  }
} // end module default_5_default_5

