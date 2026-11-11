///|
test "preflight finds duplicate observations and measurement conversion preserves factors" {
  let d = Dataset::new(
    ["A", "B", "copy"],
    [[1.0, 3.0], [2.0, 4.0], [1.0, 3.0]],
    [[1.0], [1.0], [1.0]],
  ).unwrap()
  let r = diagnose(d)
  assert_eq(r.duplicate_pairs, [("A", "copy")])
  assert_eq(r.within_solver_range, true)
  near(r.input_spread[0], 2.0)
  near(r.input_spread[1], 4.0 / 3.0)
  let converted = d.rescale([1000.0, 0.001], [100.0]).unwrap()
  for returns in [CRS, VRS, NIRS, NDRS] {
    near(
      input_radial(d, 1, d, returns).unwrap().factor,
      input_radial(converted, 1, converted, returns).unwrap().factor,
    )
  }
  assert_true(d.rescale([0.0, 1.0], [1.0]) is Err(_))
  assert_true(d.rescale([1.0e100, 1.0], [1.0]) is Err(_))
  let wide = Dataset::new(["low", "high"], [[1.0], [1.0e7]], [[1.0], [1.0]]).unwrap()
  assert_true(!diagnose(wide).within_solver_range)
  assert_true(input_crs(wide, 0, wide) is Err(Invalid(_)))
}
