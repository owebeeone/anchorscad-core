// Start: lazy_union
default_5_default_5();
// End: lazy_union

// Modules.

// 'PartMaterial undef-default - undef-default'
module default_5_default_5() {
  // 'None : _combine_solids_and_holes'
  union() {
    // 'at_r0_0'
    multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, 1.0, 0.0, -9.0], [0.0, 0.0, 1.0, 0.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'at_r0_0'
      color(c=[1.0, 0.0, 0.0, 1.0]) {
        // '_combine_solids_and_holes'
        difference() {
          // 'at_r0_0 : _combine_solids_and_holes'
          union() {
            // 'outer'
            multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, 0.0, 1.0, 0.0], [-0.0, -1.0, -0.0, -0.0], [0.0, 0.0, 0.0, 1.0]]) {
              // 'outer : _combine_solids_and_holes'
              union() {
                // 'outer'
                cube(size=[2.0, 2.7, 3.5]);
              }
            }
          }
          // 'at_r0_0'
          multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch1 : _combine_solids_and_holes'
            union() {
              // 'etch1'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
          // 'at_r0_0'
          multmatrix(m=[[0.7071067811865475, 0.7071067811865475, 0.0, -0.7071067811865475], [-0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch2 : _combine_solids_and_holes'
            union() {
              // 'etch2'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
        }
      }
    }
    // 'at_0_0'
    multmatrix(m=[[1.0, 0.0, 0.0, 4.4], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, 0.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'at_0_0'
      color(c=[1.0, 0.0, 0.0, 1.0]) {
        // '_combine_solids_and_holes'
        difference() {
          // 'at_0_0 : _combine_solids_and_holes'
          union() {
            // 'outer'
            multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, 0.0, 1.0, 0.0], [-0.0, -1.0, -0.0, -0.0], [0.0, 0.0, 0.0, 1.0]]) {
              // 'outer : _combine_solids_and_holes'
              union() {
                // 'outer'
                cube(size=[2.0, 2.7, 3.5]);
              }
            }
          }
          // 'at_0_0'
          multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch1 : _combine_solids_and_holes'
            union() {
              // 'etch1'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
          // 'at_0_0'
          multmatrix(m=[[0.7071067811865475, 0.7071067811865475, 0.0, -0.7071067811865475], [-0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch2 : _combine_solids_and_holes'
            union() {
              // 'etch2'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
        }
      }
    }
    // 'at_3_0'
    multmatrix(m=[[1.0, 0.0, 0.0, 4.4], [0.0, 1.0, 0.0, 5.0], [0.0, 0.0, 1.0, 0.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'at_3_0'
      color(c=[1.0, 1.0, 0.0, 1.0]) {
        // '_combine_solids_and_holes'
        difference() {
          // 'at_3_0 : _combine_solids_and_holes'
          union() {
            // 'outer'
            multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [-0.0, -0.0, -1.0, 3.5], [0.0, 1.0, 0.0, -2.7], [0.0, 0.0, 0.0, 1.0]]) {
              // 'outer : _combine_solids_and_holes'
              union() {
                // 'outer'
                cube(size=[2.0, 2.7, 3.5]);
              }
            }
          }
          // 'at_3_0'
          multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch1 : _combine_solids_and_holes'
            union() {
              // 'etch1'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
          // 'at_3_0'
          multmatrix(m=[[0.7071067811865475, 0.7071067811865475, 0.0, -0.7071067811865475], [-0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch2 : _combine_solids_and_holes'
            union() {
              // 'etch2'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
        }
      }
    }
    // 'at_1_0'
    multmatrix(m=[[1.0, 0.0, 0.0, 4.4], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, 5.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'at_1_0'
      color(c=[0.0, 1.0, 1.0, 1.0]) {
        // '_combine_solids_and_holes'
        difference() {
          // 'at_1_0 : _combine_solids_and_holes'
          union() {
            // 'outer'
            multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [-0.0, -1.0, -0.0, 2.7], [-0.0, -0.0, -1.0, -0.0], [0.0, 0.0, 0.0, 1.0]]) {
              // 'outer : _combine_solids_and_holes'
              union() {
                // 'outer'
                cube(size=[2.0, 2.7, 3.5]);
              }
            }
          }
          // 'at_1_0'
          multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch1 : _combine_solids_and_holes'
            union() {
              // 'etch1'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
          // 'at_1_0'
          multmatrix(m=[[0.7071067811865475, 0.7071067811865475, 0.0, -0.7071067811865475], [-0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch2 : _combine_solids_and_holes'
            union() {
              // 'etch2'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
        }
      }
    }
    // 'at_4_0'
    multmatrix(m=[[1.0, 0.0, 0.0, 4.4], [0.0, 1.0, 0.0, 5.0], [0.0, 0.0, 1.0, 5.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'at_4_0'
      color(c=[0.0, 0.0, 1.0, 1.0]) {
        // '_combine_solids_and_holes'
        difference() {
          // 'at_4_0 : _combine_solids_and_holes'
          union() {
            // 'outer'
            multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, -3.5], [0.0, 0.0, 0.0, 1.0]]) {
              // 'outer : _combine_solids_and_holes'
              union() {
                // 'outer'
                cube(size=[2.0, 2.7, 3.5]);
              }
            }
          }
          // 'at_4_0'
          multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch1 : _combine_solids_and_holes'
            union() {
              // 'etch1'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
          // 'at_4_0'
          multmatrix(m=[[0.7071067811865475, 0.7071067811865475, 0.0, -0.7071067811865475], [-0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch2 : _combine_solids_and_holes'
            union() {
              // 'etch2'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
        }
      }
    }
    // 'at_2_0'
    multmatrix(m=[[1.0, 0.0, 0.0, 4.4], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, 10.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'at_2_0'
      color(c=[1.0, 0.0, 1.0, 1.0]) {
        // '_combine_solids_and_holes'
        difference() {
          // 'at_2_0 : _combine_solids_and_holes'
          union() {
            // 'outer'
            multmatrix(m=[[-0.0, -1.0, -0.0, 2.7], [0.0, 0.0, 1.0, 0.0], [-1.0, -0.0, -0.0, -0.0], [0.0, 0.0, 0.0, 1.0]]) {
              // 'outer : _combine_solids_and_holes'
              union() {
                // 'outer'
                cube(size=[2.0, 2.7, 3.5]);
              }
            }
          }
          // 'at_2_0'
          multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch1 : _combine_solids_and_holes'
            union() {
              // 'etch1'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
          // 'at_2_0'
          multmatrix(m=[[0.7071067811865475, 0.7071067811865475, 0.0, -0.7071067811865475], [-0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch2 : _combine_solids_and_holes'
            union() {
              // 'etch2'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
        }
      }
    }
    // 'at_5_0'
    multmatrix(m=[[1.0, 0.0, 0.0, 4.4], [0.0, 1.0, 0.0, 5.0], [0.0, 0.0, 1.0, 10.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'at_5_0'
      color(c=[0.0, 1.0, 0.0, 1.0]) {
        // '_combine_solids_and_holes'
        difference() {
          // 'at_5_0 : _combine_solids_and_holes'
          union() {
            // 'outer'
            multmatrix(m=[[0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, 0.0], [1.0, 0.0, 0.0, -2.0], [0.0, 0.0, 0.0, 1.0]]) {
              // 'outer : _combine_solids_and_holes'
              union() {
                // 'outer'
                cube(size=[2.0, 2.7, 3.5]);
              }
            }
          }
          // 'at_5_0'
          multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch1 : _combine_solids_and_holes'
            union() {
              // 'etch1'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
          // 'at_5_0'
          multmatrix(m=[[0.7071067811865475, 0.7071067811865475, 0.0, -0.7071067811865475], [-0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch2 : _combine_solids_and_holes'
            union() {
              // 'etch2'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
        }
      }
    }
    // 'at_0_1'
    multmatrix(m=[[1.0, 0.0, 0.0, 8.8], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, 0.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'at_0_1'
      color(c=[0.0, 1.0, 0.0, 1.0]) {
        // '_combine_solids_and_holes'
        difference() {
          // 'at_0_1 : _combine_solids_and_holes'
          union() {
            // 'outer'
            multmatrix(m=[[0.0, 0.0, 1.0, 0.0], [-1.0, -0.0, -0.0, 2.0], [-0.0, -1.0, -0.0, -0.0], [0.0, 0.0, 0.0, 1.0]]) {
              // 'outer : _combine_solids_and_holes'
              union() {
                // 'outer'
                cube(size=[2.0, 2.7, 3.5]);
              }
            }
          }
          // 'at_0_1'
          multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch1 : _combine_solids_and_holes'
            union() {
              // 'etch1'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
          // 'at_0_1'
          multmatrix(m=[[0.7071067811865475, 0.7071067811865475, 0.0, -0.7071067811865475], [-0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch2 : _combine_solids_and_holes'
            union() {
              // 'etch2'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
        }
      }
    }
    // 'at_3_1'
    multmatrix(m=[[1.0, 0.0, 0.0, 8.8], [0.0, 1.0, 0.0, 5.0], [0.0, 0.0, 1.0, 0.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'at_3_1'
      color(c=[1.0, 0.0, 1.0, 1.0]) {
        // '_combine_solids_and_holes'
        difference() {
          // 'at_3_1 : _combine_solids_and_holes'
          union() {
            // 'outer'
            multmatrix(m=[[-0.0, -0.0, -1.0, 3.5], [-1.0, -0.0, -0.0, 2.0], [0.0, 1.0, 0.0, -2.7], [0.0, 0.0, 0.0, 1.0]]) {
              // 'outer : _combine_solids_and_holes'
              union() {
                // 'outer'
                cube(size=[2.0, 2.7, 3.5]);
              }
            }
          }
          // 'at_3_1'
          multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch1 : _combine_solids_and_holes'
            union() {
              // 'etch1'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
          // 'at_3_1'
          multmatrix(m=[[0.7071067811865475, 0.7071067811865475, 0.0, -0.7071067811865475], [-0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch2 : _combine_solids_and_holes'
            union() {
              // 'etch2'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
        }
      }
    }
    // 'at_1_1'
    multmatrix(m=[[1.0, 0.0, 0.0, 8.8], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, 5.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'at_1_1'
      color(c=[1.0, 0.0, 0.0, 1.0]) {
        // '_combine_solids_and_holes'
        difference() {
          // 'at_1_1 : _combine_solids_and_holes'
          union() {
            // 'outer'
            multmatrix(m=[[-0.0, -1.0, -0.0, 2.7], [-1.0, -0.0, -0.0, 2.0], [-0.0, -0.0, -1.0, -0.0], [0.0, 0.0, 0.0, 1.0]]) {
              // 'outer : _combine_solids_and_holes'
              union() {
                // 'outer'
                cube(size=[2.0, 2.7, 3.5]);
              }
            }
          }
          // 'at_1_1'
          multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch1 : _combine_solids_and_holes'
            union() {
              // 'etch1'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
          // 'at_1_1'
          multmatrix(m=[[0.7071067811865475, 0.7071067811865475, 0.0, -0.7071067811865475], [-0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch2 : _combine_solids_and_holes'
            union() {
              // 'etch2'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
        }
      }
    }
    // 'at_4_1'
    multmatrix(m=[[1.0, 0.0, 0.0, 8.8], [0.0, 1.0, 0.0, 5.0], [0.0, 0.0, 1.0, 5.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'at_4_1'
      color(c=[1.0, 1.0, 0.0, 1.0]) {
        // '_combine_solids_and_holes'
        difference() {
          // 'at_4_1 : _combine_solids_and_holes'
          union() {
            // 'outer'
            multmatrix(m=[[0.0, 1.0, 0.0, 0.0], [-1.0, -0.0, -0.0, 2.0], [0.0, 0.0, 1.0, -3.5], [0.0, 0.0, 0.0, 1.0]]) {
              // 'outer : _combine_solids_and_holes'
              union() {
                // 'outer'
                cube(size=[2.0, 2.7, 3.5]);
              }
            }
          }
          // 'at_4_1'
          multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch1 : _combine_solids_and_holes'
            union() {
              // 'etch1'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
          // 'at_4_1'
          multmatrix(m=[[0.7071067811865475, 0.7071067811865475, 0.0, -0.7071067811865475], [-0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch2 : _combine_solids_and_holes'
            union() {
              // 'etch2'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
        }
      }
    }
    // 'at_2_1'
    multmatrix(m=[[1.0, 0.0, 0.0, 8.8], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, 10.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'at_2_1'
      color(c=[0.0, 1.0, 1.0, 1.0]) {
        // '_combine_solids_and_holes'
        difference() {
          // 'at_2_1 : _combine_solids_and_holes'
          union() {
            // 'outer'
            multmatrix(m=[[0.0, 0.0, 1.0, 0.0], [0.0, 1.0, 0.0, 0.0], [-1.0, -0.0, -0.0, -0.0], [0.0, 0.0, 0.0, 1.0]]) {
              // 'outer : _combine_solids_and_holes'
              union() {
                // 'outer'
                cube(size=[2.0, 2.7, 3.5]);
              }
            }
          }
          // 'at_2_1'
          multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch1 : _combine_solids_and_holes'
            union() {
              // 'etch1'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
          // 'at_2_1'
          multmatrix(m=[[0.7071067811865475, 0.7071067811865475, 0.0, -0.7071067811865475], [-0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch2 : _combine_solids_and_holes'
            union() {
              // 'etch2'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
        }
      }
    }
    // 'at_5_1'
    multmatrix(m=[[1.0, 0.0, 0.0, 8.8], [0.0, 1.0, 0.0, 5.0], [0.0, 0.0, 1.0, 10.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'at_5_1'
      color(c=[0.0, 0.0, 1.0, 1.0]) {
        // '_combine_solids_and_holes'
        difference() {
          // 'at_5_1 : _combine_solids_and_holes'
          union() {
            // 'outer'
            multmatrix(m=[[0.0, 0.0, 1.0, 0.0], [-0.0, -1.0, -0.0, 2.7], [1.0, 0.0, 0.0, -2.0], [0.0, 0.0, 0.0, 1.0]]) {
              // 'outer : _combine_solids_and_holes'
              union() {
                // 'outer'
                cube(size=[2.0, 2.7, 3.5]);
              }
            }
          }
          // 'at_5_1'
          multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch1 : _combine_solids_and_holes'
            union() {
              // 'etch1'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
          // 'at_5_1'
          multmatrix(m=[[0.7071067811865475, 0.7071067811865475, 0.0, -0.7071067811865475], [-0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch2 : _combine_solids_and_holes'
            union() {
              // 'etch2'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
        }
      }
    }
    // 'at_0_2'
    multmatrix(m=[[1.0, 0.0, 0.0, 13.200000000000001], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, 0.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'at_0_2'
      color(c=[0.0, 0.0, 1.0, 1.0]) {
        // '_combine_solids_and_holes'
        difference() {
          // 'at_0_2 : _combine_solids_and_holes'
          union() {
            // 'outer'
            multmatrix(m=[[-1.0, -0.0, -0.0, 2.0], [-0.0, -0.0, -1.0, 3.5], [-0.0, -1.0, -0.0, -0.0], [0.0, 0.0, 0.0, 1.0]]) {
              // 'outer : _combine_solids_and_holes'
              union() {
                // 'outer'
                cube(size=[2.0, 2.7, 3.5]);
              }
            }
          }
          // 'at_0_2'
          multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch1 : _combine_solids_and_holes'
            union() {
              // 'etch1'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
          // 'at_0_2'
          multmatrix(m=[[0.7071067811865475, 0.7071067811865475, 0.0, -0.7071067811865475], [-0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch2 : _combine_solids_and_holes'
            union() {
              // 'etch2'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
        }
      }
    }
    // 'at_3_2'
    multmatrix(m=[[1.0, 0.0, 0.0, 13.200000000000001], [0.0, 1.0, 0.0, 5.0], [0.0, 0.0, 1.0, 0.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'at_3_2'
      color(c=[0.0, 1.0, 1.0, 1.0]) {
        // '_combine_solids_and_holes'
        difference() {
          // 'at_3_2 : _combine_solids_and_holes'
          union() {
            // 'outer'
            multmatrix(m=[[-1.0, -0.0, -0.0, 2.0], [0.0, 0.0, 1.0, 0.0], [0.0, 1.0, 0.0, -2.7], [0.0, 0.0, 0.0, 1.0]]) {
              // 'outer : _combine_solids_and_holes'
              union() {
                // 'outer'
                cube(size=[2.0, 2.7, 3.5]);
              }
            }
          }
          // 'at_3_2'
          multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch1 : _combine_solids_and_holes'
            union() {
              // 'etch1'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
          // 'at_3_2'
          multmatrix(m=[[0.7071067811865475, 0.7071067811865475, 0.0, -0.7071067811865475], [-0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch2 : _combine_solids_and_holes'
            union() {
              // 'etch2'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
        }
      }
    }
    // 'at_1_2'
    multmatrix(m=[[1.0, 0.0, 0.0, 13.200000000000001], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, 5.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'at_1_2'
      color(c=[0.0, 1.0, 0.0, 1.0]) {
        // '_combine_solids_and_holes'
        difference() {
          // 'at_1_2 : _combine_solids_and_holes'
          union() {
            // 'outer'
            multmatrix(m=[[-1.0, -0.0, -0.0, 2.0], [0.0, 1.0, 0.0, 0.0], [-0.0, -0.0, -1.0, -0.0], [0.0, 0.0, 0.0, 1.0]]) {
              // 'outer : _combine_solids_and_holes'
              union() {
                // 'outer'
                cube(size=[2.0, 2.7, 3.5]);
              }
            }
          }
          // 'at_1_2'
          multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch1 : _combine_solids_and_holes'
            union() {
              // 'etch1'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
          // 'at_1_2'
          multmatrix(m=[[0.7071067811865475, 0.7071067811865475, 0.0, -0.7071067811865475], [-0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch2 : _combine_solids_and_holes'
            union() {
              // 'etch2'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
        }
      }
    }
    // 'at_4_2'
    multmatrix(m=[[1.0, 0.0, 0.0, 13.200000000000001], [0.0, 1.0, 0.0, 5.0], [0.0, 0.0, 1.0, 5.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'at_4_2'
      color(c=[1.0, 0.0, 1.0, 1.0]) {
        // '_combine_solids_and_holes'
        difference() {
          // 'at_4_2 : _combine_solids_and_holes'
          union() {
            // 'outer'
            multmatrix(m=[[-1.0, -0.0, -0.0, 2.0], [-0.0, -1.0, -0.0, 2.7], [0.0, 0.0, 1.0, -3.5], [0.0, 0.0, 0.0, 1.0]]) {
              // 'outer : _combine_solids_and_holes'
              union() {
                // 'outer'
                cube(size=[2.0, 2.7, 3.5]);
              }
            }
          }
          // 'at_4_2'
          multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch1 : _combine_solids_and_holes'
            union() {
              // 'etch1'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
          // 'at_4_2'
          multmatrix(m=[[0.7071067811865475, 0.7071067811865475, 0.0, -0.7071067811865475], [-0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch2 : _combine_solids_and_holes'
            union() {
              // 'etch2'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
        }
      }
    }
    // 'at_2_2'
    multmatrix(m=[[1.0, 0.0, 0.0, 13.200000000000001], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, 10.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'at_2_2'
      color(c=[1.0, 0.0, 0.0, 1.0]) {
        // '_combine_solids_and_holes'
        difference() {
          // 'at_2_2 : _combine_solids_and_holes'
          union() {
            // 'outer'
            multmatrix(m=[[0.0, 1.0, 0.0, 0.0], [-0.0, -0.0, -1.0, 3.5], [-1.0, -0.0, -0.0, -0.0], [0.0, 0.0, 0.0, 1.0]]) {
              // 'outer : _combine_solids_and_holes'
              union() {
                // 'outer'
                cube(size=[2.0, 2.7, 3.5]);
              }
            }
          }
          // 'at_2_2'
          multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch1 : _combine_solids_and_holes'
            union() {
              // 'etch1'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
          // 'at_2_2'
          multmatrix(m=[[0.7071067811865475, 0.7071067811865475, 0.0, -0.7071067811865475], [-0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch2 : _combine_solids_and_holes'
            union() {
              // 'etch2'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
        }
      }
    }
    // 'at_5_2'
    multmatrix(m=[[1.0, 0.0, 0.0, 13.200000000000001], [0.0, 1.0, 0.0, 5.0], [0.0, 0.0, 1.0, 10.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'at_5_2'
      color(c=[1.0, 1.0, 0.0, 1.0]) {
        // '_combine_solids_and_holes'
        difference() {
          // 'at_5_2 : _combine_solids_and_holes'
          union() {
            // 'outer'
            multmatrix(m=[[-0.0, -1.0, -0.0, 2.7], [-0.0, -0.0, -1.0, 3.5], [1.0, 0.0, 0.0, -2.0], [0.0, 0.0, 0.0, 1.0]]) {
              // 'outer : _combine_solids_and_holes'
              union() {
                // 'outer'
                cube(size=[2.0, 2.7, 3.5]);
              }
            }
          }
          // 'at_5_2'
          multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch1 : _combine_solids_and_holes'
            union() {
              // 'etch1'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
          // 'at_5_2'
          multmatrix(m=[[0.7071067811865475, 0.7071067811865475, 0.0, -0.7071067811865475], [-0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch2 : _combine_solids_and_holes'
            union() {
              // 'etch2'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
        }
      }
    }
    // 'at_0_3'
    multmatrix(m=[[1.0, 0.0, 0.0, 17.6], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, 0.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'at_0_3'
      color(c=[1.0, 1.0, 0.0, 1.0]) {
        // '_combine_solids_and_holes'
        difference() {
          // 'at_0_3 : _combine_solids_and_holes'
          union() {
            // 'outer'
            multmatrix(m=[[-0.0, -0.0, -1.0, 3.5], [1.0, 0.0, 0.0, 0.0], [-0.0, -1.0, -0.0, -0.0], [0.0, 0.0, 0.0, 1.0]]) {
              // 'outer : _combine_solids_and_holes'
              union() {
                // 'outer'
                cube(size=[2.0, 2.7, 3.5]);
              }
            }
          }
          // 'at_0_3'
          multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch1 : _combine_solids_and_holes'
            union() {
              // 'etch1'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
          // 'at_0_3'
          multmatrix(m=[[0.7071067811865475, 0.7071067811865475, 0.0, -0.7071067811865475], [-0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch2 : _combine_solids_and_holes'
            union() {
              // 'etch2'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
        }
      }
    }
    // 'at_3_3'
    multmatrix(m=[[1.0, 0.0, 0.0, 17.6], [0.0, 1.0, 0.0, 5.0], [0.0, 0.0, 1.0, 0.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'at_3_3'
      color(c=[1.0, 0.0, 0.0, 1.0]) {
        // '_combine_solids_and_holes'
        difference() {
          // 'at_3_3 : _combine_solids_and_holes'
          union() {
            // 'outer'
            multmatrix(m=[[0.0, 0.0, 1.0, 0.0], [1.0, 0.0, 0.0, 0.0], [0.0, 1.0, 0.0, -2.7], [0.0, 0.0, 0.0, 1.0]]) {
              // 'outer : _combine_solids_and_holes'
              union() {
                // 'outer'
                cube(size=[2.0, 2.7, 3.5]);
              }
            }
          }
          // 'at_3_3'
          multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch1 : _combine_solids_and_holes'
            union() {
              // 'etch1'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
          // 'at_3_3'
          multmatrix(m=[[0.7071067811865475, 0.7071067811865475, 0.0, -0.7071067811865475], [-0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch2 : _combine_solids_and_holes'
            union() {
              // 'etch2'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
        }
      }
    }
    // 'at_1_3'
    multmatrix(m=[[1.0, 0.0, 0.0, 17.6], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, 5.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'at_1_3'
      color(c=[0.0, 0.0, 1.0, 1.0]) {
        // '_combine_solids_and_holes'
        difference() {
          // 'at_1_3 : _combine_solids_and_holes'
          union() {
            // 'outer'
            multmatrix(m=[[0.0, 1.0, 0.0, 0.0], [1.0, 0.0, 0.0, 0.0], [-0.0, -0.0, -1.0, -0.0], [0.0, 0.0, 0.0, 1.0]]) {
              // 'outer : _combine_solids_and_holes'
              union() {
                // 'outer'
                cube(size=[2.0, 2.7, 3.5]);
              }
            }
          }
          // 'at_1_3'
          multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch1 : _combine_solids_and_holes'
            union() {
              // 'etch1'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
          // 'at_1_3'
          multmatrix(m=[[0.7071067811865475, 0.7071067811865475, 0.0, -0.7071067811865475], [-0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch2 : _combine_solids_and_holes'
            union() {
              // 'etch2'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
        }
      }
    }
    // 'at_4_3'
    multmatrix(m=[[1.0, 0.0, 0.0, 17.6], [0.0, 1.0, 0.0, 5.0], [0.0, 0.0, 1.0, 5.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'at_4_3'
      color(c=[0.0, 1.0, 1.0, 1.0]) {
        // '_combine_solids_and_holes'
        difference() {
          // 'at_4_3 : _combine_solids_and_holes'
          union() {
            // 'outer'
            multmatrix(m=[[-0.0, -1.0, -0.0, 2.7], [1.0, 0.0, 0.0, 0.0], [0.0, 0.0, 1.0, -3.5], [0.0, 0.0, 0.0, 1.0]]) {
              // 'outer : _combine_solids_and_holes'
              union() {
                // 'outer'
                cube(size=[2.0, 2.7, 3.5]);
              }
            }
          }
          // 'at_4_3'
          multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch1 : _combine_solids_and_holes'
            union() {
              // 'etch1'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
          // 'at_4_3'
          multmatrix(m=[[0.7071067811865475, 0.7071067811865475, 0.0, -0.7071067811865475], [-0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch2 : _combine_solids_and_holes'
            union() {
              // 'etch2'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
        }
      }
    }
    // 'at_2_3'
    multmatrix(m=[[1.0, 0.0, 0.0, 17.6], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, 10.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'at_2_3'
      color(c=[0.0, 1.0, 0.0, 1.0]) {
        // '_combine_solids_and_holes'
        difference() {
          // 'at_2_3 : _combine_solids_and_holes'
          union() {
            // 'outer'
            multmatrix(m=[[-0.0, -0.0, -1.0, 3.5], [-0.0, -1.0, -0.0, 2.7], [-1.0, -0.0, -0.0, -0.0], [0.0, 0.0, 0.0, 1.0]]) {
              // 'outer : _combine_solids_and_holes'
              union() {
                // 'outer'
                cube(size=[2.0, 2.7, 3.5]);
              }
            }
          }
          // 'at_2_3'
          multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch1 : _combine_solids_and_holes'
            union() {
              // 'etch1'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
          // 'at_2_3'
          multmatrix(m=[[0.7071067811865475, 0.7071067811865475, 0.0, -0.7071067811865475], [-0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch2 : _combine_solids_and_holes'
            union() {
              // 'etch2'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
        }
      }
    }
    // 'at_5_3'
    multmatrix(m=[[1.0, 0.0, 0.0, 17.6], [0.0, 1.0, 0.0, 5.0], [0.0, 0.0, 1.0, 10.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'at_5_3'
      color(c=[1.0, 0.0, 1.0, 1.0]) {
        // '_combine_solids_and_holes'
        difference() {
          // 'at_5_3 : _combine_solids_and_holes'
          union() {
            // 'outer'
            multmatrix(m=[[-0.0, -0.0, -1.0, 3.5], [0.0, 1.0, 0.0, 0.0], [1.0, 0.0, 0.0, -2.0], [0.0, 0.0, 0.0, 1.0]]) {
              // 'outer : _combine_solids_and_holes'
              union() {
                // 'outer'
                cube(size=[2.0, 2.7, 3.5]);
              }
            }
          }
          // 'at_5_3'
          multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch1 : _combine_solids_and_holes'
            union() {
              // 'etch1'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
          // 'at_5_3'
          multmatrix(m=[[0.7071067811865475, 0.7071067811865475, 0.0, -0.7071067811865475], [-0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
            // 'etch2 : _combine_solids_and_holes'
            union() {
              // 'etch2'
              cube(size=[1.0, 1.0, 1.0]);
            }
          }
        }
      }
    }
  }
} // end module default_5_default_5

