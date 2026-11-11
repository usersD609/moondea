///|
test "batch preserves row failures and super-efficiency excludes self" {
  let d = Dataset::new(["best", "other"], [[1.0], [2.0]], [[1.0], [1.0]]).unwrap()
  near(super_efficiency(d, 0, CRS).unwrap().factor, 2.0)
  near(super_efficiency(d, 1, CRS).unwrap().factor, 0.5)
  let rows = evaluate(d, d, CRS)
  near(rows[0].unwrap().factor, 1.0)
  near(rows[1].unwrap().factor, 0.5)
  let small = d.select([0]).unwrap()
  assert_true(super_efficiency(small, 0, CRS) is Err(_))
  let y = Dataset::new(["low", "high"], [[1.0], [2.0]], [[1.0], [3.0]]).unwrap()
  assert_true(super_efficiency(y, 1, VRS) is Err(Infeasible))
  assert_true(evaluate(d, d, CRS, budget=0)[0] is Err(IterationLimit))
}
