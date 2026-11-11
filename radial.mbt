///|
pub struct RadialResult {
  unit : String
  factor : Double
  weights : Array[Double]
  reference_names : Array[String]
  projected_inputs : Array[Double]
  projected_outputs : Array[Double]
  input_slacks : Array[Double]
  output_slacks : Array[Double]
  residual : Double
  iterations : Int32
}

///|
fn compatible(data : Dataset, reference : Dataset) -> Result[Unit, DeaError] {
  if data.input_count() != reference.input_count() ||
    data.output_count() != reference.output_count() {
    Err(Invalid("evaluation/reference dimensions differ"))
  } else {
    Ok(())
  }
}

///|
priv struct ScaledPanel {
  x : Array[Array[Double]]
  y : Array[Array[Double]]
  x0 : Array[Double]
  y0 : Array[Double]
}

///|
fn scale_panel(
  data : Dataset,
  unit : Int32,
  reference : Dataset,
) -> Result[ScaledPanel, DeaError] {
  match compatible(data, reference) {
    Err(e) => return Err(e)
    Ok(_) => ()
  }
  if unit < 0 || unit >= data.size() {
    return Err(Invalid("evaluation row index outside dataset"))
  }
  let xscale = data.xs[unit].copy()
  let yscale = data.ys[unit].copy()
  for i in 0..<reference.size() {
    for j in 0..<xscale.length() {
      xscale[j] = xscale[j].max(reference.xs[i][j])
    }
    for j in 0..<yscale.length() {
      yscale[j] = yscale[j].max(reference.ys[i][j])
    }
  }
  let x = []
  let y = []
  for i in 0..<reference.size() {
    x.push(reference.xs[i].mapi(fn(j, v) { v / xscale[j] }))
    y.push(reference.ys[i].mapi(fn(j, v) { v / yscale[j] }))
  }
  let x0 = data.xs[unit].mapi(fn(j, v) { v / xscale[j] })
  let y0 = data.ys[unit].mapi(fn(j, v) { v / yscale[j] })
  // A column spread beyond this bound can disappear into LP tolerances.
  for matrix in [x, y, [x0, y0]] {
    for row in matrix {
      for v in row {
        if v < 1.0e-6 {
          return Err(Invalid("column dynamic range exceeds 1e6"))
        }
      }
    }
  }
  Ok({ x, y, x0, y0, })
}

///|
fn projection(
  data : Dataset,
  unit : Int32,
  reference : Dataset,
  weights : Array[Double],
  factor : Double,
  iterations : Int32,
  output~ : Bool = false,
) -> Result[RadialResult, DeaError] {
  let px = Array::make(data.input_count(), 0.0)
  let py = Array::make(data.output_count(), 0.0)
  for i in 0..<reference.size() {
    if !finite(weights[i]) || weights[i] < -1.0e-8 {
      return Err(Numerical("invalid peer weight"))
    }
    for j in 0..<px.length() {
      px[j] = px[j] + weights[i] * reference.xs[i][j]
    }
    for j in 0..<py.length() {
      py[j] = py[j] + weights[i] * reference.ys[i][j]
    }
  }
  let sx = []
  let sy = []
  let mut residual = 0.0
  for j in 0..<px.length() {
    let slack = (if output { 1.0 } else { factor }) * data.xs[unit][j] - px[j]
    sx.push(slack)
    residual = residual.max((-slack).max(0.0) / data.xs[unit][j])
  }
  for j in 0..<py.length() {
    let slack = py[j] - (if output { factor } else { 1.0 }) * data.ys[unit][j]
    sy.push(slack)
    residual = residual.max((-slack).max(0.0) / data.ys[unit][j])
  }
  if !finite(factor) || !finite(residual) || residual > 1.0e-6 {
    return Err(Numerical("peer projection failed residual validation"))
  }
  Ok({
    unit: data.labels[unit],
    factor,
    weights: weights.copy(),
    reference_names: reference.names(),
    projected_inputs: px,
    projected_outputs: py,
    input_slacks: sx,
    output_slacks: sy,
    residual,
    iterations,
  })
}

///|
pub(all) enum Returns {
  CRS
  VRS
  NIRS
  NDRS
} derive(Debug)

///|
pub extend Returns with @debug.Debug::{to_repr}

///|
fn returns_constraints(
  a : Array[Array[Double]],
  b : Array[Double],
  columns : Int32,
  peers : Int32,
  returns : Returns,
) -> Unit {
  let upper = match returns {
    VRS | NIRS => true
    _ => false
  }
  let lower = match returns {
    VRS | NDRS => true
    _ => false
  }
  if upper {
    a.push(Array::makei(columns, fn(j) { if j < peers { 1.0 } else { 0.0 } }))
    b.push(1.0)
  }
  if lower {
    a.push(Array::makei(columns, fn(j) { if j < peers { -1.0 } else { 0.0 } }))
    b.push(-1.0)
  }
}

///|
/// Input-oriented radial efficiency against explicit reference technology.
pub fn input_radial(
  data : Dataset,
  unit : Int32,
  reference : Dataset,
  returns : Returns,
  budget~ : Int32 = 10000,
) -> Result[RadialResult, DeaError] {
  let p = match scale_panel(data, unit, reference) {
    Ok(p) => p
    Err(e) => return Err(e)
  }
  let n = reference.size()
  let a = []
  let b = []
  for j in 0..<data.input_count() {
    let row = p.x.map(fn(x) { x[j] })
    row.push(-p.x0[j])
    a.push(row)
    b.push(0.0)
  }
  for j in 0..<data.output_count() {
    let row = p.y.map(fn(y) { -y[j] })
    row.push(0.0)
    a.push(row)
    b.push(-p.y0[j])
  }
  returns_constraints(a, b, n + 1, n, returns)
  let c = Array::make(n + 1, 0.0)
  c[n] = -1.0
  let sol = match solve_linear(a, b, c, budget) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  if (sol.objective + sol.values[n]).abs() > 1.0e-7 {
    return Err(Numerical("objective mismatch"))
  }
  projection(
    data,
    unit,
    reference,
    sol.values[:n].to_owned(),
    sol.values[n],
    sol.iterations,
  )
}

///|
pub fn input_crs(
  data : Dataset,
  unit : Int32,
  reference : Dataset,
  budget~ : Int32 = 10000,
) -> Result[RadialResult, DeaError] {
  input_radial(data, unit, reference, CRS, budget~)
}

///|
/// Output-oriented expansion factor phi; reciprocal is the [0,1] self-reference score.
pub fn output_radial(
  data : Dataset,
  unit : Int32,
  reference : Dataset,
  returns : Returns,
  budget~ : Int32 = 10000,
) -> Result[RadialResult, DeaError] {
  let p = match scale_panel(data, unit, reference) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  let n = reference.size()
  let a = []
  let b = []
  for j in 0..<data.input_count() {
    let row = p.x.map(fn(x) { x[j] })
    row.push(0.0)
    a.push(row)
    b.push(p.x0[j])
  }
  for j in 0..<data.output_count() {
    let row = p.y.map(fn(y) { -y[j] })
    row.push(p.y0[j])
    a.push(row)
    b.push(0.0)
  }
  returns_constraints(a, b, n + 1, n, returns)
  let c = Array::make(n + 1, 0.0)
  c[n] = 1.0
  let sol = match solve_linear(a, b, c, budget) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  projection(
    data,
    unit,
    reference,
    sol.values[:n].to_owned(),
    sol.values[n],
    sol.iterations,
    output=true,
  )
}
