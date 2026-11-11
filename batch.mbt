///|
/// Every row retains its own failure. A failed model is never ranked as efficient.
pub fn evaluate(
  data : Dataset,
  reference : Dataset,
  returns : Returns,
  output~ : Bool = false,
  refine~ : Bool = true,
  budget~ : Int32 = 10000,
) -> Array[Result[RadialResult, DeaError]] {
  Array::makei(data.size(), fn(i) {
    if refine {
      radial_refined(data, i, reference, returns, output~, budget~)
    } else if output {
      output_radial(data, i, reference, returns, budget~)
    } else {
      input_radial(data, i, reference, returns, budget~)
    }
  })
}

///|
/// Excluding the evaluated row can make VRS super-efficiency infeasible.
pub fn super_efficiency(
  data : Dataset,
  unit : Int32,
  returns : Returns,
  output~ : Bool = false,
  budget~ : Int32 = 10000,
) -> Result[RadialResult, DeaError] {
  if unit < 0 || unit >= data.size() || data.size() < 2 {
    return Err(Invalid("super-efficiency needs a valid row and another peer"))
  }
  let indices = []
  for i in 0..<data.size() {
    if i != unit {
      indices.push(i)
    }
  }
  let reference = match data.select(indices) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  if output {
    output_radial(data, unit, reference, returns, budget~)
  } else {
    input_radial(data, unit, reference, returns, budget~)
  }
}
