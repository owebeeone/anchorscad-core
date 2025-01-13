// Start: lazy_union
default_5_default_5();
// End: lazy_union

// Modules.

// 'PartMaterial undef-default - undef-default'
module default_5_default_5() {
  // 'None : _combine_solids_and_holes'
  union() {
    // 'inner'
    %multmatrix(m=[[1.0, 0.0, 0.0, -15.0], [0.0, 1.0, 0.0, -20.0], [0.0, 0.0, 1.0, -25.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'inner : _combine_solids_and_holes'
      union() {
        // 'inner'
        cube(size=[30.0, 40.0, 50.0]);
      }
    }
    // 'outer'
    %multmatrix(m=[[1.0, 0.0, 0.0, -25.0], [0.0, 1.0, 0.0, -40.0], [0.0, 0.0, 1.0, -30.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'outer : _combine_solids_and_holes'
      union() {
        // 'outer'
        cube(size=[50.0, 80.0, 60.0]);
      }
    }
    // 'original'
    color(c=[0.0, 1.0, 1.0, 1.0]) {
      // 'original : _combine_solids_and_holes'
      union() {
        // 'original'
        cylinder(h=83.70334521391604, r1=5.0, r2=0.0, center=false);
      }
    }
    // 'in_between'
    multmatrix(m=[[0.8320502943378438, -0.2816465492427278, 0.4778781528715989, -14.999999999999986], [-0.554700196225229, -0.42246982386409143, 0.7168172293073988, -20.000000000000014], [-2.0409994794956247e-16, -0.8615070918012848, -0.507745537426074, 12.499999999999993], [0.0, 0.0, 0.0, 1.0]]) {
      // 'in_between'
      color(c=[1.0, 0.0, 0.0, 1.0]) {
        // 'in_between : _combine_solids_and_holes'
        union() {
          // 'in_between'
          cylinder(h=83.70334521391604, r1=5.0, r2=0.0, center=false);
        }
      }
    }
    // 'top_ib'
    multmatrix(m=[[0.8320502943378438, -0.2816465492427278, 0.4778781528715989, 25.0], [-0.554700196225229, -0.42246982386409143, 0.7168172293073988, 40.0], [-2.0409994794956247e-16, -0.8615070918012848, -0.507745537426074, -30.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'top_ib : _combine_solids_and_holes'
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
    }
    // 'base_ib'
    multmatrix(m=[[0.8320502943378438, 0.2816465492427278, -0.4778781528715989, -14.999999999999986], [-0.554700196225229, 0.42246982386409143, -0.7168172293073988, -20.000000000000014], [-2.0409994794956247e-16, 0.8615070918012848, 0.507745537426074, 12.499999999999993], [0.0, 0.0, 0.0, 1.0]]) {
      // 'base_ib : _combine_solids_and_holes'
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
    }
    // ('face_text', 'inner', 0)
    multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, 0.0, -1.0, -20.0], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 0.0, 1.0]]) {
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
    multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, -1.0, 0.0, 0.0], [0.0, 0.0, -1.0, -25.0], [0.0, 0.0, 0.0, 1.0]]) {
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
    multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, 0.0, 1.0, 20.0], [0.0, -1.0, 0.0, 0.0], [0.0, 0.0, 0.0, 1.0]]) {
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
    multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, 25.0], [0.0, 0.0, 0.0, 1.0]]) {
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
    multmatrix(m=[[0.0, -1.0, 0.0, 25.0], [-1.0, 0.0, 0.0, 40.0], [0.0, 0.0, -1.0, -30.0], [0.0, 0.0, 0.0, 1.0]]) {
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
    // 'wdiff'
    multmatrix(m=[[1.0, 0.0, 0.0, -14.336344586147971], [0.0, 1.0, 0.0, -21.50451687922196], [0.0, 0.0, 1.0, 15.232366122782219], [0.0, 0.0, 0.0, 1.0]]) {
      // 'wdiff'
      color(c=[1.0, 0.0, 0.0, 1.0]) {
        // 'wdiff : _combine_solids_and_holes'
        union() {
          // 'wdiff'
          sphere(r=1.0);
        }
      }
    }
    // ('text', 'wdiff')
    multmatrix(m=[[0.7071067811865475, -0.7071067811865475, 0.0, -14.336344586147975], [0.7071067811865475, 0.7071067811865475, 0.0, -21.504516879221956], [0.0, 0.0, 1.0, 15.232366122782219], [0.0, 0.0, 0.0, 1.0]]) {
      // ('text', 'wdiff')
      color(c=[1.0, 0.0, 0.0, 1.0]) {
        // "('text', 'wdiff') : _combine_solids_and_holes"
        union() {
          // ('text', 'wdiff')
          linear_extrude(height=1.0) {
            translate(v=[0.0, 0.0, -0.5]) {
              text(text="wdiff", size=10.0, halign="left", valign="bottom", spacing=1.0, direction="ltr");
            }
          }
        }
      }
    }
    // '000'
    color(c=[0.0, 1.0, 0.0, 1.0]) {
      // '000 : _combine_solids_and_holes'
      union() {
        // '000'
        sphere(r=1.0);
      }
    }
    // ('text', '000')
    multmatrix(m=[[0.7071067811865475, -0.7071067811865475, 0.0, 0.0], [0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, 0.0], [0.0, 0.0, 0.0, 1.0]]) {
      // ('text', '000')
      color(c=[0.0, 1.0, 0.0, 1.0]) {
        // "('text', '000') : _combine_solids_and_holes"
        union() {
          // ('text', '000')
          linear_extrude(height=1.0) {
            translate(v=[0.0, 0.0, -0.5]) {
              text(text="000", size=10.0, halign="left", valign="bottom", spacing=1.0, direction="ltr");
            }
          }
        }
      }
    }
    // 'align_axis_vec'
    multmatrix(m=[[1.0, 0.0, 0.0, 16.082348885297787], [0.0, 1.0, 0.0, -20.876476672053332], [0.0, 0.0, 1.0, -14.33634458614797], [0.0, 0.0, 0.0, 1.0]]) {
      // 'align_axis_vec'
      color(c=[0.0, 0.0, 1.0, 1.0]) {
        // 'align_axis_vec : _combine_solids_and_holes'
        union() {
          // 'align_axis_vec'
          sphere(r=1.0);
        }
      }
    }
    // ('text', 'align_axis_vec')
    multmatrix(m=[[0.7071067811865475, -0.7071067811865475, 0.0, 16.082348885297787], [0.7071067811865475, 0.7071067811865475, 0.0, -20.876476672053332], [0.0, 0.0, 1.0, -14.33634458614797], [0.0, 0.0, 0.0, 1.0]]) {
      // ('text', 'align_axis_vec')
      color(c=[0.0, 0.0, 1.0, 1.0]) {
        // "('text', 'align_axis_vec') : _combine_solids_and_holes"
        union() {
          // ('text', 'align_axis_vec')
          linear_extrude(height=1.0) {
            translate(v=[0.0, 0.0, -0.5]) {
              text(text="align_axis_vec", size=10.0, halign="left", valign="bottom", spacing=1.0, direction="ltr");
            }
          }
        }
      }
    }
    // 'align_plane_vec'
    multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, -30.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'align_plane_vec'
      color(c=[1.0, 1.0, 0.0, 1.0]) {
        // 'align_plane_vec : _combine_solids_and_holes'
        union() {
          // 'align_plane_vec'
          sphere(r=1.0);
        }
      }
    }
    // ('text', 'align_plane_vec')
    multmatrix(m=[[0.7071067811865475, -0.7071067811865475, 0.0, 0.0], [0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -30.0], [0.0, 0.0, 0.0, 1.0]]) {
      // ('text', 'align_plane_vec')
      color(c=[1.0, 1.0, 0.0, 1.0]) {
        // "('text', 'align_plane_vec') : _combine_solids_and_holes"
        union() {
          // ('text', 'align_plane_vec')
          linear_extrude(height=1.0) {
            translate(v=[0.0, 0.0, -0.5]) {
              text(text="align_plane_vec", size=10.0, halign="left", valign="bottom", spacing=1.0, direction="ltr");
            }
          }
        }
      }
    }
  }
} // end module default_5_default_5

