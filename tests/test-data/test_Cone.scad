// Start: lazy_union
default_5_default_5();
// End: lazy_union

// Modules.

// 'PartMaterial undef-default - undef-default'
module default_5_default_5() {
  // 'None : _combine_solids_and_holes'
  union() {
    // 'cone1'
    multmatrix(m=[[1.0, 0.0, 0.0, 0.0], [0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 1.0, -40.0], [0.0, 0.0, 0.0, 1.0]]) {
      // 'cone1'
      color(c=[0.1, 1.0, 0.0, 1.0]) {
        // 'cone1 : _combine_solids_and_holes'
        union() {
          // 'cone1'
          cylinder(h=40.0, r1=22.0, r2=4.0, center=false, $fn=40);
        }
      }
    }
    // 'cone2'
    multmatrix(m=[[-0.7071067811865476, 0.2901716460986225, -0.6448258802191611, 31.76129396309576], [0.7071067811865476, 0.2901716460986225, -0.6448258802191611, 31.76129396309576], [0.0, -0.9119215051751064, -0.4103646773287979, -5.637236293492073], [0.0, 0.0, 0.0, 1.0]]) {
      // 'cone2'
      color(c=[0.0, 1.0, 0.0, 1.0]) {
        // 'cone2 : _combine_solids_and_holes'
        union() {
          // 'cone2'
          cylinder(h=40.0, r1=10.0, r2=5.0, center=false);
        }
      }
    }
  }
} // end module default_5_default_5

