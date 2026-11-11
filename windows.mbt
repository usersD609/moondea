///|
/// Pool repeated observations with collision-free period/row identifiers.
pub fn pool_periods(
  periods : Array[Dataset],
  start : Int32,
  end : Int32,
) -> Result[Dataset, DeaError] {
  if start < 0 || end > periods.length() || start >= end || end - start > 32 {
    return Err(Invalid("invalid period window [start,end)"))
  }
  let names = []
  let x = []
  let y = []
  let base = periods[start]
  for t in start..<end {
    match compatible(base, periods[t]) {
      Err(e) => return Err(e)
      Ok(_) => ()
    }
    if names.length() + periods[t].size() > 128 {
      return Err(Invalid("pooled reference exceeds 128 rows"))
    }
    for i in 0..<periods[t].size() {
      names.push("p\{t}:r\{i}:" + periods[t].labels[i])
      x.push(periods[t].xs[i].copy())
      y.push(periods[t].ys[i].copy())
    }
  }
  Dataset::new(names, x, y)
}

///|
pub struct WindowResult {
  start : Int32
  end : Int32
  reference_count : Int32
  results : Array[Result[RadialResult, DeaError]]
}

///|
/// Evaluate each period against the trailing width periods, including the current one.
pub fn rolling_windows(
  periods : Array[Dataset],
  width : Int32,
  returns : Returns,
  output~ : Bool = false,
  budget~ : Int32 = 10000,
) -> Result[Array[WindowResult], DeaError] {
  if periods.length() == 0 ||
    periods.length() > 32 ||
    width < 1 ||
    width > periods.length() {
    return Err(Invalid("invalid rolling width or period count"))
  }
  let results = []
  for t in 0..<periods.length() {
    let start = (t + 1 - width).max(0)
    let reference = match pool_periods(periods, start, t + 1) {
      Ok(v) => v
      Err(e) => return Err(e)
    }
    results.push({
      start,
      end: t + 1,
      reference_count: reference.size(),
      results: evaluate(periods[t], reference, returns, output~, budget~),
    })
  }
  Ok(results)
}
