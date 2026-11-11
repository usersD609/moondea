// Independently generated synthetic oracle fixtures. Regenerate with tools/generate_oracles.py.

///|
test "independent HiGHS fixture 00" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4"],
    [[2.0], [6.0], [15.0], [1.0], [8.0]],
    [[3.0], [1.0], [4.0], [2.0], [8.0]],
  ).unwrap()
  near(input_radial(d, 0, d, CRS).unwrap().factor, 0.75)
  near(output_radial(d, 0, d, CRS).unwrap().factor, 1.3333333333333333)
  near(additive(d, 0, d, CRS).unwrap().normalized_gain, 0.33333333333333326)
  near(
    directional(d, 0, d, CRS, [1.0], [1.0]).unwrap().distance,
    0.14285714285714285,
  )
  near(input_radial(d, 0, d, VRS).unwrap().factor, 1.0)
  near(output_radial(d, 0, d, VRS).unwrap().factor, 1.0)
  near(additive(d, 0, d, VRS).unwrap().normalized_gain, 0.0)
  near(directional(d, 0, d, VRS, [1.0], [1.0]).unwrap().distance, -0.0)
  near(input_radial(d, 0, d, NIRS).unwrap().factor, 1.0)
  near(output_radial(d, 0, d, NIRS).unwrap().factor, 1.0)
  near(additive(d, 0, d, NIRS).unwrap().normalized_gain, 0.0)
  near(directional(d, 0, d, NIRS, [1.0], [1.0]).unwrap().distance, -0.0)
  near(input_radial(d, 0, d, NDRS).unwrap().factor, 0.75)
  near(output_radial(d, 0, d, NDRS).unwrap().factor, 1.3333333333333333)
  near(additive(d, 0, d, NDRS).unwrap().normalized_gain, 0.33333333333333326)
  near(
    directional(d, 0, d, NDRS, [1.0], [1.0]).unwrap().distance,
    0.14285714285714285,
  )
}

///|
test "independent HiGHS fixture 01" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4", "u5"],
    [
      [12.0, 4.0],
      [13.0, 8.0],
      [3.0, 12.0],
      [12.0, 6.0],
      [10.0, 2.0],
      [4.0, 7.0],
    ],
    [[13.0], [14.0], [6.0], [3.0], [13.0], [11.0]],
  ).unwrap()
  near(input_radial(d, 1, d, CRS).unwrap().factor, 0.6377663482733285)
  near(output_radial(d, 1, d, CRS).unwrap().factor, 1.5679723502304148)
  near(additive(d, 1, d, CRS).unwrap().normalized_gain, 0.9023668639053255)
  near(
    directional(d, 1, d, CRS, [1.0, 1.0], [1.0]).unwrap().distance,
    0.22117541498429788,
  )
  near(input_radial(d, 1, d, VRS).unwrap().factor, 1.0)
  near(output_radial(d, 1, d, VRS).unwrap().factor, 1.0)
  near(additive(d, 1, d, VRS).unwrap().normalized_gain, 0.0)
  near(directional(d, 1, d, VRS, [1.0, 1.0], [1.0]).unwrap().distance, -0.0)
  near(input_radial(d, 1, d, NIRS).unwrap().factor, 1.0)
  near(output_radial(d, 1, d, NIRS).unwrap().factor, 1.0)
  near(additive(d, 1, d, NIRS).unwrap().normalized_gain, -2.886579864025407e-15)
  near(directional(d, 1, d, NIRS, [1.0, 1.0], [1.0]).unwrap().distance, -0.0)
  near(input_radial(d, 1, d, NDRS).unwrap().factor, 0.6377663482733285)
  near(output_radial(d, 1, d, NDRS).unwrap().factor, 1.5679723502304148)
  near(additive(d, 1, d, NDRS).unwrap().normalized_gain, 0.9023668639053255)
  near(
    directional(d, 1, d, NDRS, [1.0, 1.0], [1.0]).unwrap().distance,
    0.22117541498429782,
  )
}

///|
test "independent HiGHS fixture 02" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4", "u5", "u6"],
    [
      [9.0, 2.0, 4.0],
      [16.0, 5.0, 4.0],
      [6.0, 4.0, 8.0],
      [13.0, 13.0, 15.0],
      [3.0, 8.0, 12.0],
      [11.0, 13.0, 7.0],
      [10.0, 2.0, 1.0],
    ],
    [[6.0], [10.0], [6.0], [7.0], [10.0], [11.0], [16.0]],
  ).unwrap()
  near(input_radial(d, 2, d, CRS).unwrap().factor, 0.5186915887850468)
  near(output_radial(d, 2, d, CRS).unwrap().factor, 1.927927927927928)
  near(additive(d, 2, d, CRS).unwrap().normalized_gain, 2.2249999999999996)
  near(
    directional(d, 2, d, CRS, [1.0, 1.0, 1.0], [1.0]).unwrap().distance,
    0.31692307692307675,
  )
  near(input_radial(d, 2, d, VRS).unwrap().factor, 1.0)
  near(output_radial(d, 2, d, VRS).unwrap().factor, 1.0)
  near(additive(d, 2, d, VRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 2, d, VRS, [1.0, 1.0, 1.0], [1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 2, d, NIRS).unwrap().factor, 0.5186915887850467)
  near(output_radial(d, 2, d, NIRS).unwrap().factor, 1.927927927927928)
  near(additive(d, 2, d, NIRS).unwrap().normalized_gain, 2.2249999999999996)
  near(
    directional(d, 2, d, NIRS, [1.0, 1.0, 1.0], [1.0]).unwrap().distance,
    0.31692307692307675,
  )
  near(input_radial(d, 2, d, NDRS).unwrap().factor, 1.0)
  near(output_radial(d, 2, d, NDRS).unwrap().factor, 1.0)
  near(additive(d, 2, d, NDRS).unwrap().normalized_gain, 6.661338147750939e-16)
  near(
    directional(d, 2, d, NDRS, [1.0, 1.0, 1.0], [1.0]).unwrap().distance,
    -0.0,
  )
}

///|
test "independent HiGHS fixture 03" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4", "u5", "u6", "u7"],
    [[1.0], [13.0], [14.0], [13.0], [5.0], [14.0], [11.0], [5.0]],
    [
      [4.0, 13.0],
      [3.0, 8.0],
      [13.0, 8.0],
      [1.0, 14.0],
      [8.0, 7.0],
      [8.0, 16.0],
      [5.0, 2.0],
      [2.0, 7.0],
    ],
  ).unwrap()
  near(input_radial(d, 3, d, CRS).unwrap().factor, 0.08284023668639054)
  near(output_radial(d, 3, d, CRS).unwrap().factor, 12.071428571428571)
  near(additive(d, 3, d, CRS).unwrap().normalized_gain, 62.07142857142857)
  near(
    directional(d, 3, d, CRS, [1.0], [1.0, 1.0]).unwrap().distance,
    0.8469945355191257,
  )
  near(input_radial(d, 3, d, VRS).unwrap().factor, 0.4102564102564103)
  near(output_radial(d, 3, d, VRS).unwrap().factor, 1.1263736263736266)
  near(additive(d, 3, d, VRS).unwrap().normalized_gain, 7.798076923076923)
  near(
    directional(d, 3, d, VRS, [1.0], [1.0, 1.0]).unwrap().distance,
    0.1040723981900453,
  )
  near(input_radial(d, 3, d, NIRS).unwrap().factor, 0.4102564102564103)
  near(output_radial(d, 3, d, NIRS).unwrap().factor, 1.1263736263736266)
  near(additive(d, 3, d, NIRS).unwrap().normalized_gain, 7.798076923076927)
  near(
    directional(d, 3, d, NIRS, [1.0], [1.0, 1.0]).unwrap().distance,
    0.10407239819004535,
  )
  near(input_radial(d, 3, d, NDRS).unwrap().factor, 0.08284023668639054)
  near(output_radial(d, 3, d, NDRS).unwrap().factor, 12.071428571428557)
  near(additive(d, 3, d, NDRS).unwrap().normalized_gain, 62.071428571428584)
  near(
    directional(d, 3, d, NDRS, [1.0], [1.0, 1.0]).unwrap().distance,
    0.8469945355191257,
  )
}

///|
test "independent HiGHS fixture 04" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4"],
    [[9.0, 9.0], [15.0, 3.0], [10.0, 8.0], [3.0, 5.0], [8.0, 9.0]],
    [[9.0, 14.0], [11.0, 9.0], [13.0, 12.0], [9.0, 4.0], [14.0, 13.0]],
  ).unwrap()
  near(input_radial(d, 4, d, CRS).unwrap().factor, 0.9999999999999998)
  near(output_radial(d, 4, d, CRS).unwrap().factor, 1.0000000000000002)
  near(additive(d, 4, d, CRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 4, d, CRS, [1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 4, d, VRS).unwrap().factor, 1.0)
  near(output_radial(d, 4, d, VRS).unwrap().factor, 1.0)
  near(additive(d, 4, d, VRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 4, d, VRS, [1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 4, d, NIRS).unwrap().factor, 0.9999999999999998)
  near(output_radial(d, 4, d, NIRS).unwrap().factor, 1.0000000000000002)
  near(additive(d, 4, d, NIRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 4, d, NIRS, [1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 4, d, NDRS).unwrap().factor, 0.9999999999999998)
  near(output_radial(d, 4, d, NDRS).unwrap().factor, 1.0000000000000002)
  near(additive(d, 4, d, NDRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 4, d, NDRS, [1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    -0.0,
  )
}

///|
test "independent HiGHS fixture 05" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4", "u5"],
    [
      [8.0, 15.0, 16.0],
      [16.0, 12.0, 5.0],
      [8.0, 4.0, 1.0],
      [2.0, 1.0, 1.0],
      [7.0, 14.0, 12.0],
      [14.0, 9.0, 7.0],
    ],
    [
      [7.0, 16.0],
      [14.0, 12.0],
      [9.0, 5.0],
      [1.0, 10.0],
      [5.0, 5.0],
      [12.0, 8.0],
    ],
  ).unwrap()
  near(input_radial(d, 5, d, CRS).unwrap().factor, 0.7731092436974789)
  near(output_radial(d, 5, d, CRS).unwrap().factor, 1.2934782608695654)
  near(additive(d, 5, d, CRS).unwrap().normalized_gain, 4.02579365079365)
  near(
    directional(d, 5, d, CRS, [1.0, 1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    0.12796208530805683,
  )
  near(input_radial(d, 5, d, VRS).unwrap().factor, 0.9777777777777779)
  near(output_radial(d, 5, d, VRS).unwrap().factor, 1.0104166666666667)
  near(additive(d, 5, d, VRS).unwrap().normalized_gain, 0.7722222222222221)
  near(
    directional(d, 5, d, VRS, [1.0, 1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    0.007092198581560331,
  )
  near(input_radial(d, 5, d, NIRS).unwrap().factor, 0.9777777777777776)
  near(output_radial(d, 5, d, NIRS).unwrap().factor, 1.0104166666666667)
  near(additive(d, 5, d, NIRS).unwrap().normalized_gain, 0.7722222222222221)
  near(
    directional(d, 5, d, NIRS, [1.0, 1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    0.007092198581560349,
  )
  near(input_radial(d, 5, d, NDRS).unwrap().factor, 0.7731092436974789)
  near(output_radial(d, 5, d, NDRS).unwrap().factor, 1.2934782608695654)
  near(additive(d, 5, d, NDRS).unwrap().normalized_gain, 4.02579365079365)
  near(
    directional(d, 5, d, NDRS, [1.0, 1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    0.12796208530805686,
  )
}

///|
test "independent HiGHS fixture 06" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4", "u5", "u6"],
    [[6.0], [11.0], [10.0], [10.0], [10.0], [4.0], [6.0]],
    [
      [3.0, 16.0, 1.0],
      [14.0, 13.0, 3.0],
      [1.0, 9.0, 7.0],
      [10.0, 9.0, 2.0],
      [16.0, 9.0, 2.0],
      [9.0, 14.0, 4.0],
      [7.0, 12.0, 7.0],
    ],
  ).unwrap()
  near(input_radial(d, 6, d, CRS).unwrap().factor, 1.0)
  near(output_radial(d, 6, d, CRS).unwrap().factor, 0.9999999999999998)
  near(additive(d, 6, d, CRS).unwrap().normalized_gain, 3.1086244689504383e-15)
  near(
    directional(d, 6, d, CRS, [1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 6, d, VRS).unwrap().factor, 1.0)
  near(output_radial(d, 6, d, VRS).unwrap().factor, 1.0)
  near(additive(d, 6, d, VRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 6, d, VRS, [1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 6, d, NIRS).unwrap().factor, 1.0)
  near(output_radial(d, 6, d, NIRS).unwrap().factor, 1.0)
  near(additive(d, 6, d, NIRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 6, d, NIRS, [1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 6, d, NDRS).unwrap().factor, 1.0)
  near(output_radial(d, 6, d, NDRS).unwrap().factor, 1.0000000000000004)
  near(additive(d, 6, d, NDRS).unwrap().normalized_gain, -3.552713678800501e-15)
  near(
    directional(d, 6, d, NDRS, [1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    -0.0,
  )
}

///|
test "independent HiGHS fixture 07" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4", "u5", "u6", "u7"],
    [
      [9.0, 11.0],
      [5.0, 12.0],
      [15.0, 9.0],
      [7.0, 6.0],
      [4.0, 13.0],
      [16.0, 16.0],
      [2.0, 1.0],
      [4.0, 6.0],
    ],
    [
      [10.0, 7.0, 6.0],
      [1.0, 2.0, 9.0],
      [6.0, 9.0, 8.0],
      [3.0, 8.0, 7.0],
      [6.0, 13.0, 16.0],
      [9.0, 7.0, 8.0],
      [15.0, 7.0, 5.0],
      [15.0, 12.0, 2.0],
    ],
  ).unwrap()
  near(input_radial(d, 7, d, CRS).unwrap().factor, 0.8571428571428573)
  near(output_radial(d, 7, d, CRS).unwrap().factor, 1.1666666666666667)
  near(additive(d, 7, d, CRS).unwrap().normalized_gain, 5.833333333333336)
  near(
    directional(d, 7, d, CRS, [1.0, 1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    0.0769230769230768,
  )
  near(input_radial(d, 7, d, VRS).unwrap().factor, 1.0)
  near(output_radial(d, 7, d, VRS).unwrap().factor, 1.0)
  near(additive(d, 7, d, VRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 7, d, VRS, [1.0, 1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 7, d, NIRS).unwrap().factor, 1.0)
  near(output_radial(d, 7, d, NIRS).unwrap().factor, 1.0)
  near(additive(d, 7, d, NIRS).unwrap().normalized_gain, -8.881784197001252e-16)
  near(
    directional(d, 7, d, NIRS, [1.0, 1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 7, d, NDRS).unwrap().factor, 0.8571428571428573)
  near(output_radial(d, 7, d, NDRS).unwrap().factor, 1.1666666666666667)
  near(additive(d, 7, d, NDRS).unwrap().normalized_gain, 5.833333333333336)
  near(
    directional(d, 7, d, NDRS, [1.0, 1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    0.0769230769230768,
  )
}

///|
test "independent HiGHS fixture 08" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4"],
    [
      [6.0, 2.0, 6.0],
      [3.0, 15.0, 11.0],
      [15.0, 9.0, 3.0],
      [16.0, 6.0, 11.0],
      [9.0, 14.0, 16.0],
    ],
    [
      [1.0, 8.0, 9.0],
      [10.0, 1.0, 10.0],
      [11.0, 15.0, 7.0],
      [3.0, 10.0, 3.0],
      [7.0, 10.0, 10.0],
    ],
  ).unwrap()
  near(input_radial(d, 3, d, CRS).unwrap().factor, 0.5844748858447489)
  near(output_radial(d, 3, d, CRS).unwrap().factor, 1.7109375)
  near(additive(d, 3, d, CRS).unwrap().normalized_gain, 6.25625)
  near(
    directional(d, 3, d, CRS, [1.0, 1.0, 1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    0.2622478386167147,
  )
  near(input_radial(d, 3, d, VRS).unwrap().factor, 0.6666666666666666)
  near(output_radial(d, 3, d, VRS).unwrap().factor, 1.2)
  near(additive(d, 3, d, VRS).unwrap().normalized_gain, 3.9711038961038962)
  near(
    directional(d, 3, d, VRS, [1.0, 1.0, 1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    0.12500000000000014,
  )
  near(input_radial(d, 3, d, NIRS).unwrap().factor, 0.6666666666666666)
  near(output_radial(d, 3, d, NIRS).unwrap().factor, 1.2000000000000002)
  near(additive(d, 3, d, NIRS).unwrap().normalized_gain, 3.9711038961038954)
  near(
    directional(d, 3, d, NIRS, [1.0, 1.0, 1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    0.12499999999999992,
  )
  near(input_radial(d, 3, d, NDRS).unwrap().factor, 0.5844748858447488)
  near(output_radial(d, 3, d, NDRS).unwrap().factor, 1.7109375000000002)
  near(additive(d, 3, d, NDRS).unwrap().normalized_gain, 6.25625)
  near(
    directional(d, 3, d, NDRS, [1.0, 1.0, 1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    0.2622478386167147,
  )
}

///|
test "independent HiGHS fixture 09" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4", "u5"],
    [[5.0], [15.0], [3.0], [12.0], [13.0], [13.0]],
    [[10.0], [12.0], [10.0], [7.0], [1.0], [10.0]],
  ).unwrap()
  near(input_radial(d, 3, d, CRS).unwrap().factor, 0.17500000000000004)
  near(output_radial(d, 3, d, CRS).unwrap().factor, 5.714285714285714)
  near(additive(d, 3, d, CRS).unwrap().normalized_gain, 4.7142857142857135)
  near(
    directional(d, 3, d, CRS, [1.0], [1.0]).unwrap().distance,
    0.7021276595744682,
  )
  near(input_radial(d, 3, d, VRS).unwrap().factor, 0.25)
  near(output_radial(d, 3, d, VRS).unwrap().factor, 1.6428571428571428)
  near(additive(d, 3, d, VRS).unwrap().normalized_gain, 1.1785714285714288)
  near(directional(d, 3, d, VRS, [1.0], [1.0]).unwrap().distance, 0.5)
  near(input_radial(d, 3, d, NIRS).unwrap().factor, 0.17500000000000004)
  near(output_radial(d, 3, d, NIRS).unwrap().factor, 1.6428571428571428)
  near(additive(d, 3, d, NIRS).unwrap().normalized_gain, 1.1785714285714288)
  near(directional(d, 3, d, NIRS, [1.0], [1.0]).unwrap().distance, 0.5)
  near(input_radial(d, 3, d, NDRS).unwrap().factor, 0.25)
  near(output_radial(d, 3, d, NDRS).unwrap().factor, 5.714285714285714)
  near(additive(d, 3, d, NDRS).unwrap().normalized_gain, 4.7142857142857135)
  near(
    directional(d, 3, d, NDRS, [1.0], [1.0]).unwrap().distance,
    0.7021276595744681,
  )
}

///|
test "independent HiGHS fixture 10" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4", "u5", "u6"],
    [
      [11.0, 13.0],
      [2.0, 16.0],
      [5.0, 13.0],
      [12.0, 2.0],
      [14.0, 15.0],
      [11.0, 11.0],
      [16.0, 8.0],
    ],
    [[16.0], [16.0], [7.0], [14.0], [15.0], [2.0], [15.0]],
  ).unwrap()
  near(input_radial(d, 3, d, CRS).unwrap().factor, 1.0)
  near(output_radial(d, 3, d, CRS).unwrap().factor, 1.0)
  near(additive(d, 3, d, CRS).unwrap().normalized_gain, 0.0)
  near(directional(d, 3, d, CRS, [1.0, 1.0], [1.0]).unwrap().distance, -0.0)
  near(input_radial(d, 3, d, VRS).unwrap().factor, 1.0)
  near(output_radial(d, 3, d, VRS).unwrap().factor, 1.0)
  near(additive(d, 3, d, VRS).unwrap().normalized_gain, 0.0)
  near(directional(d, 3, d, VRS, [1.0, 1.0], [1.0]).unwrap().distance, -0.0)
  near(input_radial(d, 3, d, NIRS).unwrap().factor, 1.0)
  near(output_radial(d, 3, d, NIRS).unwrap().factor, 1.0)
  near(additive(d, 3, d, NIRS).unwrap().normalized_gain, 0.0)
  near(directional(d, 3, d, NIRS, [1.0, 1.0], [1.0]).unwrap().distance, -0.0)
  near(input_radial(d, 3, d, NDRS).unwrap().factor, 1.0)
  near(output_radial(d, 3, d, NDRS).unwrap().factor, 1.0)
  near(additive(d, 3, d, NDRS).unwrap().normalized_gain, 0.0)
  near(directional(d, 3, d, NDRS, [1.0, 1.0], [1.0]).unwrap().distance, -0.0)
}

///|
test "independent HiGHS fixture 11" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4", "u5", "u6", "u7"],
    [
      [11.0, 6.0, 10.0],
      [12.0, 13.0, 9.0],
      [13.0, 2.0, 7.0],
      [6.0, 16.0, 5.0],
      [15.0, 4.0, 6.0],
      [13.0, 11.0, 1.0],
      [1.0, 10.0, 2.0],
      [4.0, 15.0, 15.0],
    ],
    [[13.0], [15.0], [8.0], [13.0], [11.0], [13.0], [11.0], [7.0]],
  ).unwrap()
  near(input_radial(d, 3, d, CRS).unwrap().factor, 0.6610169491525423)
  near(output_radial(d, 3, d, CRS).unwrap().factor, 1.5128205128205119)
  near(additive(d, 3, d, CRS).unwrap().normalized_gain, 1.5916666666666668)
  near(
    directional(d, 3, d, CRS, [1.0, 1.0, 1.0], [1.0]).unwrap().distance,
    0.20408163265306128,
  )
  near(input_radial(d, 3, d, VRS).unwrap().factor, 1.0)
  near(output_radial(d, 3, d, VRS).unwrap().factor, 1.0)
  near(additive(d, 3, d, VRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 3, d, VRS, [1.0, 1.0, 1.0], [1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 3, d, NIRS).unwrap().factor, 0.9999999999999963)
  near(output_radial(d, 3, d, NIRS).unwrap().factor, 1.0)
  near(
    additive(d, 3, d, NIRS).unwrap().normalized_gain,
    -1.3322676295501878e-15,
  )
  near(
    directional(d, 3, d, NIRS, [1.0, 1.0, 1.0], [1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 3, d, NDRS).unwrap().factor, 0.6610169491525422)
  near(output_radial(d, 3, d, NDRS).unwrap().factor, 1.5128205128205119)
  near(additive(d, 3, d, NDRS).unwrap().normalized_gain, 1.5916666666666668)
  near(
    directional(d, 3, d, NDRS, [1.0, 1.0, 1.0], [1.0]).unwrap().distance,
    0.20408163265306117,
  )
}

///|
test "independent HiGHS fixture 12" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4"],
    [[8.0], [4.0], [7.0], [9.0], [14.0]],
    [[12.0, 7.0], [6.0, 5.0], [7.0, 16.0], [5.0, 8.0], [4.0, 9.0]],
  ).unwrap()
  near(input_radial(d, 2, d, CRS).unwrap().factor, 1.0)
  near(output_radial(d, 2, d, CRS).unwrap().factor, 1.0)
  near(additive(d, 2, d, CRS).unwrap().normalized_gain, -2.220446049250313e-16)
  near(directional(d, 2, d, CRS, [1.0], [1.0, 1.0]).unwrap().distance, -0.0)
  near(input_radial(d, 2, d, VRS).unwrap().factor, 1.0)
  near(output_radial(d, 2, d, VRS).unwrap().factor, 1.0)
  near(additive(d, 2, d, VRS).unwrap().normalized_gain, 0.0)
  near(directional(d, 2, d, VRS, [1.0], [1.0, 1.0]).unwrap().distance, -0.0)
  near(input_radial(d, 2, d, NIRS).unwrap().factor, 1.0)
  near(output_radial(d, 2, d, NIRS).unwrap().factor, 1.0)
  near(additive(d, 2, d, NIRS).unwrap().normalized_gain, 0.0)
  near(directional(d, 2, d, NIRS, [1.0], [1.0, 1.0]).unwrap().distance, -0.0)
  near(input_radial(d, 2, d, NDRS).unwrap().factor, 1.0)
  near(output_radial(d, 2, d, NDRS).unwrap().factor, 1.0)
  near(additive(d, 2, d, NDRS).unwrap().normalized_gain, -2.220446049250313e-16)
  near(directional(d, 2, d, NDRS, [1.0], [1.0, 1.0]).unwrap().distance, -0.0)
}

///|
test "independent HiGHS fixture 13" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4", "u5"],
    [[1.0, 2.0], [11.0, 11.0], [8.0, 7.0], [8.0, 9.0], [12.0, 12.0], [6.0, 6.0]],
    [
      [4.0, 9.0],
      [7.0, 3.0],
      [10.0, 13.0],
      [2.0, 15.0],
      [16.0, 6.0],
      [8.0, 12.0],
    ],
  ).unwrap()
  near(input_radial(d, 1, d, CRS).unwrap().factor, 0.3181818181818182)
  near(output_radial(d, 1, d, CRS).unwrap().factor, 3.142857142857143)
  near(additive(d, 1, d, CRS).unwrap().normalized_gain, 18.142857142857142)
  near(
    directional(d, 1, d, CRS, [1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    0.5172413793103448,
  )
  near(input_radial(d, 1, d, VRS).unwrap().factor, 0.4090909090909091)
  near(output_radial(d, 1, d, VRS).unwrap().factor, 2.1142857142857143)
  near(additive(d, 1, d, VRS).unwrap().normalized_gain, 4.398268398268398)
  near(
    directional(d, 1, d, VRS, [1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    0.38613861386138626,
  )
  near(input_radial(d, 1, d, NIRS).unwrap().factor, 0.4090909090909091)
  near(output_radial(d, 1, d, NIRS).unwrap().factor, 2.1142857142857148)
  near(additive(d, 1, d, NIRS).unwrap().normalized_gain, 4.398268398268399)
  near(
    directional(d, 1, d, NIRS, [1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    0.3861386138613861,
  )
  near(input_radial(d, 1, d, NDRS).unwrap().factor, 0.3181818181818182)
  near(output_radial(d, 1, d, NDRS).unwrap().factor, 3.142857142857143)
  near(additive(d, 1, d, NDRS).unwrap().normalized_gain, 18.142857142857142)
  near(
    directional(d, 1, d, NDRS, [1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    0.5172413793103448,
  )
}

///|
test "independent HiGHS fixture 14" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4", "u5", "u6"],
    [
      [1.0, 9.0, 2.0],
      [6.0, 12.0, 12.0],
      [10.0, 11.0, 7.0],
      [14.0, 15.0, 5.0],
      [7.0, 10.0, 5.0],
      [3.0, 2.0, 12.0],
      [3.0, 8.0, 10.0],
    ],
    [
      [15.0, 4.0],
      [3.0, 10.0],
      [7.0, 14.0],
      [16.0, 3.0],
      [4.0, 6.0],
      [12.0, 8.0],
      [13.0, 8.0],
    ],
  ).unwrap()
  near(input_radial(d, 0, d, CRS).unwrap().factor, 1.0000000000000002)
  near(output_radial(d, 0, d, CRS).unwrap().factor, 1.0000000000000002)
  near(additive(d, 0, d, CRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 0, d, CRS, [1.0, 1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 0, d, VRS).unwrap().factor, 1.0)
  near(output_radial(d, 0, d, VRS).unwrap().factor, 1.0)
  near(additive(d, 0, d, VRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 0, d, VRS, [1.0, 1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 0, d, NIRS).unwrap().factor, 1.0000000000000002)
  near(output_radial(d, 0, d, NIRS).unwrap().factor, 1.0)
  near(additive(d, 0, d, NIRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 0, d, NIRS, [1.0, 1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 0, d, NDRS).unwrap().factor, 1.0000000000000002)
  near(output_radial(d, 0, d, NDRS).unwrap().factor, 1.0)
  near(additive(d, 0, d, NDRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 0, d, NDRS, [1.0, 1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    -0.0,
  )
}

///|
test "independent HiGHS fixture 15" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4", "u5", "u6", "u7"],
    [[8.0], [1.0], [11.0], [12.0], [8.0], [5.0], [10.0], [10.0]],
    [
      [10.0, 6.0, 4.0],
      [16.0, 5.0, 2.0],
      [4.0, 7.0, 10.0],
      [9.0, 14.0, 6.0],
      [12.0, 12.0, 10.0],
      [12.0, 2.0, 1.0],
      [6.0, 6.0, 15.0],
      [9.0, 3.0, 13.0],
    ],
  ).unwrap()
  near(input_radial(d, 7, d, CRS).unwrap().factor, 0.65)
  near(output_radial(d, 7, d, CRS).unwrap().factor, 1.538461538461538)
  near(additive(d, 7, d, CRS).unwrap().normalized_gain, 32.98290598290598)
  near(
    directional(d, 7, d, CRS, [1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    0.2121212121212121,
  )
  near(input_radial(d, 7, d, VRS).unwrap().factor, 1.0)
  near(output_radial(d, 7, d, VRS).unwrap().factor, 1.0)
  near(additive(d, 7, d, VRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 7, d, VRS, [1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 7, d, NIRS).unwrap().factor, 1.0)
  near(output_radial(d, 7, d, NIRS).unwrap().factor, 0.9999999999999987)
  near(additive(d, 7, d, NIRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 7, d, NIRS, [1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 7, d, NDRS).unwrap().factor, 0.65)
  near(output_radial(d, 7, d, NDRS).unwrap().factor, 1.5384615384615383)
  near(additive(d, 7, d, NDRS).unwrap().normalized_gain, 32.98290598290598)
  near(
    directional(d, 7, d, NDRS, [1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    0.21212121212121218,
  )
}

///|
test "independent HiGHS fixture 16" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4"],
    [[10.0, 15.0], [8.0, 4.0], [6.0, 16.0], [2.0, 8.0], [11.0, 7.0]],
    [
      [16.0, 7.0, 5.0],
      [12.0, 5.0, 4.0],
      [5.0, 16.0, 16.0],
      [13.0, 4.0, 3.0],
      [14.0, 3.0, 14.0],
    ],
  ).unwrap()
  near(input_radial(d, 1, d, CRS).unwrap().factor, 1.0)
  near(output_radial(d, 1, d, CRS).unwrap().factor, 1.0)
  near(additive(d, 1, d, CRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 1, d, CRS, [1.0, 1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 1, d, VRS).unwrap().factor, 1.0)
  near(output_radial(d, 1, d, VRS).unwrap().factor, 1.0)
  near(additive(d, 1, d, VRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 1, d, VRS, [1.0, 1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 1, d, NIRS).unwrap().factor, 1.0)
  near(output_radial(d, 1, d, NIRS).unwrap().factor, 1.0000000000000007)
  near(additive(d, 1, d, NIRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 1, d, NIRS, [1.0, 1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 1, d, NDRS).unwrap().factor, 1.0)
  near(output_radial(d, 1, d, NDRS).unwrap().factor, 1.0)
  near(additive(d, 1, d, NDRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 1, d, NDRS, [1.0, 1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    -0.0,
  )
}

///|
test "independent HiGHS fixture 17" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4", "u5"],
    [
      [6.0, 8.0, 13.0],
      [9.0, 13.0, 9.0],
      [8.0, 12.0, 4.0],
      [9.0, 10.0, 12.0],
      [12.0, 16.0, 13.0],
      [8.0, 4.0, 11.0],
    ],
    [
      [3.0, 16.0, 16.0],
      [5.0, 5.0, 13.0],
      [15.0, 5.0, 10.0],
      [7.0, 15.0, 13.0],
      [11.0, 9.0, 16.0],
      [10.0, 14.0, 1.0],
    ],
  ).unwrap()
  near(input_radial(d, 5, d, CRS).unwrap().factor, 1.0)
  near(output_radial(d, 5, d, CRS).unwrap().factor, 1.0)
  near(additive(d, 5, d, CRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 5, d, CRS, [1.0, 1.0, 1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 5, d, VRS).unwrap().factor, 1.0)
  near(output_radial(d, 5, d, VRS).unwrap().factor, 1.0)
  near(additive(d, 5, d, VRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 5, d, VRS, [1.0, 1.0, 1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 5, d, NIRS).unwrap().factor, 1.0)
  near(output_radial(d, 5, d, NIRS).unwrap().factor, 1.0)
  near(additive(d, 5, d, NIRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 5, d, NIRS, [1.0, 1.0, 1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 5, d, NDRS).unwrap().factor, 1.0)
  near(output_radial(d, 5, d, NDRS).unwrap().factor, 1.0)
  near(additive(d, 5, d, NDRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 5, d, NDRS, [1.0, 1.0, 1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    -0.0,
  )
}

///|
test "independent HiGHS fixture 18" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4", "u5", "u6"],
    [[10.0], [3.0], [12.0], [16.0], [9.0], [1.0], [3.0]],
    [[9.0], [10.0], [3.0], [12.0], [5.0], [13.0], [11.0]],
  ).unwrap()
  near(input_radial(d, 4, d, CRS).unwrap().factor, 0.042735042735042736)
  near(output_radial(d, 4, d, CRS).unwrap().factor, 23.4)
  near(additive(d, 4, d, CRS).unwrap().normalized_gain, 22.4)
  near(
    directional(d, 4, d, CRS, [1.0], [1.0]).unwrap().distance,
    0.9180327868852459,
  )
  near(input_radial(d, 4, d, VRS).unwrap().factor, 0.1111111111111111)
  near(output_radial(d, 4, d, VRS).unwrap().factor, 2.6)
  near(additive(d, 4, d, VRS).unwrap().normalized_gain, 2.488888888888889)
  near(
    directional(d, 4, d, VRS, [1.0], [1.0]).unwrap().distance,
    0.8888888888888888,
  )
  near(input_radial(d, 4, d, NIRS).unwrap().factor, 0.042735042735042736)
  near(output_radial(d, 4, d, NIRS).unwrap().factor, 2.6)
  near(additive(d, 4, d, NIRS).unwrap().normalized_gain, 2.488888888888889)
  near(
    directional(d, 4, d, NIRS, [1.0], [1.0]).unwrap().distance,
    0.9180327868852459,
  )
  near(input_radial(d, 4, d, NDRS).unwrap().factor, 0.1111111111111111)
  near(output_radial(d, 4, d, NDRS).unwrap().factor, 23.4)
  near(additive(d, 4, d, NDRS).unwrap().normalized_gain, 22.4)
  near(
    directional(d, 4, d, NDRS, [1.0], [1.0]).unwrap().distance,
    0.8888888888888888,
  )
}

///|
test "independent HiGHS fixture 19" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4", "u5", "u6", "u7"],
    [
      [12.0, 12.0],
      [13.0, 7.0],
      [7.0, 16.0],
      [3.0, 13.0],
      [3.0, 10.0],
      [3.0, 15.0],
      [9.0, 9.0],
      [10.0, 13.0],
    ],
    [[15.0], [6.0], [16.0], [9.0], [8.0], [14.0], [11.0], [13.0]],
  ).unwrap()
  near(input_radial(d, 3, d, CRS).unwrap().factor, 0.7322033898305086)
  near(output_radial(d, 3, d, CRS).unwrap().factor, 1.365740740740741)
  near(additive(d, 3, d, CRS).unwrap().normalized_gain, 0.6153846153846154)
  near(
    directional(d, 3, d, CRS, [1.0, 1.0], [1.0]).unwrap().distance,
    0.15459882583170254,
  )
  near(input_radial(d, 3, d, VRS).unwrap().factor, 1.0)
  near(output_radial(d, 3, d, VRS).unwrap().factor, 1.288888888888889)
  near(additive(d, 3, d, VRS).unwrap().normalized_gain, 0.288888888888889)
  near(directional(d, 3, d, VRS, [1.0, 1.0], [1.0]).unwrap().distance, -0.0)
  near(input_radial(d, 3, d, NIRS).unwrap().factor, 0.7322033898305085)
  near(output_radial(d, 3, d, NIRS).unwrap().factor, 1.365740740740741)
  near(additive(d, 3, d, NIRS).unwrap().normalized_gain, 0.6153846153846154)
  near(
    directional(d, 3, d, NIRS, [1.0, 1.0], [1.0]).unwrap().distance,
    0.15459882583170254,
  )
  near(input_radial(d, 3, d, NDRS).unwrap().factor, 1.0000000000000075)
  near(output_radial(d, 3, d, NDRS).unwrap().factor, 1.288888888888889)
  near(additive(d, 3, d, NDRS).unwrap().normalized_gain, 0.288888888888889)
  near(directional(d, 3, d, NDRS, [1.0, 1.0], [1.0]).unwrap().distance, -0.0)
}

///|
test "independent HiGHS fixture 20" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4"],
    [
      [1.0, 2.0, 1.0],
      [10.0, 8.0, 9.0],
      [12.0, 16.0, 14.0],
      [7.0, 1.0, 5.0],
      [16.0, 4.0, 15.0],
    ],
    [[8.0], [10.0], [4.0], [11.0], [11.0]],
  ).unwrap()
  near(input_radial(d, 0, d, CRS).unwrap().factor, 1.0000000000000002)
  near(output_radial(d, 0, d, CRS).unwrap().factor, 1.0)
  near(additive(d, 0, d, CRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 0, d, CRS, [1.0, 1.0, 1.0], [1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 0, d, VRS).unwrap().factor, 1.0)
  near(output_radial(d, 0, d, VRS).unwrap().factor, 1.0)
  near(additive(d, 0, d, VRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 0, d, VRS, [1.0, 1.0, 1.0], [1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 0, d, NIRS).unwrap().factor, 0.9999999999999998)
  near(output_radial(d, 0, d, NIRS).unwrap().factor, 1.0)
  near(additive(d, 0, d, NIRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 0, d, NIRS, [1.0, 1.0, 1.0], [1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 0, d, NDRS).unwrap().factor, 0.9999999999999998)
  near(output_radial(d, 0, d, NDRS).unwrap().factor, 1.0)
  near(additive(d, 0, d, NDRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 0, d, NDRS, [1.0, 1.0, 1.0], [1.0]).unwrap().distance,
    -0.0,
  )
}

///|
test "independent HiGHS fixture 21" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4", "u5"],
    [[16.0], [4.0], [15.0], [3.0], [9.0], [11.0]],
    [
      [13.0, 13.0],
      [8.0, 9.0],
      [9.0, 2.0],
      [14.0, 16.0],
      [15.0, 10.0],
      [10.0, 6.0],
    ],
  ).unwrap()
  near(input_radial(d, 3, d, CRS).unwrap().factor, 1.0)
  near(output_radial(d, 3, d, CRS).unwrap().factor, 1.0)
  near(additive(d, 3, d, CRS).unwrap().normalized_gain, 0.0)
  near(directional(d, 3, d, CRS, [1.0], [1.0, 1.0]).unwrap().distance, -0.0)
  near(input_radial(d, 3, d, VRS).unwrap().factor, 1.0)
  near(output_radial(d, 3, d, VRS).unwrap().factor, 1.0)
  near(additive(d, 3, d, VRS).unwrap().normalized_gain, 0.0)
  near(directional(d, 3, d, VRS, [1.0], [1.0, 1.0]).unwrap().distance, -0.0)
  near(input_radial(d, 3, d, NIRS).unwrap().factor, 1.0)
  near(output_radial(d, 3, d, NIRS).unwrap().factor, 1.0)
  near(additive(d, 3, d, NIRS).unwrap().normalized_gain, 0.0)
  near(directional(d, 3, d, NIRS, [1.0], [1.0, 1.0]).unwrap().distance, -0.0)
  near(input_radial(d, 3, d, NDRS).unwrap().factor, 1.0)
  near(output_radial(d, 3, d, NDRS).unwrap().factor, 1.0)
  near(additive(d, 3, d, NDRS).unwrap().normalized_gain, 0.0)
  near(directional(d, 3, d, NDRS, [1.0], [1.0, 1.0]).unwrap().distance, -0.0)
}

///|
test "independent HiGHS fixture 22" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4", "u5", "u6"],
    [
      [16.0, 16.0],
      [11.0, 12.0],
      [9.0, 1.0],
      [5.0, 6.0],
      [8.0, 9.0],
      [14.0, 1.0],
      [10.0, 6.0],
    ],
    [
      [13.0, 15.0],
      [4.0, 4.0],
      [11.0, 5.0],
      [2.0, 6.0],
      [10.0, 14.0],
      [10.0, 6.0],
      [9.0, 5.0],
    ],
  ).unwrap()
  near(input_radial(d, 1, d, CRS).unwrap().factor, 0.2911266201395812)
  near(output_radial(d, 1, d, CRS).unwrap().factor, 3.4349315068493147)
  near(additive(d, 1, d, CRS).unwrap().normalized_gain, 6.1369863013698644)
  near(
    directional(d, 1, d, CRS, [1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    0.5490347490347491,
  )
  near(input_radial(d, 1, d, VRS).unwrap().factor, 0.5257214554579673)
  near(output_radial(d, 1, d, VRS).unwrap().factor, 2.8333333333333335)
  near(additive(d, 1, d, VRS).unwrap().normalized_gain, 4.5227272727272725)
  near(
    directional(d, 1, d, VRS, [1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    0.41767955801104967,
  )
  near(input_radial(d, 1, d, NIRS).unwrap().factor, 0.2911266201395813)
  near(output_radial(d, 1, d, NIRS).unwrap().factor, 2.833333333333333)
  near(additive(d, 1, d, NIRS).unwrap().normalized_gain, 4.5227272727272725)
  near(
    directional(d, 1, d, NIRS, [1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    0.5490347490347495,
  )
  near(input_radial(d, 1, d, NDRS).unwrap().factor, 0.5257214554579673)
  near(output_radial(d, 1, d, NDRS).unwrap().factor, 3.434931506849316)
  near(additive(d, 1, d, NDRS).unwrap().normalized_gain, 6.1369863013698644)
  near(
    directional(d, 1, d, NDRS, [1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    0.4176795580110501,
  )
}

///|
test "independent HiGHS fixture 23" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4", "u5", "u6", "u7"],
    [
      [14.0, 8.0, 1.0],
      [2.0, 4.0, 2.0],
      [5.0, 15.0, 15.0],
      [14.0, 9.0, 13.0],
      [13.0, 8.0, 9.0],
      [11.0, 14.0, 2.0],
      [5.0, 10.0, 10.0],
      [4.0, 4.0, 9.0],
    ],
    [
      [7.0, 2.0],
      [10.0, 12.0],
      [8.0, 15.0],
      [10.0, 13.0],
      [1.0, 7.0],
      [2.0, 7.0],
      [10.0, 3.0],
      [1.0, 4.0],
    ],
  ).unwrap()
  near(input_radial(d, 7, d, CRS).unwrap().factor, 0.3333333333333333)
  near(output_radial(d, 7, d, CRS).unwrap().factor, 3.0)
  near(additive(d, 7, d, CRS).unwrap().normalized_gain, 12.277777777777779)
  near(
    directional(d, 7, d, CRS, [1.0, 1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    0.5,
  )
  near(input_radial(d, 7, d, VRS).unwrap().factor, 1.0)
  near(output_radial(d, 7, d, VRS).unwrap().factor, 3.0)
  near(additive(d, 7, d, VRS).unwrap().normalized_gain, 12.277777777777779)
  near(
    directional(d, 7, d, VRS, [1.0, 1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 7, d, NIRS).unwrap().factor, 0.3333333333333333)
  near(output_radial(d, 7, d, NIRS).unwrap().factor, 3.0)
  near(additive(d, 7, d, NIRS).unwrap().normalized_gain, 12.277777777777779)
  near(
    directional(d, 7, d, NIRS, [1.0, 1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    0.5,
  )
  near(input_radial(d, 7, d, NDRS).unwrap().factor, 1.0)
  near(output_radial(d, 7, d, NDRS).unwrap().factor, 3.0)
  near(additive(d, 7, d, NDRS).unwrap().normalized_gain, 12.277777777777779)
  near(
    directional(d, 7, d, NDRS, [1.0, 1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    -0.0,
  )
}

///|
test "independent HiGHS fixture 24" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4"],
    [[9.0], [4.0], [13.0], [9.0], [9.0]],
    [
      [8.0, 7.0, 8.0],
      [14.0, 12.0, 8.0],
      [2.0, 6.0, 5.0],
      [12.0, 12.0, 1.0],
      [1.0, 12.0, 6.0],
    ],
  ).unwrap()
  near(input_radial(d, 4, d, CRS).unwrap().factor, 0.4444444444444444)
  near(output_radial(d, 4, d, CRS).unwrap().factor, 2.2499999999999996)
  near(additive(d, 4, d, CRS).unwrap().normalized_gain, 33.75)
  near(
    directional(d, 4, d, CRS, [1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    0.3846153846153845,
  )
  near(input_radial(d, 4, d, VRS).unwrap().factor, 0.4444444444444444)
  near(output_radial(d, 4, d, VRS).unwrap().factor, 1.0)
  near(additive(d, 4, d, VRS).unwrap().normalized_gain, 13.888888888888886)
  near(
    directional(d, 4, d, VRS, [1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 4, d, NIRS).unwrap().factor, 0.4444444444444444)
  near(output_radial(d, 4, d, NIRS).unwrap().factor, 1.0)
  near(additive(d, 4, d, NIRS).unwrap().normalized_gain, 13.888888888888886)
  near(
    directional(d, 4, d, NIRS, [1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 4, d, NDRS).unwrap().factor, 0.4444444444444444)
  near(output_radial(d, 4, d, NDRS).unwrap().factor, 2.25)
  near(additive(d, 4, d, NDRS).unwrap().normalized_gain, 33.75)
  near(
    directional(d, 4, d, NDRS, [1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    0.3846153846153845,
  )
}

///|
test "independent HiGHS fixture 25" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4", "u5"],
    [
      [14.0, 13.0],
      [8.0, 3.0],
      [9.0, 14.0],
      [3.0, 6.0],
      [15.0, 6.0],
      [12.0, 6.0],
    ],
    [
      [13.0, 6.0, 16.0],
      [15.0, 11.0, 4.0],
      [4.0, 6.0, 11.0],
      [8.0, 6.0, 4.0],
      [8.0, 16.0, 7.0],
      [2.0, 13.0, 13.0],
    ],
  ).unwrap()
  near(input_radial(d, 1, d, CRS).unwrap().factor, 1.0000000000000002)
  near(output_radial(d, 1, d, CRS).unwrap().factor, 1.0)
  near(additive(d, 1, d, CRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 1, d, CRS, [1.0, 1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 1, d, VRS).unwrap().factor, 1.0)
  near(output_radial(d, 1, d, VRS).unwrap().factor, 1.0)
  near(additive(d, 1, d, VRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 1, d, VRS, [1.0, 1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 1, d, NIRS).unwrap().factor, 1.0)
  near(output_radial(d, 1, d, NIRS).unwrap().factor, 1.0)
  near(additive(d, 1, d, NIRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 1, d, NIRS, [1.0, 1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 1, d, NDRS).unwrap().factor, 1.0)
  near(output_radial(d, 1, d, NDRS).unwrap().factor, 1.0)
  near(additive(d, 1, d, NDRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 1, d, NDRS, [1.0, 1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    -0.0,
  )
}

///|
test "independent HiGHS fixture 26" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4", "u5", "u6"],
    [
      [8.0, 13.0, 12.0],
      [7.0, 3.0, 15.0],
      [13.0, 2.0, 11.0],
      [6.0, 5.0, 2.0],
      [6.0, 1.0, 16.0],
      [7.0, 12.0, 15.0],
      [8.0, 4.0, 14.0],
    ],
    [
      [2.0, 2.0, 15.0],
      [14.0, 2.0, 4.0],
      [8.0, 5.0, 15.0],
      [14.0, 11.0, 16.0],
      [2.0, 9.0, 1.0],
      [5.0, 11.0, 5.0],
      [14.0, 15.0, 14.0],
    ],
  ).unwrap()
  near(input_radial(d, 5, d, CRS).unwrap().factor, 0.8380952380952382)
  near(output_radial(d, 5, d, CRS).unwrap().factor, 1.1931818181818181)
  near(additive(d, 5, d, CRS).unwrap().normalized_gain, 6.525000000000002)
  near(
    directional(d, 5, d, CRS, [1.0, 1.0, 1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    0.08808290155440399,
  )
  near(input_radial(d, 5, d, VRS).unwrap().factor, 0.8571428571428571)
  near(output_radial(d, 5, d, VRS).unwrap().factor, 1.1818181818181819)
  near(additive(d, 5, d, VRS).unwrap().normalized_gain, 5.592857142857143)
  near(
    directional(d, 5, d, VRS, [1.0, 1.0, 1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    0.08000000000000007,
  )
  near(input_radial(d, 5, d, NIRS).unwrap().factor, 0.8380952380952382)
  near(output_radial(d, 5, d, NIRS).unwrap().factor, 1.1931818181818181)
  near(additive(d, 5, d, NIRS).unwrap().normalized_gain, 5.592857142857143)
  near(
    directional(d, 5, d, NIRS, [1.0, 1.0, 1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    0.08808290155440428,
  )
  near(input_radial(d, 5, d, NDRS).unwrap().factor, 0.8571428571428574)
  near(output_radial(d, 5, d, NDRS).unwrap().factor, 1.1818181818181819)
  near(additive(d, 5, d, NDRS).unwrap().normalized_gain, 6.525000000000002)
  near(
    directional(d, 5, d, NDRS, [1.0, 1.0, 1.0], [1.0, 1.0, 1.0]).unwrap().distance,
    0.08000000000000002,
  )
}

///|
test "independent HiGHS fixture 27" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4", "u5", "u6", "u7"],
    [[10.0], [3.0], [3.0], [10.0], [7.0], [4.0], [9.0], [13.0]],
    [[7.0], [5.0], [6.0], [5.0], [13.0], [5.0], [11.0], [13.0]],
  ).unwrap()
  near(input_radial(d, 3, d, CRS).unwrap().factor, 0.25)
  near(output_radial(d, 3, d, CRS).unwrap().factor, 4.0)
  near(additive(d, 3, d, CRS).unwrap().normalized_gain, 3.0)
  near(directional(d, 3, d, CRS, [1.0], [1.0]).unwrap().distance, 0.6)
  near(input_radial(d, 3, d, VRS).unwrap().factor, 0.3)
  near(output_radial(d, 3, d, VRS).unwrap().factor, 2.6)
  near(additive(d, 3, d, VRS).unwrap().normalized_gain, 1.9000000000000004)
  near(
    directional(d, 3, d, VRS, [1.0], [1.0]).unwrap().distance,
    0.5888888888888889,
  )
  near(input_radial(d, 3, d, NIRS).unwrap().factor, 0.25)
  near(output_radial(d, 3, d, NIRS).unwrap().factor, 2.6)
  near(additive(d, 3, d, NIRS).unwrap().normalized_gain, 1.9000000000000004)
  near(
    directional(d, 3, d, NIRS, [1.0], [1.0]).unwrap().distance,
    0.5888888888888889,
  )
  near(input_radial(d, 3, d, NDRS).unwrap().factor, 0.3)
  near(output_radial(d, 3, d, NDRS).unwrap().factor, 4.0)
  near(additive(d, 3, d, NDRS).unwrap().normalized_gain, 2.9999999999999996)
  near(directional(d, 3, d, NDRS, [1.0], [1.0]).unwrap().distance, 0.6)
}

///|
test "independent HiGHS fixture 28" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4"],
    [[11.0, 14.0], [5.0, 3.0], [15.0, 10.0], [1.0, 10.0], [12.0, 12.0]],
    [[10.0], [15.0], [7.0], [11.0], [5.0]],
  ).unwrap()
  near(input_radial(d, 3, d, CRS).unwrap().factor, 1.0)
  near(output_radial(d, 3, d, CRS).unwrap().factor, 1.0)
  near(additive(d, 3, d, CRS).unwrap().normalized_gain, 0.0)
  near(directional(d, 3, d, CRS, [1.0, 1.0], [1.0]).unwrap().distance, -0.0)
  near(input_radial(d, 3, d, VRS).unwrap().factor, 1.0)
  near(output_radial(d, 3, d, VRS).unwrap().factor, 1.0)
  near(additive(d, 3, d, VRS).unwrap().normalized_gain, 0.0)
  near(directional(d, 3, d, VRS, [1.0, 1.0], [1.0]).unwrap().distance, -0.0)
  near(input_radial(d, 3, d, NIRS).unwrap().factor, 1.0)
  near(output_radial(d, 3, d, NIRS).unwrap().factor, 1.0)
  near(additive(d, 3, d, NIRS).unwrap().normalized_gain, 0.0)
  near(directional(d, 3, d, NIRS, [1.0, 1.0], [1.0]).unwrap().distance, -0.0)
  near(input_radial(d, 3, d, NDRS).unwrap().factor, 1.0)
  near(output_radial(d, 3, d, NDRS).unwrap().factor, 1.0)
  near(additive(d, 3, d, NDRS).unwrap().normalized_gain, 0.0)
  near(directional(d, 3, d, NDRS, [1.0, 1.0], [1.0]).unwrap().distance, -0.0)
}

///|
test "independent HiGHS fixture 29" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4", "u5"],
    [
      [7.0, 7.0, 4.0],
      [16.0, 7.0, 1.0],
      [2.0, 1.0, 7.0],
      [14.0, 8.0, 6.0],
      [7.0, 13.0, 15.0],
      [4.0, 1.0, 1.0],
    ],
    [[5.0], [14.0], [3.0], [16.0], [11.0], [4.0]],
  ).unwrap()
  near(input_radial(d, 5, d, CRS).unwrap().factor, 1.0)
  near(output_radial(d, 5, d, CRS).unwrap().factor, 1.0)
  near(additive(d, 5, d, CRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 5, d, CRS, [1.0, 1.0, 1.0], [1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 5, d, VRS).unwrap().factor, 1.0)
  near(output_radial(d, 5, d, VRS).unwrap().factor, 1.0)
  near(additive(d, 5, d, VRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 5, d, VRS, [1.0, 1.0, 1.0], [1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 5, d, NIRS).unwrap().factor, 0.9999999999999997)
  near(output_radial(d, 5, d, NIRS).unwrap().factor, 1.0)
  near(additive(d, 5, d, NIRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 5, d, NIRS, [1.0, 1.0, 1.0], [1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 5, d, NDRS).unwrap().factor, 1.0)
  near(output_radial(d, 5, d, NDRS).unwrap().factor, 1.0)
  near(additive(d, 5, d, NDRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 5, d, NDRS, [1.0, 1.0, 1.0], [1.0]).unwrap().distance,
    -0.0,
  )
}

///|
test "independent HiGHS fixture 30" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4", "u5", "u6"],
    [[1.0], [10.0], [6.0], [13.0], [10.0], [4.0], [15.0]],
    [
      [11.0, 9.0],
      [14.0, 8.0],
      [8.0, 14.0],
      [5.0, 11.0],
      [10.0, 15.0],
      [8.0, 3.0],
      [4.0, 14.0],
    ],
  ).unwrap()
  near(input_radial(d, 2, d, CRS).unwrap().factor, 0.25925925925925924)
  near(output_radial(d, 2, d, CRS).unwrap().factor, 3.8571428571428528)
  near(additive(d, 2, d, CRS).unwrap().normalized_gain, 10.107142857142856)
  near(
    directional(d, 2, d, CRS, [1.0], [1.0, 1.0]).unwrap().distance,
    0.588235294117647,
  )
  near(input_radial(d, 2, d, VRS).unwrap().factor, 1.0)
  near(output_radial(d, 2, d, VRS).unwrap().factor, 1.0)
  near(additive(d, 2, d, VRS).unwrap().normalized_gain, 0.0)
  near(directional(d, 2, d, VRS, [1.0], [1.0, 1.0]).unwrap().distance, -0.0)
  near(input_radial(d, 2, d, NIRS).unwrap().factor, 1.0)
  near(output_radial(d, 2, d, NIRS).unwrap().factor, 0.9999999999999999)
  near(additive(d, 2, d, NIRS).unwrap().normalized_gain, 0.0)
  near(directional(d, 2, d, NIRS, [1.0], [1.0, 1.0]).unwrap().distance, -0.0)
  near(input_radial(d, 2, d, NDRS).unwrap().factor, 0.25925925925925924)
  near(output_radial(d, 2, d, NDRS).unwrap().factor, 3.857142857142859)
  near(additive(d, 2, d, NDRS).unwrap().normalized_gain, 10.107142857142856)
  near(
    directional(d, 2, d, NDRS, [1.0], [1.0, 1.0]).unwrap().distance,
    0.5882352941176471,
  )
}

///|
test "independent HiGHS fixture 31" {
  let d = Dataset::new(
    ["u0", "u1", "u2", "u3", "u4", "u5", "u6", "u7"],
    [
      [3.0, 14.0],
      [5.0, 12.0],
      [15.0, 6.0],
      [4.0, 12.0],
      [9.0, 3.0],
      [3.0, 10.0],
      [12.0, 16.0],
      [1.0, 10.0],
    ],
    [
      [2.0, 15.0],
      [13.0, 11.0],
      [5.0, 14.0],
      [9.0, 1.0],
      [3.0, 13.0],
      [11.0, 16.0],
      [1.0, 4.0],
      [4.0, 2.0],
    ],
  ).unwrap()
  near(input_radial(d, 7, d, CRS).unwrap().factor, 0.9999999999999466)
  near(output_radial(d, 7, d, CRS).unwrap().factor, 1.0)
  near(additive(d, 7, d, CRS).unwrap().normalized_gain, -4.6629367034256575e-15)
  near(
    directional(d, 7, d, CRS, [1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 7, d, VRS).unwrap().factor, 1.0)
  near(output_radial(d, 7, d, VRS).unwrap().factor, 1.0)
  near(additive(d, 7, d, VRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 7, d, VRS, [1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 7, d, NIRS).unwrap().factor, 1.0000000000000204)
  near(output_radial(d, 7, d, NIRS).unwrap().factor, 1.0000000000000007)
  near(
    additive(d, 7, d, NIRS).unwrap().normalized_gain,
    -4.6629367034256575e-15,
  )
  near(
    directional(d, 7, d, NIRS, [1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    -0.0,
  )
  near(input_radial(d, 7, d, NDRS).unwrap().factor, 0.9999999999999999)
  near(output_radial(d, 7, d, NDRS).unwrap().factor, 1.0000000000000007)
  near(additive(d, 7, d, NDRS).unwrap().normalized_gain, 0.0)
  near(
    directional(d, 7, d, NDRS, [1.0, 1.0], [1.0, 1.0]).unwrap().distance,
    -0.0,
  )
}
