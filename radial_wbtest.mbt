///|
test "CCR one-input efficiency and peer reconstruction" {
  let d = Dataset::new(["A", "B", "C"], [[2.0], [4.0], [8.0]], [
    [1.0],
    [1.0],
    [2.0],
  ]).unwrap()
  near(input_crs(d, 0, d).unwrap().factor, 1.0)
  let r = input_crs(d, 1, d).unwrap()
  near(r.factor, 0.5)
  near(r.projected_inputs[0], 2.0)
  near(r.projected_outputs[0], 1.0)
  near(r.residual, 0.0)
  assert_true(input_crs(d, 4, d) is Err(Invalid(_)))
  assert_true(input_crs(d, 0, d, budget=0) is Err(IterationLimit))
}

///|
test "CCR invariant under consistent column-unit rescaling" {
  let d = Dataset::new(["A", "B"], [[1.0, 3.0], [4.0, 6.0]], [[2.0], [3.0]]).unwrap()
  let e = Dataset::new(["A", "B"], [[100.0, 0.03], [400.0, 0.06]], [
    [2000.0],
    [3000.0],
  ]).unwrap()
  near(input_crs(d, 1, d).unwrap().factor, input_crs(e, 1, e).unwrap().factor)
}
