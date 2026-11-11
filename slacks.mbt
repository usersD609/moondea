///|
/// Lexicographic second stage: hold the radial optimum and maximize normalized slacks.
/// The budget covers both stages; peer decompositions need not be unique.
pub fn radial_refined(
  data : Dataset,
  unit : Int32,
  reference : Dataset,
  returns : Returns,
  output~ : Bool = false,
  budget~ : Int32 = 10000,
) -> Result[RadialResult, DeaError] {
  let first = match
    (if output {
      output_radial(data, unit, reference, returns, budget~)
    } else {
      input_radial(data, unit, reference, returns, budget~)
    }) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  let p = match scale_panel(data, unit, reference) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  let n = reference.size()
  let a = []
  let b = []
  for j in 0..<data.input_count() {
    a.push(p.x.map(fn(x) { x[j] }))
    b.push(p.x0[j] * (if output { 1.0 } else { first.factor }))
  }
  for j in 0..<data.output_count() {
    a.push(p.y.map(fn(y) { -y[j] }))
    b.push(-p.y0[j] * (if output { first.factor } else { 1.0 }))
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
  let sol = match solve_linear(a, b, c, budget - first.iterations) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  projection(
    data,
    unit,
    reference,
    sol.values,
    first.factor,
    first.iterations + sol.iterations,
    output~,
  )
}

///|
/// Strong efficiency requires a unit radial factor AND no material normalized slack.
pub fn strongly_efficient(
  data : Dataset,
  unit : Int32,
  result : RadialResult,
  tolerance~ : Double = 1.0e-6,
) -> Result[Bool, DeaError] {
  if unit < 0 ||
    unit >= data.size() ||
    !finite(tolerance) ||
    tolerance <= 0.0 ||
    tolerance > 0.01 {
    return Err(Invalid("invalid diagnostic index or tolerance"))
  }
  if result.unit != data.labels[unit] ||
    result.input_slacks.length() != data.input_count() ||
    result.output_slacks.length() != data.output_count() {
    return Err(Invalid("result does not match unit dimensions"))
  }
  if (result.factor - 1.0).abs() > tolerance {
    return Ok(false)
  }
  for j in 0..<data.input_count() {
    if result.input_slacks[j].abs() / data.xs[unit][j] > tolerance {
      return Ok(false)
    }
  }
  for j in 0..<data.output_count() {
    if result.output_slacks[j].abs() / data.ys[unit][j] > tolerance {
      return Ok(false)
    }
  }
  Ok(true)
}
