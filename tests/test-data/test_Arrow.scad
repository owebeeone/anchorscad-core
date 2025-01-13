// Start: lazy_union
default_5_default_5();
// End: lazy_union

// Modules.

// 'PartMaterial undef-default - undef-default'
module default_5_default_5() {
  // 'None : _combine_solids_and_holes'
  union() {
    // 'x'
    color(c=[0.1, 1.0, 0.0, 1.0]) {
      // 'x : _combine_solids_and_holes'
      union() {
        // 'stem'
        multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [-0.0, -1.0, -0.0, -0.0], [-0.0, -0.0, -1.0, -0.0], [0.0, 0.0, 0.0, 1.0]]) {
          // 'stem : _combine_solids_and_holes'
          union() {
            // 'stem'
            cylinder(h=10.0, r1=1.0, r2=1.0, center=false, $fn=40);
          }
        }
        // 'head'
        multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, -1.0, 0.0, 0.0], [0.0, 0.0, -1.0, -10.0], [0.0, 0.0, 0.0, 1.0]]) {
          // 'head : _combine_solids_and_holes'
          union() {
            // 'head'
            cylinder(h=3.0, r1=2.0, r2=0.0, center=false, $fn=40);
          }
        }
      }
    }
  }
} // end module default_5_default_5

