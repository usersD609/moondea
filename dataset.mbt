///|
pub(all) enum DeaError {
  Invalid(String)
  Infeasible
  Unbounded
  IterationLimit
  Numerical(String)
} derive(Debug)

///|
pub struct Dataset {
  priv labels : Array[String]
  priv xs : Array[Array[Double]]
  priv ys : Array[Array[Double]]
}

///|
fn finite(x : Double) -> Bool {
  !x.is_nan() && !x.is_inf()
}

///|
fn copy_matrix(a : Array[Array[Double]]) -> Array[Array[Double]] {
  a.map(fn(row) { row.copy() })
}

///|
/// Snapshot a strictly positive, finite dense panel. Limits protect tableau allocation.
pub fn Dataset::new(
  names : Array[String],
  inputs : Array[Array[Double]],
  outputs : Array[Array[Double]],
) -> Result[Dataset, DeaError] {
  let n = names.length()
  if n == 0 || n > 128 || inputs.length() != n || outputs.length() != n {
    return Err(Invalid("expected 1..128 consistently named rows"))
  }
  let m = inputs[0].length()
  let s = outputs[0].length()
  if m == 0 || s == 0 || m > 16 || s > 16 {
    return Err(Invalid("expected 1..16 inputs and outputs"))
  }
  for i in 0..<n {
    if names[i].length() == 0 || names[i].length() > 128 {
      return Err(Invalid("invalid unit name"))
    }
    for j in 0..<i {
      if names[j] == names[i] {
        return Err(Invalid("duplicate unit name"))
      }
    }
    if inputs[i].length() != m || outputs[i].length() != s {
      return Err(Invalid("ragged matrix"))
    }
    for row in [inputs[i], outputs[i]] {
      for x in row {
        if !finite(x) || x < 1.0e-9 || x > 1.0e9 {
          return Err(Invalid("data must lie in [1.0e-9,1.0e9]"))
        }
      }
    }
  }
  Ok({
    labels: names.copy(),
    xs: copy_matrix(inputs),
    ys: copy_matrix(outputs),
  })
}

///|
pub fn Dataset::size(self : Dataset) -> Int32 {
  self.labels.length()
}

///|
pub fn Dataset::input_count(self : Dataset) -> Int32 {
  self.xs[0].length()
}

///|
pub fn Dataset::output_count(self : Dataset) -> Int32 {
  self.ys[0].length()
}

///|
pub fn Dataset::names(self : Dataset) -> Array[String] {
  self.labels.copy()
}

///|
pub fn Dataset::inputs(self : Dataset) -> Array[Array[Double]] {
  copy_matrix(self.xs)
}

///|
pub fn Dataset::outputs(self : Dataset) -> Array[Array[Double]] {
  copy_matrix(self.ys)
}

///|
/// Select a new independently owned reference cohort, preserving requested order.
pub fn Dataset::select(
  self : Dataset,
  indices : Array[Int32],
) -> Result[Dataset, DeaError] {
  if indices.length() == 0 || indices.length() > self.size() {
    return Err(Invalid("empty or oversized selection"))
  }
  let names = []
  let xs = []
  let ys = []
  for i in indices {
    if i < 0 || i >= self.size() {
      return Err(Invalid("row index outside dataset"))
    }
    names.push(self.labels[i])
    xs.push(self.xs[i])
    ys.push(self.ys[i])
  }
  Dataset::new(names, xs, ys)
}

///|
pub extend DeaError with @debug.Debug::{to_repr}
