// Start: lazy_union
default_5_default_5();
// End: lazy_union

// Modules.

// 'PartMaterial undef-default - undef-default'
module default_5_default_5() {
  // 'None : _combine_solids_and_holes'
  union() {
    // 'outer'
    multmatrix(m=[[0.7071067811865475, 0.7071067811865475, 0.0, -0.7071067811865475], [-0.7071067811865475, 0.7071067811865475, 0.0, 0.0], [0.0, 0.0, 1.0, -0.5], [0.0, 0.0, 0.0, 1.0]]) {
      // 'outer : _combine_solids_and_holes'
      union() {
        // 'outer'
        cube(size=[1.0, 1.0, 1.0]);
      }
    }
  }
} // end module default_5_default_5

