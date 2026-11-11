///|
pub struct AdditiveResult {
  unit : String
  normalized_gain : Double
  target : RadialResult
}

///|
/// Maximize sum(input slack / x0) + sum(output slack / y0), with no radial scaling.
pub fn additive(
  data : Dataset,
  unit : Int32,
  reference : Dataset,
  returns : Returns,
  budget~ : Int32 = 10000,
) -> Result[AdditiveResult, DeaError] {
  let p = match scale_panel(data, unit, reference) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  let n = reference.size()
  let a = []
  let b = []
  for j in 0..<data.input_count() {
    a.push(p.x.map(fn(x) { x[j] }))
    b.push(p.x0[j])
  }
  for j in 0..<data.output_count() {
    a.push(p.y.map(fn(y) { -y[j] }))
    b.push(-p.y0[j])
  }
  returns_constraints(a, b, n, n, returns)
  let c = Array::make(n, 0.0)
  for i in 0..<n {
    for j in 0..<data.input_count() {
      c[i] = c[i] - p.x[i][j] / p.x0[j]
    }
    for j in 0..<data.output_count() {
      c[i] = c[i] + p.y[i][j] / p.y0[j]
    }
  }
  let sol = match solve_linear(a, b, c, budget) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  let target = match
    projection(data, unit, reference, sol.values, 1.0, sol.iterations) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  let mut gain = 0.0
  for j in 0..<data.input_count() {
    gain = gain + target.input_slacks[j] / data.xs[unit][j]
  }
  for j in 0..<data.output_count() {
    gain = gain + target.output_slacks[j] / data.ys[unit][j]
  }
  let expected = sol.objective +
    data.input_count().to_double() -
    data.output_count().to_double()
  if !finite(gain) || (gain - expected).abs() > 1.0e-6 * (1.0 + gain.abs()) {
    return Err(Numerical("additive objective mismatch"))
  }
  Ok({ unit: data.labels[unit], normalized_gain: gain.max(0.0), target, })
}
