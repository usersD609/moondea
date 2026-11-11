///|
pub struct InfluenceResult {
  excluded : String
  result : Result[RadialResult, DeaError]
}

///|
pub struct SensitivityResult {
  baseline : RadialResult
  exclusions : Array[InfluenceResult]
  successful : Int32
  failed : Int32
  minimum : Double
  maximum : Double
}

///|
/// Leave one reference unit out at a time; preserve infeasibility as an explicit row status.
pub fn sensitivity(
  data : Dataset,
  unit : Int32,
  reference : Dataset,
  returns : Returns,
  output~ : Bool = false,
  budget~ : Int32 = 10000,
) -> Result[SensitivityResult, DeaError] {
  if reference.size() < 2 {
    return Err(Invalid("sensitivity needs at least two reference rows"))
  }
  let baseline = match
    (if output {
      output_radial(data, unit, reference, returns, budget~)
    } else {
      input_radial(data, unit, reference, returns, budget~)
    }) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  let exclusions = []
  let mut successful = 0
  let mut failed = 0
  let mut minimum = baseline.factor
  let mut maximum = baseline.factor
  for omitted in 0..<reference.size() {
    let indices = []
    for i in 0..<reference.size() {
      if i != omitted {
        indices.push(i)
      }
    }
    let r = match reference.select(indices) {
      Ok(v) => v
      Err(e) => return Err(e)
    }
    let result = if output {
      output_radial(data, unit, r, returns, budget~)
    } else {
      input_radial(data, unit, r, returns, budget~)
    }
    match result {
      Ok(v) => {
        successful = successful + 1
        minimum = minimum.min(v.factor)
        maximum = maximum.max(v.factor)
      }
      Err(_) => failed = failed + 1
    }
    exclusions.push({ excluded: reference.labels[omitted], result, })
  }
  Ok({ baseline, exclusions, successful, failed, minimum, maximum, })
}
