///|
test "subresolution direction rejected instead of falsely reported unbounded" {
  let d = Dataset::new(["A", "B"], [[1.0], [2.0]], [[1.0], [1.0]]).unwrap()
  assert_true(directional(d, 1, d, CRS, [0.0], [1.0e-20]) is Err(Invalid(_)))
  near(directional(d, 1, d, CRS, [0.0], [0.01]).unwrap().distance, 100.0)
}

///|
test "permutation redundant variables and worst accepted dataset sizes" {
  let d = Dataset::new(["A", "B", "C"], [[1.0, 2.0], [2.0, 4.0], [3.0, 2.0]], [
    [1.0, 2.0],
    [1.0, 2.0],
    [2.0, 4.0],
  ]).unwrap()
  let perm = d.select([2, 0, 1]).unwrap()
  for returns in [CRS, VRS, NIRS, NDRS] {
    near(
      input_radial(d, 1, d, returns).unwrap().factor,
      input_radial(perm, 2, perm, returns).unwrap().factor,
    )
    near(
      output_radial(d, 1, d, returns).unwrap().factor,
      output_radial(perm, 2, perm, returns).unwrap().factor,
    )
  }
  let names = Array::makei(128, fn(i) { "row\{i}" })
  let x = Array::makei(128, fn(i) { Array::make(16, 1.0 + (i % 7).to_double()) })
  let y = Array::makei(128, fn(_) { Array::make(16, 1.0) })
  let large = Dataset::new(names, x, y).unwrap()
  near(input_crs(large, 1, large).unwrap().factor, 0.5)
  assert_true(input_crs(d, 0, d, budget=50001) is Err(Invalid(_)))
}

///|
test "input and output cross technology factors have reciprocal CRS identity" {
  let a = Dataset::new(["old"], [[2.0]], [[1.0]]).unwrap()
  let b = Dataset::new(["new"], [[1.0]], [[1.0]]).unwrap()
  near(input_crs(b, 0, a).unwrap().factor, 2.0)
  near(output_radial(b, 0, a, CRS).unwrap().factor, 0.5)
  near(
    input_crs(a, 0, b).unwrap().factor *
    output_radial(a, 0, b, CRS).unwrap().factor,
    1.0,
  )
}
