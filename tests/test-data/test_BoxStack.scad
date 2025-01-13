// Start: lazy_union
default_5_default_5();
// End: lazy_union

// Modules.

// 'PartMaterial undef-default - undef-default'
module default_5_default_5() {
  // 'None : _combine_solids_and_holes'
  union() {
    // 'box1'
    multmatrix(m=[[1.0, 0.0, 0.0, -1.5], [0.0, 0.0, 1.0, -1.5], [-0.0, -1.0, -0.0, -0.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'box1'
      color(c=[0.0, 0.0, 1.0, 1.0]) {
        // 'box1 : _combine_solids_and_holes'
        union() {
          // 'box1'
          cube(size=[3.0, 3.0, 3.0]);
        }
      }
    }
    // 'box2'
    multmatrix(m=[[1.0, 0.0, 0.0, -3.0], [0.0, 0.0, -1.0, 3.0], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'box2'
      color(c=[0.0, 1.0, 0.0, 1.0]) {
        // 'box2 : _combine_solids_and_holes'
        union() {
          // 'box2'
          cube(size=[6.0, 6.0, 6.0]);
        }
      }
    }
    // 'box3'
    multmatrix(m=[[-1.0, 0.0, 0.0, 9.0], [0.0, 0.0, 1.0, -9.0], [0.0, 1.0, 0.0, 6.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'box3'
      color(c=[1.0, 0.0, 0.0, 1.0]) {
        // 'box3 : _combine_solids_and_holes'
        union() {
          // 'box3'
          cube(size=[9.0, 9.0, 9.0]);
        }
      }
    }
  }
} // end module default_5_default_5

