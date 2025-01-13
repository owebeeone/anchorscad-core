// Start: lazy_union
default_5_default_5();
// End: lazy_union

// Modules.

// 'PartMaterial undef-default - undef-default'
module default_5_default_5() {
  // 'None : _combine_solids_and_holes'
  union() {
    // 'thing1'
    color(c=[1.0, 0.0, 0.0, 1.0]) {
      // 'thing1 : _combine_solids_and_holes'
      union() {
        // 'thing1'
        cube(size=[2.0, 3.0, 4.0]);
      }
    }
  }
} // end module default_5_default_5

