///|
pub struct DirectionalResult {
  unit : String
  distance : Double
  weights : Array[Double]
  projected_inputs : Array[Double]
  projected_outputs : Array[Double]
  residual : Double
  iterations : Int32
}

///|
/// Direction components are fractions of the evaluation row, each in [0,1].
/// beta contracts x by beta*gx*x0 and expands y by beta*gy*y0.
pub fn directional(
  data : Dataset,
  unit : Int32,
  reference : Dataset,
  returns : Returns,
  gx : Array[Double],
  gy : Array[Double],
  budget~ : Int32 = 10000,
) -> Result[DirectionalResult, DeaError] {
  let p = match scale_panel(data, unit, reference) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  if gx.length() != data.input_count() || gy.length() != data.output_count() {
    return Err(Invalid("direction dimension mismatch"))
  }
  let mut nonzero = false
  for row in [gx, gy] {
    for v in row {
      if !finite(v) || v < 0.0 || v > 1.0 {
        return Err(Invalid("direction fractions must lie in [0,1]"))
      }
      if v > 0.0 {
        nonzero = true
      }
    }
  }
  if !nonzero {
    return Err(Invalid("zero direction"))
  }
  // Scaled direction coefficients must remain above simplex pivot resolution.
  for j in 0..<gx.length() {
    if gx[j] > 0.0 && gx[j] * p.x0[j] < 1.0e-8 {
      return Err(
        Invalid("scaled input direction is below numerical resolution"),
      )
    }
  }
  for j in 0..<gy.length() {
    if gy[j] > 0.0 && gy[j] * p.y0[j] < 1.0e-8 {
      return Err(
        Invalid("scaled output direction is below numerical resolution"),
      )
    }
  }
  let n = reference.size()
  let a = []
  let b = []
  for j in 0..<gx.length() {
    let row = p.x.map(fn(x) { x[j] })
    row.push(gx[j] * p.x0[j])
    a.push(row)
    b.push(p.x0[j])
  }
  for j in 0..<gy.length() {
    let row = p.y.map(fn(y) { -y[j] })
    row.push(gy[j] * p.y0[j])
    a.push(row)
    b.push(-p.y0[j])
  }
  returns_constraints(a, b, n + 1, n, returns)
  let c = Array::make(n + 1, 0.0)
  c[n] = 1.0
  let sol = match solve_linear(a, b, c, budget) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  let weights = sol.values[:n].to_owned()
  let beta = sol.values[n]
  let px = Array::make(gx.length(), 0.0)
  let py = Array::make(gy.length(), 0.0)
  for i in 0..<n {
    for j in 0..<gx.length() {
      px[j] = px[j] + weights[i] * reference.xs[i][j]
    }
    for j in 0..<gy.length() {
      py[j] = py[j] + weights[i] * reference.ys[i][j]
    }
  }
  let mut residual = 0.0
  for j in 0..<gx.length() {
    residual = residual.max(
      (px[j] / data.xs[unit][j] - (1.0 - beta * gx[j])).max(0.0),
    )
  }
  for j in 0..<gy.length() {
    residual = residual.max(
      (1.0 + beta * gy[j] - py[j] / data.ys[unit][j]).max(0.0),
    )
  }
  if !finite(beta) || !finite(residual) || residual > 1.0e-6 {
    return Err(Numerical("directional residual validation failed"))
  }
  Ok({
    unit: data.labels[unit],
    distance: beta,
    weights,
    projected_inputs: px,
    projected_outputs: py,
    residual,
    iterations: sol.iterations,
  })
}
