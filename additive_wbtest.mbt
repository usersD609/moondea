///|
test "normalized additive gain identifies joint improvements" {
  let d = Dataset::new(["poor", "good"], [[2.0], [1.0]], [[1.0], [2.0]]).unwrap()
  let r = additive(d, 0, d, VRS).unwrap()
  near(r.normalized_gain, 1.5)
  near(r.target.projected_inputs[0], 1.0)
  near(r.target.projected_outputs[0], 2.0)
  near(additive(d, 1, d, VRS).unwrap().normalized_gain, 0.0)
  assert_true(additive(d, 1, d, VRS, budget=0) is Err(IterationLimit))
}
