///|
fn main {
  let before = @dea.Dataset::new(["A", "B"], [[2.0], [4.0]], [[1.0], [1.0]]).unwrap()
  let after = @dea.Dataset::new(["B", "A"], [[2.0], [1.0]], [[1.0], [1.0]]).unwrap()
  let change = @dea.malmquist(before, after, 1).unwrap()
  assert_true((change.productivity - 2.0).abs() < 1.0e-6) catch {
    _ => abort("unexpected productivity")
  }
  let influence = @dea.sensitivity(before, 1, before, @dea.CRS).unwrap()
  let windows = @dea.rolling_windows([before, after], 2, @dea.CRS).unwrap()
  assert_eq(windows[1].reference_count, 4) catch {
    _ => abort("wrong window")
  }
  println("research: productivity=2; influence min=0.5 max=1; pooled peers=4")
  println(change.to_json().stringify())
  println(
    "successful exclusions: \{influence.successful}; failed exclusions: \{influence.failed}",
  )
}
