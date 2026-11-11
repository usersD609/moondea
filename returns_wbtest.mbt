///|
test "convexity distinguishes CRS VRS and restricted scale" {
  let d = Dataset::new(["small", "large"], [[1.0], [3.0]], [[1.0], [2.0]]).unwrap()
  near(input_radial(d, 1, d, CRS).unwrap().factor, 2.0 / 3.0)
  near(input_radial(d, 1, d, VRS).unwrap().factor, 1.0)
  near(input_radial(d, 1, d, NIRS).unwrap().factor, 1.0)
  near(input_radial(d, 1, d, NDRS).unwrap().factor, 2.0 / 3.0)
  let v = input_radial(d, 1, d, VRS).unwrap()
  near(v.weights.fold(init=0.0, fn(a, b) { a + b }), 1.0)
  let r = d.select([0]).unwrap()
  assert_true(input_radial(d, 1, r, VRS) is Err(Infeasible))
}
