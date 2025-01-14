// Start: lazy_union
default_5_default_5();
// End: lazy_union

// Modules.

// 'PartMaterial undef-default - undef-default'
module default_5_default_5() {
  // 'None : _combine_solids_and_holes'
  union() {
    linear_extrude(height=40.0, twist=0.0, slices=4, scale=[1.0, 1.0], $fn=30) {
      polygon(points=[[0.0, 0.0], [100.0, 0.0], [99.89631588001659, 4.609175002087101], [99.58547328390507, 9.209025160194866], [99.06810107880757, 13.79024449548039], [98.34524596290532, 18.343564721207464], [97.41837034783867, 22.85977399346182], [96.28934940009508, 27.329735547676524], [94.96046724735083, 31.744406183264097], [93.43441235744142, 36.09485455895882], [91.71427209930943, 40.372279261855994], [89.8035264969336, 44.56802661359237], [87.7060411888758, 48.6736081776443], [85.4260596076891, 52.6807179323242], [82.96819439500906, 56.58124907473271], [80.33741806969647, 60.367310421670474], [77.5390529679106, 64.03124237432849], [74.57876047546554, 67.56563241445913], [71.46252957425342, 70.96333010067725], [68.19666472590659, 74.21746153455233], [64.78777311721109, 77.3214432672252], [61.24275129307556, 80.26899561841493], [57.56877120409817, 83.05415538087006], [53.77326569695918, 85.67128788456164], [49.863913476993204, 88.11509839621112], [45.84862357336381, 90.38064283109061], [41.7355193382688, 92.46333775542416], [37.53292201254748, 94.35896965915477], [33.24933389093864, 96.06370348031658], [28.89342112104732, 97.57409036376706], [24.473996170820325, 98.88707463858242], [20.000000000000007, 100.0], [0.0, 100.0]]);
    }
  }
} // end module default_5_default_5
