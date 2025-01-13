// Start: lazy_union
default_5_default_5();
// End: lazy_union

// Modules.

// 'PartMaterial undef-default - undef-default'
module default_5_default_5() {
  // 'None : _combine_solids_and_holes'
  union() {
    // 'intersection1 : _combine_solids_and_holes'
    intersection() {
      // 'box'
      multmatrix(m=[[1.0, 0.0, 0.0, -2.0], [0.0, 0.0, 1.0, -2.0], [-0.0, -1.0, -0.0, -0.0], [0.0, 0.0, 0.0, 1.0]]) {
        // 'box'
        color(c=[0.0, 0.0, 1.0, 1.0]) {
          // 'box : _combine_solids_and_holes'
          union() {
            // 'box'
            cube(size=[4.0, 4.0, 4.0]);
          }
        }
      }
      // 'sphere'
      multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, 0.0, -1.0, 0.0], [0.0, 1.0, 0.0, -2.0], [0.0, 0.0, 0.0, 1.0]]) {
        // 'sphere'
        color(c=[0.0, 1.0, 0.0, 1.0]) {
          // 'sphere : _combine_solids_and_holes'
          union() {
            // 'sphere'
            sphere(r=3.0, $fn=32);
          }
        }
      }
    }
  }
} // end module default_5_default_5

