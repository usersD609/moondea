///|
pub struct ProductivityResult {
  unit : String
  theta_00 : Double
  theta_10 : Double
  theta_01 : Double
  theta_11 : Double
  efficiency_change : Double
  technology_change : Double
  productivity : Double
}

///|
fn aligned_index(
  before : Dataset,
  after : Dataset,
  unit : Int32,
) -> Result[Int32, DeaError] {
  match compatible(before, after) {
    Err(e) => return Err(e)
    Ok(_) => ()
  }
  if unit < 0 || unit >= before.size() || before.size() != after.size() {
    return Err(Invalid("paired periods need equal named cohorts"))
  }
  let mut index = -1
  for name in before.labels {
    let mut found = false
    for j in 0..<after.size() {
      if after.labels[j] == name {
        found = true
        if name == before.labels[unit] {
          index = j
        }
      }
    }
    if !found {
      return Err(Invalid("paired period names differ"))
    }
  }
  Ok(index)
}

///|
/// CRS input Malmquist, progress convention >1. theta_ab evaluates period a on technology b.
/// Four positive radial factors give M=sqrt((theta10/theta00)*(theta11/theta01)).
pub fn malmquist(
  before : Dataset,
  after : Dataset,
  unit : Int32,
  budget~ : Int32 = 10000,
) -> Result[ProductivityResult, DeaError] {
  let j = match aligned_index(before, after, unit) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  let t00 = match input_crs(before, unit, before, budget~) {
    Ok(v) => v.factor
    Err(e) => return Err(e)
  }
  let t10 = match input_crs(after, j, before, budget~) {
    Ok(v) => v.factor
    Err(e) => return Err(e)
  }
  let t01 = match input_crs(before, unit, after, budget~) {
    Ok(v) => v.factor
    Err(e) => return Err(e)
  }
  let t11 = match input_crs(after, j, after, budget~) {
    Ok(v) => v.factor
    Err(e) => return Err(e)
  }
  for t in [t00, t10, t01, t11] {
    if t <= 0.0 || !finite(t) {
      return Err(Numerical("nonpositive cross-period factor"))
    }
  }
  let ec = t11 / t00
  let tc = (t10 / t11 * (t00 / t01)).sqrt()
  let productivity = (t10 / t00 * (t11 / t01)).sqrt()
  if !finite(ec) ||
    !finite(tc) ||
    !finite(productivity) ||
    (ec * tc - productivity).abs() > 1.0e-6 * (1.0 + productivity) {
    return Err(Numerical("Malmquist decomposition mismatch"))
  }
  Ok({
    unit: before.labels[unit],
    theta_00: t00,
    theta_10: t10,
    theta_01: t01,
    theta_11: t11,
    efficiency_change: ec,
    technology_change: tc,
    productivity,
  })
}
