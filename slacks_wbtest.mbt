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
