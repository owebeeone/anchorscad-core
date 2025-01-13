// Start: lazy_union
default_5_default_5();
// End: lazy_union

// Modules.

// 'PartMaterial undef-default - undef-default'
module default_5_default_5() {
  // 'None : _combine_solids_and_holes'
  union() {
    // 'block'
    multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, 0.0, 1.0, 0.0], [-0.0, -1.0, -0.0, -0.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'block : _combine_solids_and_holes'
      union() {
        // 'block'
        cube(size=[3.0, 4.0, 6.0]);
      }
    }
    // 'corner_0'
    multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
      // 'corner_0'
      color(c=[1.0, 0.0, 0.0, 1.0]) {
        // 'corner_0 : _combine_solids_and_holes'
        union() {
          // 'corner_0'
          cube(size=[1.0, 1.0, 1.0]);
        }
      }
    }
    // 'corner_4'
    multmatrix(m=[[1.0, 0.0, 0.0, -0.5], [0.0, -1.0, 0.0, 6.5], [0.0, 0.0, -1.0, -3.5], [0.0, 0.0, 0.0, 1.0]]) {
      // 'corner_4'
      color(c=[1.0, 1.0, 0.0, 1.0]) {
        // 'corner_4 : _combine_solids_and_holes'
        union() {
          // 'corner_4'
          cube(size=[1.0, 1.0, 1.0]);
        }
      }
    }
    // 'corner_1'
    multmatrix(m=[[0.0, -1.0, 0.0, 3.5], [1.0, 0.0, 0.0, -0.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
      // 'corner_1'
      color(c=[0.0, 1.0, 0.0, 1.0]) {
        // 'corner_1 : _combine_solids_and_holes'
        union() {
          // 'corner_1'
          cube(size=[1.0, 1.0, 1.0]);
        }
      }
    }
    // 'corner_5'
    multmatrix(m=[[0.0, -1.0, 0.0, 3.5], [-1.0, 0.0, 0.0, 6.5], [0.0, 0.0, -1.0, -3.5], [0.0, 0.0, 0.0, 1.0]]) {
      // 'corner_5'
      color(c=[1.0, 0.0, 1.0, 1.0]) {
        // 'corner_5 : _combine_solids_and_holes'
        union() {
          // 'corner_5'
          cube(size=[1.0, 1.0, 1.0]);
        }
      }
    }
    // 'corner_2'
    multmatrix(m=[[-1.0, 0.0, 0.0, 3.5], [0.0, -1.0, 0.0, 6.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
      // 'corner_2'
      color(c=[0.0, 0.0, 1.0, 1.0]) {
        // 'corner_2 : _combine_solids_and_holes'
        union() {
          // 'corner_2'
          cube(size=[1.0, 1.0, 1.0]);
        }
      }
    }
    // 'corner_6'
    multmatrix(m=[[-1.0, 0.0, 0.0, 3.5], [0.0, 1.0, 0.0, -0.5], [0.0, 0.0, -1.0, -3.5], [0.0, 0.0, 0.0, 1.0]]) {
      // 'corner_6'
      color(c=[0.0, 1.0, 1.0, 1.0]) {
        // 'corner_6 : _combine_solids_and_holes'
        union() {
          // 'corner_6'
          cube(size=[1.0, 1.0, 1.0]);
        }
      }
    }
    // 'corner_3'
    multmatrix(m=[[0.0, 1.0, 0.0, -0.5], [-1.0, 0.0, 0.0, 6.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
      // 'corner_3'
      color(c=[1.0, 1.0, 0.0, 1.0]) {
        // 'corner_3 : _combine_solids_and_holes'
        union() {
          // 'corner_3'
          cube(size=[1.0, 1.0, 1.0]);
        }
      }
    }
    // 'corner_7'
    multmatrix(m=[[0.0, 1.0, 0.0, -0.5], [1.0, 0.0, 0.0, -0.5], [0.0, 0.0, -1.0, -3.5], [0.0, 0.0, 0.0, 1.0]]) {
      // 'corner_7'
      color(c=[1.0, 0.0, 0.0, 1.0]) {
        // 'corner_7 : _combine_solids_and_holes'
        union() {
          // 'corner_7'
          cube(size=[1.0, 1.0, 1.0]);
        }
      }
    }
    // 'face_0'
    multmatrix(m=[[1.0, 0.0, 0.0, 1.0], [0.0, 1.0, 0.0, 2.5], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
      // 'face_0'
      color(c=[1.0, 0.0, 1.0, 1.0]) {
        // 'face_0 : _combine_solids_and_holes'
        union() {
          // 'face_0'
          cube(size=[1.0, 1.0, 1.0]);
        }
      }
    }
    // 'face_1'
    multmatrix(m=[[1.0, 0.0, 0.0, 1.0], [0.0, 0.0, -1.0, 0.5], [0.0, 1.0, 0.0, -2.5], [0.0, 0.0, 0.0, 1.0]]) {
      // 'face_1'
      color(c=[1.0, 1.0, 0.0, 1.0]) {
        // 'face_1 : _combine_solids_and_holes'
        union() {
          // 'face_1'
          cube(size=[1.0, 1.0, 1.0]);
        }
      }
    }
    // 'face_2'
    multmatrix(m=[[0.0, 0.0, -1.0, 0.5], [0.0, 1.0, 0.0, 2.5], [1.0, 0.0, 0.0, -2.5], [0.0, 0.0, 0.0, 1.0]]) {
      // 'face_2'
      color(c=[0.0, 0.0, 1.0, 1.0]) {
        // 'face_2 : _combine_solids_and_holes'
        union() {
          // 'face_2'
          cube(size=[1.0, 1.0, 1.0]);
        }
      }
    }
    // 'face_3'
    multmatrix(m=[[1.0, 0.0, 0.0, 1.0], [0.0, -1.0, 0.0, 3.5], [0.0, 0.0, -1.0, -3.5], [0.0, 0.0, 0.0, 1.0]]) {
      // 'face_3'
      color(c=[0.0, 1.0, 0.0, 1.0]) {
        // 'face_3 : _combine_solids_and_holes'
        union() {
          // 'face_3'
          cube(size=[1.0, 1.0, 1.0]);
        }
      }
    }
    // 'face_4'
    multmatrix(m=[[1.0, 0.0, 0.0, 1.0], [0.0, 0.0, 1.0, 5.5], [0.0, -1.0, 0.0, -1.5], [0.0, 0.0, 0.0, 1.0]]) {
      // 'face_4'
      color(c=[1.0, 0.0, 0.0, 1.0]) {
        // 'face_4 : _combine_solids_and_holes'
        union() {
          // 'face_4'
          cube(size=[1.0, 1.0, 1.0]);
        }
      }
    }
    // 'face_5'
    multmatrix(m=[[0.0, 0.0, 1.0, 2.5], [0.0, 1.0, 0.0, 2.5], [-1.0, 0.0, 0.0, -1.5], [0.0, 0.0, 0.0, 1.0]]) {
      // 'face_5'
      color(c=[0.0, 1.0, 1.0, 1.0]) {
        // 'face_5 : _combine_solids_and_holes'
        union() {
          // 'face_5'
          cube(size=[1.0, 1.0, 1.0]);
        }
      }
    }
  }
} // end module default_5_default_5

