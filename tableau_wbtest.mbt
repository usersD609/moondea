///|
fn near(a : Double, b : Double) -> Unit raise {
  assert_true((a - b).abs() < 1.0e-6 * (1.0 + b.abs()))
}

///|
test "two phase optimization and original feasibility" {
  let s = solve_linear([[6.0, 4.0], [1.0, 2.0]], [24.0, 6.0], [5.0, 4.0], 1000).unwrap()
  near(s.objective, 21.0)
  near(s.values[0], 3.0)
  near(s.values[1], 1.5)
  let equality = solve_linear([[1.0], [-1.0]], [2.0, -2.0], [1.0], 1000).unwrap()
  near(equality.values[0], 2.0)
  assert_true(s.iterations > 0)
}

///|
test "infeasible unbounded and budget are separate outcomes" {
  assert_true(
    solve_linear([[1.0], [-1.0]], [1.0, -2.0], [1.0], 1000) is Err(Infeasible),
  )
  assert_true(solve_linear([[-1.0]], [-1.0], [1.0], 1000) is Err(Unbounded))
  assert_true(solve_linear([[1.0]], [1.0], [1.0], 0) is Err(IterationLimit))
  assert_true(
    solve_linear([[0.0], [0.0], [1.0]], [0.0, 0.0, 3.0], [1.0], 1000) is Ok(_),
  )
}
