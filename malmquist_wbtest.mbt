///|
test "uniform technology shift gives twofold progress and reversible index" {
  let a = Dataset::new(["A", "B"], [[2.0], [4.0]], [[1.0], [1.0]]).unwrap()
  let b = Dataset::new(["B", "A"], [[2.0], [1.0]], [[1.0], [1.0]]).unwrap()
  let r = malmquist(a, b, 1).unwrap()
  near(r.efficiency_change, 1.0)
  near(r.technology_change, 2.0)
  near(r.productivity, 2.0)
  near(malmquist(b, a, 0).unwrap().productivity, 0.5)
  near(malmquist(a, a, 0).unwrap().productivity, 1.0)
  let c = Dataset::new(["C", "A"], [[2.0], [1.0]], [[1.0], [1.0]]).unwrap()
  assert_true(malmquist(a, c, 0) is Err(_))
}
