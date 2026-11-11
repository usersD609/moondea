///|
fn request_int(
  obj : Map[String, Json],
  name : String,
  fallback : Int32,
  minimum : Int32,
  maximum : Int32,
) -> Result[Int32, DeaError] {
  match obj.get(name) {
    None => Ok(fallback)
    Some(Number(v, ..)) => {
      if !finite(v) || v < minimum.to_double() || v > maximum.to_double() {
        return Err(Invalid("integer field out of range: " + name))
      }
      let i = v.to_int()
      if i.to_double() != v {
        Err(Invalid("noninteger field: " + name))
      } else {
        Ok(i)
      }
    }
    _ => Err(Invalid("expected integer field: " + name))
  }
}

///|
fn request_bool(
  obj : Map[String, Json],
  name : String,
  fallback : Bool,
) -> Result[Bool, DeaError] {
  match obj.get(name) {
    None => Ok(fallback)
    Some(True) => Ok(true)
    Some(False) => Ok(false)
    _ => Err(Invalid("expected boolean field: " + name))
  }
}

///|
fn request_returns(obj : Map[String, Json]) -> Result[Returns, DeaError] {
  match obj.get("returns") {
    None | Some(String("CRS")) => Ok(CRS)
    Some(String("VRS")) => Ok(VRS)
    Some(String("NIRS")) => Ok(NIRS)
    Some(String("NDRS")) => Ok(NDRS)
    _ => Err(Invalid("returns must be CRS, VRS, NIRS or NDRS"))
  }
}

///|
fn request_output(obj : Map[String, Json]) -> Result[Bool, DeaError] {
  match obj.get("orientation") {
    None | Some(String("input")) => Ok(false)
    Some(String("output")) => Ok(true)
    _ => Err(Invalid("orientation must be input or output"))
  }
}

///|
pub fn DirectionalResult::to_json(self : DirectionalResult) -> Json {
  Json::object({
    "status": Json::string("ok"),
    "unit": Json::string(self.unit),
    "distance": Json(self.distance),
    "weights": Json(self.weights),
    "projected_inputs": Json(self.projected_inputs),
    "projected_outputs": Json(self.projected_outputs),
    "residual": Json(self.residual),
    "iterations": Json(self.iterations),
  })
}

///|
pub fn ProductivityResult::to_json(self : ProductivityResult) -> Json {
  Json::object({
    "status": Json::string("ok"),
    "unit": Json(self.unit),
    "theta_00": Json(self.theta_00),
    "theta_10": Json(self.theta_10),
    "theta_01": Json(self.theta_01),
    "theta_11": Json(self.theta_11),
    "efficiency_change": Json(self.efficiency_change),
    "technology_change": Json(self.technology_change),
    "productivity": Json(self.productivity),
  })
}

///|
/// Strict, bounded integration protocol. No file/network access or implicit evaluation cache.
/// Each operation rejects fields it cannot honor.
pub fn execute_request(text : String) -> Result[Json, DeaError] {
  let value = match parse_json_document(text) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  let initial = match value {
    Object(v) => v
    _ => return Err(Invalid("request must be an object"))
  }
  let operation = match initial.get("operation") {
    Some(String(s)) => s
    _ => return Err(Invalid("request needs operation"))
  }
  let fields = ["schema", "operation", "data", "budget"]
  match operation {
    "benchmark" | "radial" => {
      for k in ["reference", "returns", "orientation", "refine"] {
        fields.push(k)
      }
      if operation == "radial" {
        fields.push("unit")
      }
    }
    "additive" =>
      for k in ["reference", "returns", "unit"] {
        fields.push(k)
      }
    "directional" =>
      for k in ["reference", "returns", "unit", "gx", "gy"] {
        fields.push(k)
      }
    "super" =>
      for k in ["returns", "orientation", "unit"] {
        fields.push(k)
      }
    "scale" => fields.push("unit")
    "productivity" => {
      fields.push("unit")
      fields.push("after")
    }
    _ => return Err(Invalid("unknown operation"))
  }
  let obj = match json_object(value, fields, ["schema", "operation", "data"]) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  match obj["schema"] {
    Number(v, ..) if v == 1.0 => ()
    _ => return Err(Invalid("unsupported request schema"))
  }
  let data = match decode_table(obj["data"]) {
    Ok(t) => t.dataset()
    Err(e) => return Err(e)
  }
  let reference = match obj.get("reference") {
    None => data
    Some(v) =>
      match decode_table(v) {
        Ok(t) => t.dataset()
        Err(e) => return Err(e)
      }
  }
  let budget = match request_int(obj, "budget", 10000, 0, 50000) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  let unit = if operation == "benchmark" {
    0
  } else {
    if !obj.contains("unit") {
      return Err(Invalid("row operation needs unit index"))
    }
    match request_int(obj, "unit", 0, 0, data.size() - 1) {
      Ok(v) => v
      Err(e) => return Err(e)
    }
  }
  let returns = match request_returns(obj) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  let output = match request_output(obj) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  let refine = match request_bool(obj, "refine", true) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  match operation {
    "benchmark" =>
      benchmark_report(data, reference, returns, output~, refine~, budget~)
    "radial" => {
      let r = if refine {
        radial_refined(data, unit, reference, returns, output~, budget~)
      } else if output {
        output_radial(data, unit, reference, returns, budget~)
      } else {
        input_radial(data, unit, reference, returns, budget~)
      }
      r.map(fn(v) { v.to_json() })
    }
    "additive" =>
      additive(data, unit, reference, returns, budget~).map(fn(v) {
        Json::object({
          "status": Json::string("ok"),
          "unit": Json(v.unit),
          "normalized_gain": Json(v.normalized_gain),
          "target": v.target.to_json(),
        })
      })
    "directional" => {
      let gx : Array[Double] = @json.from_json(
        obj.get_or_default("gx", Json::null()),
      ) catch {
        _ => return Err(Invalid("gx must be numeric array"))
      }
      let gy : Array[Double] = @json.from_json(
        obj.get_or_default("gy", Json::null()),
      ) catch {
        _ => return Err(Invalid("gy must be numeric array"))
      }
      directional(data, unit, reference, returns, gx, gy, budget~).map(fn(v) {
        v.to_json()
      })
    }
    "super" =>
      super_efficiency(data, unit, returns, output~, budget~).map(fn(v) {
        v.to_json()
      })
    "scale" =>
      scale_efficiency(data, unit, budget~).map(fn(v) {
        Json::object({
          "status": Json::string("ok"),
          "unit": Json(v.unit),
          "crs_efficiency": Json(v.crs_efficiency),
          "vrs_efficiency": Json(v.vrs_efficiency),
          "scale_efficiency": Json(v.scale_efficiency),
          "crs": v.crs.to_json(),
          "vrs": v.vrs.to_json(),
        })
      })
    "productivity" => {
      let after = match
        decode_table(obj.get_or_default("after", Json::null())) {
        Ok(t) => t.dataset()
        Err(e) => return Err(e)
      }
      malmquist(data, after, unit, budget~).map(fn(v) { v.to_json() })
    }
    _ => Err(Invalid("unknown operation"))
  }
}

///|
/// Convenient service adapter: validation/model errors become JSON, never partial success.
pub fn respond(text : String) -> String {
  match execute_request(text) {
    Ok(v) => v.stringify()
    Err(e) => e.to_json().stringify()
  }
}
