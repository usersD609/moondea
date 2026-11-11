///|
pub struct PanelTable {
  priv panel : Dataset
  priv input_headers : Array[String]
  priv output_headers : Array[String]
}

///|
pub fn PanelTable::new(
  panel : Dataset,
  inputs : Array[String],
  outputs : Array[String],
) -> Result[PanelTable, DeaError] {
  if inputs.length() != panel.input_count() ||
    outputs.length() != panel.output_count() {
    return Err(Invalid("header dimensions differ"))
  }
  let seen : Array[String] = []
  for headers in [inputs, outputs] {
    for name in headers {
      if name.length() == 0 || name.length() > 128 || name.trim().is_empty() {
        return Err(Invalid("invalid variable name"))
      }
      for old in seen {
        if old == name {
          return Err(Invalid("duplicate variable name"))
        }
      }
      seen.push(name)
    }
  }
  Ok({ panel, input_headers: inputs.copy(), output_headers: outputs.copy(), })
}

///|
pub fn PanelTable::dataset(self : PanelTable) -> Dataset {
  self.panel
}

///|
pub fn PanelTable::input_names(self : PanelTable) -> Array[String] {
  self.input_headers.copy()
}

///|
pub fn PanelTable::output_names(self : PanelTable) -> Array[String] {
  self.output_headers.copy()
}

///|
fn csv_records(text : String) -> Result[Array[Array[String]], DeaError] {
  if text.length() == 0 || text.length() > 262144 {
    return Err(Invalid("CSV size must be 1..262144 code units"))
  }
  let chars = text.to_array()
  let rows = []
  let row = []
  let cell = []
  let mut quoted = false
  let mut closed = false
  let mut started = false
  let mut i = 0
  while i < chars.length() {
    let ch = chars[i]
    if quoted {
      if ch == '"' {
        if i + 1 < chars.length() && chars[i + 1] == '"' {
          cell.push('"')
          i = i + 1
        } else {
          quoted = false
          closed = true
        }
      } else {
        cell.push(ch)
      }
    } else if ch == ',' || ch == '\n' || ch == '\r' {
      if ch == '\r' {
        if i + 1 >= chars.length() || chars[i + 1] != '\n' {
          return Err(Invalid("bare CR record separator"))
        }
        i = i + 1
      }
      row.push(String::from_array(cell))
      cell.clear()
      closed = false
      started = false
      if row.length() > 33 {
        return Err(Invalid("CSV exceeds 33 fields"))
      }
      if ch != ',' {
        rows.push(row.copy())
        row.clear()
        if rows.length() > 129 {
          return Err(Invalid("CSV exceeds 129 records"))
        }
      }
    } else if closed {
      return Err(Invalid("characters after closing CSV quote"))
    } else if ch == '"' {
      if started {
        return Err(Invalid("quote inside unquoted CSV field"))
      }
      quoted = true
      started = true
    } else {
      cell.push(ch)
      started = true
    }
    if cell.length() > 8192 {
      return Err(Invalid("CSV field exceeds 8192 characters"))
    }
    i = i + 1
  }
  if quoted {
    return Err(Invalid("unterminated CSV quote"))
  }
  if started || closed || row.length() > 0 {
    row.push(String::from_array(cell))
    if row.length() > 33 {
      return Err(Invalid("CSV exceeds 33 fields"))
    }
    rows.push(row.copy())
  }
  if rows.length() < 2 || rows.length() > 129 {
    return Err(Invalid("CSV needs a header and 1..128 rows"))
  }
  Ok(rows)
}

///|
fn numeric_cell(text : String) -> Result[Double, DeaError] {
  let value = @json.parse(text.trim(), max_nesting_depth=1) catch {
    _ => return Err(Invalid("invalid decimal CSV number"))
  }
  match value {
    Number(x, ..) =>
      if finite(x) {
        Ok(x)
      } else {
        Err(Invalid("nonfinite CSV number"))
      }
    _ => Err(Invalid("CSV numeric cell is not a number"))
  }
}

///|
/// Schema: unit,input:NAME,...,output:NAME,...; quoted Unicode and LF/CRLF supported.
pub fn read_csv(text : String) -> Result[PanelTable, DeaError] {
  let rows = match csv_records(text) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  let head = rows[0]
  if head.length() < 3 || head[0] != "unit" {
    return Err(Invalid("CSV header must start with unit"))
  }
  let inputs = []
  let outputs = []
  let mut in_outputs = false
  for j in 1..<head.length() {
    if head[j].has_prefix("input:") && !in_outputs {
      inputs.push(head[j][6:].to_owned())
    } else if head[j].has_prefix("output:") {
      in_outputs = true
      outputs.push(head[j][7:].to_owned())
    } else {
      return Err(Invalid("CSV requires input: then output: columns"))
    }
  }
  if inputs.length() == 0 || outputs.length() == 0 {
    return Err(Invalid("CSV needs both input and output variables"))
  }
  let names = []
  let x = []
  let y = []
  for i in 1..<rows.length() {
    if rows[i].length() != head.length() {
      return Err(Invalid("CSV ragged record"))
    }
    names.push(rows[i][0])
    let xr = []
    let yr = []
    for j in 1..<head.length() {
      let v = match numeric_cell(rows[i][j]) {
        Ok(v) => v
        Err(e) => return Err(e)
      }
      if j <= inputs.length() {
        xr.push(v)
      } else {
        yr.push(v)
      }
    }
    x.push(xr)
    y.push(yr)
  }
  let panel = match Dataset::new(names, x, y) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  PanelTable::new(panel, inputs, outputs)
}

///|
fn csv_escape(value : String) -> String {
  "\"" + value.replace_all(old="\"", new="\"\"") + "\""
}

///|
pub fn PanelTable::to_csv(self : PanelTable) -> String {
  let header = ["unit"]
  for name in self.input_headers {
    header.push(csv_escape("input:" + name))
  }
  for name in self.output_headers {
    header.push(csv_escape("output:" + name))
  }
  let lines = [header.join(",")]
  for i in 0..<self.panel.size() {
    let row = [csv_escape(self.panel.labels[i])]
    for v in self.panel.xs[i] {
      row.push(v.to_string())
    }
    for v in self.panel.ys[i] {
      row.push(v.to_string())
    }
    lines.push(row.join(","))
  }
  lines.join("\n") + "\n"
}
