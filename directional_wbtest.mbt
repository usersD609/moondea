///|
test "direction fractions link input output and simultaneous distances" {
  let d = Dataset::new(["poor", "good"], [[2.0], [1.0]], [[1.0], [2.0]]).unwrap()
  near(directional(d, 0, d, VRS, [1.0], [0.0]).unwrap().distance, 0.5)
  near(directional(d, 0, d, VRS, [0.0], [1.0]).unwrap().distance, 1.0)
  near(directional(d, 0, d, VRS, [1.0], [1.0]).unwrap().distance, 0.5)
  assert_true(directional(d, 0, d, VRS, [0.0], [0.0]) is Err(_))
  assert_true(directional(d, 0, d, VRS, [2.0], [0.0]) is Err(_))
  assert_true(directional(d, 0, d, VRS, [], [1.0]) is Err(_))
}
