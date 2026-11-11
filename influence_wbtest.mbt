///|
test "influence interval includes baseline and preserves infeasible exclusions" {
  let d = Dataset::new(["best", "other"], [[1.0], [2.0]], [[1.0], [1.0]]).unwrap()
  let s = sensitivity(d, 1, d, CRS).unwrap()
  near(s.minimum, 0.5)
  near(s.maximum, 1.0)
  assert_eq(s.successful, 2)
  assert_eq(s.failed, 0)
  near(s.exclusions[0].result.unwrap().factor, 1.0)
  let y = Dataset::new(["low", "high"], [[1.0], [2.0]], [[1.0], [3.0]]).unwrap()
  let t = sensitivity(y, 1, y, VRS).unwrap()
  assert_eq(t.failed, 1)
  assert_true(t.exclusions[1].result is Err(Infeasible))
}
