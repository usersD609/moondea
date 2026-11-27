///|
test "second stage distinguishes weak from strong radial efficiency" {
  let d = Dataset::new(["weak", "peer"], [[1.0, 2.0], [1.0, 1.0]], [
    [1.0],
    [1.0],
  ]).unwrap()
  let r = radial_refined(d, 0, d, VRS).unwrap()
  near(r.factor, 1.0)
  near(r.input_slacks[1], 1.0)
  assert_true(!strongly_efficient(d, 0, r).unwrap())
  assert_true(
    strongly_efficient(d, 1, radial_refined(d, 1, d, VRS).unwrap()).unwrap(),
  )
  assert_true(strongly_efficient(d, 0, r, tolerance=0.0) is Err(_))
  let o = radial_refined(d, 0, d, VRS, output=true).unwrap()
  near(o.factor, 1.0)
  near(o.input_slacks[1], 1.0)
}

///|
test "nonfinite mutable result slacks cannot certify strong efficiency" {
  let d = Dataset::new(["A", "B"], [[1.0], [2.0]], [[1.0], [1.0]]).unwrap()
  for bad in [0.0 / 0.0, 1.0 / 0.0, -1.0 / 0.0] {
    for unit in [0, 1] {
      let r = radial_refined(d, unit, d, CRS).unwrap()
      r.input_slacks[0] = bad
      assert_true(strongly_efficient(d, unit, r) is Err(Invalid(_)))
      let r = radial_refined(d, unit, d, CRS).unwrap()
      r.output_slacks[0] = bad
      assert_true(strongly_efficient(d, unit, r) is Err(Invalid(_)))
    }
  }
  let r = radial_refined(d, 0, d, CRS).unwrap()
  assert_true(
    strongly_efficient(d, 0, { ..r, factor: 0.0 / 0.0, }) is Err(Invalid(_)),
  )
  assert_true(strongly_efficient(d, 0, r).unwrap())
}
