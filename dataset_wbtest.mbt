///|
test "dataset snapshots and row selection" {
  let x = [[2.0], [4.0]]
  let d = Dataset::new(["A", "B"], x, [[1.0], [1.0]]).unwrap()
  x[0][0] = 99.0
  assert_eq(d.inputs()[0][0], 2.0)
  let out = d.inputs()
  out[0][0] = 88.0
  assert_eq(d.inputs()[0][0], 2.0)
  assert_eq(d.select([1]).unwrap().names(), ["B"])
  assert_true(d.select([0, 0]) is Err(_))
}

///|
test "dataset refuses malformed values and dimensions" {
  assert_true(Dataset::new([], [], []) is Err(_))
  assert_true(Dataset::new(["A"], [[0.0]], [[1.0]]) is Err(_))
  assert_true(
    Dataset::new(["A", "A"], [[1.0], [2.0]], [[1.0], [1.0]]) is Err(_),
  )
  assert_true(
    Dataset::new(["A", "B"], [[1.0], [2.0, 3.0]], [[1.0], [1.0]]) is Err(_),
  )
  assert_true(Dataset::new(["A"], [[1.0 / 0.0]], [[1.0]]) is Err(_))
}
