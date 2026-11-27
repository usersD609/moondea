///|
test "trailing windows pool period identities and expose reference count" {
  let a = Dataset::new(["A"], [[1.0]], [[1.0]]).unwrap()
  let b = Dataset::new(["A"], [[2.0]], [[1.0]]).unwrap()
  let p = pool_periods([a, b], 0, 2).unwrap()
  assert_eq(p.size(), 2)
  assert_true(p.names()[0] != p.names()[1])
  let w = rolling_windows([a, b], 2, CRS).unwrap()
  assert_eq(w[0].reference_count, 1)
  assert_eq(w[1].reference_count, 2)
  near(w[1].results[0].unwrap().factor, 0.5)
  near(
    rolling_windows([a, b], 1, CRS).unwrap()[1].results[0].unwrap().factor,
    1.0,
  )
  assert_true(rolling_windows([a, b], 0, CRS) is Err(_))
  assert_true(pool_periods([a, b], 1, 1) is Err(_))
}

///|
test "pooled identifiers preserve valid maximum length and Unicode source names" {
  for name in [Array::make(128, "x").join(""), Array::make(64, "𐐀").join("")] {
    let d = Dataset::new([name], [[1.0]], [[1.0]]).unwrap()
    let pooled = pool_periods([d, d], 0, 2).unwrap()
    assert_eq(pooled.names(), ["p0:r0:", "p1:r0:"])
    assert_eq(d.names(), [name])
    let w = rolling_windows([d, d], 2, CRS).unwrap()
    assert_eq(w[1].reference_count, 2)
    assert_eq(w[1].results[0].unwrap().unit, name)
    near(w[1].results[0].unwrap().factor, 1.0)
  }
  let boundary = Array::make(122, "x").join("")
  let d = Dataset::new([boundary], [[1.0]], [[1.0]]).unwrap()
  assert_eq(pool_periods([d], 0, 1).unwrap().names()[0], "p0:r0:" + boundary)
}
