///|
pub struct ScaleResult {
  unit : String
  crs_efficiency : Double
  vrs_efficiency : Double
  scale_efficiency : Double
  crs : RadialResult
  vrs : RadialResult
}

///|
/// Same-reference input decomposition theta_CRS = SE * theta_VRS.
pub fn scale_efficiency(
  data : Dataset,
  unit : Int32,
  budget~ : Int32 = 10000,
) -> Result[ScaleResult, DeaError] {
  let crs = match input_radial(data, unit, data, CRS, budget~) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  let vrs = match input_radial(data, unit, data, VRS, budget~) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  if vrs.factor <= 0.0 || crs.factor <= 0.0 {
    return Err(Numerical("nonpositive radial efficiency"))
  }
  let scale = crs.factor / vrs.factor
  if !finite(scale) || scale > 1.0 + 1.0e-6 || scale < 0.0 {
    return Err(Numerical("scale decomposition outside [0,1]"))
  }
  Ok({
    unit: data.labels[unit],
    crs_efficiency: crs.factor,
    vrs_efficiency: vrs.factor,
    scale_efficiency: scale,
    crs,
    vrs,
  })
}
