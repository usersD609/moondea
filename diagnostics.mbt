///|
pub struct PanelDiagnostics {
  observations : Int32
  inputs : Int32
  outputs : Int32
  duplicate_pairs : Array[(String, String)]
  input_spread : Array[Double]
  output_spread : Array[Double]
  within_solver_range : Bool
}

///|
fn column_spread(rows : Array[Array[Double]]) -> Array[Double] {
  let low = rows[0].copy()
  let high = rows[0].copy()
  for row in rows {
    for j in 0..<row.length() {
      low[j] = low[j].min(row[j])
      high[j] = high[j].max(row[j])
    }
  }
  high.mapi(fn(j, v) { v / low[j] })
}

///|
/// Descriptive preflight only: duplicates and dynamic range are not statistical significance tests.
pub fn diagnose(data : Dataset) -> PanelDiagnostics {
  let duplicates = []
  for i in 0..<data.size() {
    for j in 0..<i {
      let mut equal = true
      for k in 0..<data.input_count() {
        if data.xs[i][k] != data.xs[j][k] {
          equal = false
        }
      }
      for k in 0..<data.output_count() {
        if data.ys[i][k] != data.ys[j][k] {
          equal = false
        }
      }
      if equal {
        duplicates.push((data.labels[j], data.labels[i]))
      }
    }
  }
  let xs = column_spread(data.xs)
  let ys = column_spread(data.ys)
  let mut within = true
  for row in [xs, ys] {
    for v in row {
      if v > 1.0e6 {
        within = false
      }
    }
  }
  {
    observations: data.size(),
    inputs: data.input_count(),
    outputs: data.output_count(),
    duplicate_pairs: duplicates,
    input_spread: xs,
    output_spread: ys,
    within_solver_range: within,
  }
}

///|
/// Explicit change of measurement units, preserving row/column ordering and dataset invariants.
pub fn Dataset::rescale(
  self : Dataset,
  input_factors : Array[Double],
  output_factors : Array[Double],
) -> Result[Dataset, DeaError] {
  if input_factors.length() != self.input_count() ||
    output_factors.length() != self.output_count() {
    return Err(Invalid("unit factor dimensions differ"))
  }
  for factors in [input_factors, output_factors] {
    for v in factors {
      if !finite(v) || v <= 0.0 {
        return Err(Invalid("unit factors must be finite and positive"))
      }
    }
  }
  let x = self.xs.map(fn(row) { row.mapi(fn(j, v) { v * input_factors[j] }) })
  let y = self.ys.map(fn(row) { row.mapi(fn(j, v) { v * output_factors[j] }) })
  Dataset::new(self.labels, x, y)
}

///|
pub fn PanelDiagnostics::to_json(self : PanelDiagnostics) -> Json {
  Json::object({
    "observations": Json(self.observations),
    "inputs": Json(self.inputs),
    "outputs": Json(self.outputs),
    "duplicate_pairs": Json(self.duplicate_pairs),
    "input_spread": Json(self.input_spread),
    "output_spread": Json(self.output_spread),
    "within_solver_range": Json(self.within_solver_range),
  })
}
