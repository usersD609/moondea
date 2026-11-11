///|
test "output expansion reconstructs feasible targets under all scales" {
  let d = Dataset::new(["A", "B", "C"], [[1.0], [2.0], [3.0]], [
    [1.0],
    [1.0],
    [2.0],
  ]).unwrap()
  near(output_radial(d, 1, d, CRS).unwrap().factor, 2.0)
  near(output_radial(d, 1, d, VRS).unwrap().factor, 1.5)
  for returns in [CRS, VRS, NIRS, NDRS] {
    let r = output_radial(d, 1, d, returns).unwrap()
    assert_true(r.projected_inputs[0] <= 2.0 + 1.0e-6)
    assert_true(r.projected_outputs[0] >= r.factor - 1.0e-6)
    assert_true(r.residual < 1.0e-6)
  }
  assert_true(output_radial(d, 1, d, CRS, budget=0) is Err(IterationLimit))
}
