///|
fn json_object(
  value : Json,
  allowed : Array[String],
  required : Array[String],
) -> Result[Map[String, Json], DeaError] {
  let obj = match value {
    Object(v) => v
    _ => return Err(Invalid("expected JSON object"))
  }
  for key, _ in obj {
    let mut known = false
    for name in allowed {
      if name == key {
        known = true
      }
    }
    if !known {
      return Err(Invalid("unknown JSON field: " + key))
    }
  }
  for key in required {
    if !obj.contains(key) {
      return Err(Invalid("missing JSON field: " + key))
    }
  }
  Ok(obj)
}

///|
fn parse_json_document(text : String) -> Result[Json, DeaError] {
  if text.length() == 0 || text.length() > 262144 {
    return Err(Invalid("JSON size must be 1..262144 code units"))
  }
  Ok(@json.parse(text[:], max_nesting_depth=8, reject_duplicate_keys=true)) catch {
    _ => Err(Invalid("invalid, duplicate-key or overnested JSON"))
  }
}

///|
fn decode_table(value : Json) -> Result[PanelTable, DeaError] {
  let fields = [
    "schema", "names", "inputs", "outputs", "input_names", "output_names",
  ]
  let obj = match json_object(value, fields, fields) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  match obj["schema"] {
    Number(v, ..) if v == 1.0 => ()
    _ => return Err(Invalid("unsupported panel schema"))
  }
  let names : Array[String] = @json.from_json(obj["names"]) catch {
    _ => return Err(Invalid("names must be strings"))
  }
  let inputs : Array[Array[Double]] = @json.from_json(obj["inputs"]) catch {
    _ => return Err(Invalid("inputs must be a numeric matrix"))
  }
  let outputs : Array[Array[Double]] = @json.from_json(obj["outputs"]) catch {
    _ => return Err(Invalid("outputs must be a numeric matrix"))
  }
  let input_names : Array[String] = @json.from_json(obj["input_names"]) catch {
    _ => return Err(Invalid("input_names must be strings"))
  }
  let output_names : Array[String] = @json.from_json(obj["output_names"]) catch {
    _ => return Err(Invalid("output_names must be strings"))
  }
  let data = match Dataset::new(names, inputs, outputs) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  PanelTable::new(data, input_names, output_names)
}

///|
/// Versioned, strict snapshot preserving names, variable headers and original units.
pub fn read_json(text : String) -> Result[PanelTable, DeaError] {
  let value = match parse_json_document(text) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  decode_table(value)
}

///|
pub fn PanelTable::to_json(self : PanelTable) -> Json {
  Json::object({
    "schema": Json::number(1.0),
    "names": Json(self.panel.labels),
    "inputs": Json(self.panel.xs),
    "outputs": Json(self.panel.ys),
    "input_names": Json(self.input_headers),
    "output_names": Json(self.output_headers),
  })
}
