///|
priv struct LinearSolution {
  values : Array[Double]
  objective : Double
  iterations : Int32
}

///|
priv struct Tableau {
  rows : Array[Array[Double]]
  rhs : Array[Double]
  basis : Array[Int32]
  columns : Int32
  artificial_start : Int32
  mut iterations : Int32
}

///|
fn Tableau::new(
  a : Array[Array[Double]],
  b : Array[Double],
  n : Int32,
) -> Tableau {
  let m = b.length()
  let mut extra = 0
  for x in b {
    if x < 0.0 {
      extra = extra + 1
    }
  }
  let columns = n + m + extra
  let rows = []
  let rhs = []
  let basis = []
  let mut art = n + m
  for i in 0..<m {
    let row = Array::make(columns, 0.0)
    let sign = if b[i] < 0.0 { -1.0 } else { 1.0 }
    for j in 0..<n {
      row[j] = a[i][j] * sign
    }
    row[n + i] = sign
    if sign < 0.0 {
      row[art] = 1.0
      basis.push(art)
      art = art + 1
    } else {
      basis.push(n + i)
    }
    rows.push(row)
    rhs.push(b[i] * sign)
  }
  { rows, rhs, basis, columns, artificial_start: n + m, iterations: 0, }
}

///|
fn Tableau::pivot(
  self : Tableau,
  leaving : Int32,
  entering : Int32,
) -> Result[Unit, DeaError] {
  let pivot = self.rows[leaving][entering]
  if !finite(pivot) || pivot.abs() < 1.0e-12 {
    return Err(Numerical("unstable pivot"))
  }
  self.rhs[leaving] = self.rhs[leaving] / pivot
  for j in 0..<self.columns {
    self.rows[leaving][j] = self.rows[leaving][j] / pivot
  }
  for i in 0..<self.rows.length() {
    if i == leaving {
      continue
    }
    let factor = self.rows[i][entering]
    self.rhs[i] = self.rhs[i] - factor * self.rhs[leaving]
    if self.rhs[i].abs() < 1.0e-12 {
      self.rhs[i] = 0.0
    }
    for j in 0..<self.columns {
      self.rows[i][j] = self.rows[i][j] - factor * self.rows[leaving][j]
      if !finite(self.rows[i][j]) {
        return Err(Numerical("tableau overflow"))
      }
    }
    self.rows[i][entering] = 0.0
    if !finite(self.rhs[i]) || self.rhs[i] < -1.0e-7 {
      return Err(Numerical("lost primal feasibility"))
    }
  }
  self.rows[leaving][entering] = 1.0
  self.basis[leaving] = entering
  self.iterations = self.iterations + 1
  Ok(())
}

///|
fn Tableau::optimize(
  self : Tableau,
  costs : Array[Double],
  allowed : Int32,
  budget : Int32,
) -> Result[Unit, DeaError] {
  while true {
    // Bland's first improving column and basis-index tie break avoid cycling.
    let mut entering = -1
    for j in 0..<allowed {
      let mut reduced = costs[j]
      for i in 0..<self.rows.length() {
        reduced = reduced - costs[self.basis[i]] * self.rows[i][j]
      }
      if !finite(reduced) {
        return Err(Numerical("nonfinite reduced cost"))
      }
      if reduced > 1.0e-9 {
        entering = j
        break
      }
    }
    if entering < 0 {
      return Ok(())
    }
    if self.iterations >= budget {
      return Err(IterationLimit)
    }
    let mut leaving = -1
    let mut ratio = 0.0
    for i in 0..<self.rows.length() {
      let coefficient = self.rows[i][entering]
      if coefficient > 1.0e-10 {
        let candidate = self.rhs[i].max(0.0) / coefficient
        if leaving < 0 ||
          candidate < ratio - 1.0e-10 ||
          (
            (candidate - ratio).abs() <= 1.0e-10 &&
            self.basis[i] < self.basis[leaving]
          ) {
          leaving = i
          ratio = candidate
        }
      }
    }
    if leaving < 0 {
      return Err(Unbounded)
    }
    match self.pivot(leaving, entering) {
      Err(e) => return Err(e)
      Ok(_) => ()
    }
  } nobreak {
    Ok(())
  }
}

///|
/// Internal bounded maximization of c*x subject to A*x <= b and x >= 0.
/// Public callers supply only validated and scaled DEA models.
fn solve_linear(
  a : Array[Array[Double]],
  b : Array[Double],
  c : Array[Double],
  budget : Int32,
) -> Result[LinearSolution, DeaError] {
  let n = c.length()
  if n == 0 ||
    n > 192 ||
    a.length() != b.length() ||
    b.length() == 0 ||
    b.length() > 96 ||
    budget < 0 ||
    budget > 50000 {
    return Err(Invalid("internal model size or iteration budget invalid"))
  }
  for row in a {
    if row.length() != n {
      return Err(Invalid("internal ragged model"))
    }
    for x in row {
      if !finite(x) {
        return Err(Numerical("nonfinite coefficient"))
      }
    }
  }
  for x in b {
    if !finite(x) {
      return Err(Numerical("nonfinite bound"))
    }
  }
  for x in c {
    if !finite(x) {
      return Err(Numerical("nonfinite objective"))
    }
  }
  let t = Tableau::new(a, b, n)
  let phase_one = Array::make(t.columns, 0.0)
  for j in t.artificial_start..<t.columns {
    phase_one[j] = -1.0
  }
  match t.optimize(phase_one, t.artificial_start, budget) {
    Err(e) => return Err(e)
    Ok(_) => ()
  }
  let mut artificial_mass = 0.0
  for i in 0..<t.rows.length() {
    if t.basis[i] >= t.artificial_start {
      artificial_mass = artificial_mass + t.rhs[i]
    }
  }
  if artificial_mass > 1.0e-8 {
    return Err(Infeasible)
  }
  // Remove artificial basic columns at zero without discarding genuine constraints.
  for i in 0..<t.rows.length() {
    if t.basis[i] >= t.artificial_start {
      let mut entering = -1
      for j in 0..<t.artificial_start {
        if t.rows[i][j].abs() > 1.0e-9 {
          entering = j
          break
        }
      }
      if entering >= 0 {
        if t.iterations >= budget {
          return Err(IterationLimit)
        }
        match t.pivot(i, entering) {
          Err(e) => return Err(e)
          Ok(_) => ()
        }
      }
    }
  }
  let costs = Array::make(t.columns, 0.0)
  for j in 0..<n {
    costs[j] = c[j]
  }
  match t.optimize(costs, t.artificial_start, budget) {
    Err(e) => return Err(e)
    Ok(_) => ()
  }
  let values = Array::make(n, 0.0)
  for i in 0..<t.rows.length() {
    if t.basis[i] < n {
      values[t.basis[i]] = t.rhs[i].max(0.0)
    }
  }
  let mut objective = 0.0
  for j in 0..<n {
    objective = objective + c[j] * values[j]
  }
  if !finite(objective) {
    return Err(Numerical("nonfinite objective result"))
  }
  // Independently evaluate the original inequalities, not the transformed rows.
  for i in 0..<a.length() {
    let mut lhs = 0.0
    for j in 0..<n {
      lhs = lhs + a[i][j] * values[j]
    }
    if !finite(lhs) || lhs > b[i] + 1.0e-7 * (1.0 + b[i].abs()) {
      return Err(Numerical("original constraint residual"))
    }
  }
  Ok({ values, objective, iterations: t.iterations, })
}
