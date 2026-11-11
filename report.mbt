///|
pub fn DeaError::code(self : DeaError) -> String {
  match self {
    Invalid(_) => "invalid"
    Infeasible => "infeasible"
    Unbounded => "unbounded"
    IterationLimit => "iteration_limit"
    Numerical(_) => "numerical"
  }
}

///|
pub fn DeaError::to_json(self : DeaError) -> Json {
  let message = match self {
    Invalid(s) | Numerical(s) => s
    Infeasible => "reference technology is infeasible"
    Unbounded => "model is unbounded"
    IterationLimit => "iteration budget exhausted"
  }
  Json::object({
    "status": Json::string("error"),
    "code": Json::string(self.code()),
    "message": Json::string(message),
  })
}

///|
pub fn RadialResult::to_json(self : RadialResult) -> Json {
  Json::object({
    "status": Json::string("ok"),
    "unit": Json::string(self.unit),
    "factor": Json::number(self.factor),
    "weights": Json(self.weights),
    "reference_names": Json(self.reference_names),
    "projected_inputs": Json(self.projected_inputs),
    "projected_outputs": Json(self.projected_outputs),
    "input_slacks": Json(self.input_slacks),
    "output_slacks": Json(self.output_slacks),
    "residual": Json::number(self.residual),
    "iterations": Json(self.iterations),
  })
}

///|
pub struct ScoreRow {
  unit : String
  score : Double
  factor : Double
  rank : Int32
}

///|
pub struct ScoreSummary {
  rows : Array[ScoreRow]
  failures : Int32
  mean : Double?
  minimum : Double?
  maximum : Double?
}

///|
/// Order successful scores descending; equal scores within tolerance share competition rank.
/// Input scores equal theta; output scores equal 1/phi, including cross-reference scores >1.
pub fn summarize(
  results : Array[Result[RadialResult, DeaError]],
  output~ : Bool = false,
) -> Result[ScoreSummary, DeaError] {
  if results.length() == 0 || results.length() > 128 {
    return Err(Invalid("summary needs 1..128 results"))
  }
  let rows : Array[ScoreRow] = []
  let mut failures = 0
  let mut total = 0.0
  for result in results {
    match result {
      Err(_) => failures = failures + 1
      Ok(v) => {
        if !finite(v.factor) || v.factor <= 0.0 {
          return Err(Numerical("summary received nonpositive factor"))
        }
        let score = if output { 1.0 / v.factor } else { v.factor }
        if !finite(score) {
          return Err(Numerical("summary score overflow"))
        }
        rows.push({ unit: v.unit, score, factor: v.factor, rank: 0, })
        total = total + score
      }
    }
  }
  // Bounded stable insertion sort; ties preserve evaluation order.
  for i in 1..<rows.length() {
    let value = rows[i]
    let mut j = i
    while j > 0 && rows[j - 1].score < value.score {
      rows[j] = rows[j - 1]
      j = j - 1
    }
    rows[j] = value
  }
  let mut rank = 1
  let mut anchor = if rows.length() > 0 { rows[0].score } else { 0.0 }
  for i in 0..<rows.length() {
    if (rows[i].score - anchor).abs() > 1.0e-7 * (1.0 + anchor.abs()) {
      rank = i + 1
      anchor = rows[i].score
    }
    rows[i] = { ..rows[i], rank, }
  }
  if rows.length() == 0 {
    Ok({ rows, failures, mean: None, minimum: None, maximum: None, })
  } else {
    Ok({
      rows,
      failures,
      mean: Some(total / rows.length().to_double()),
      minimum: Some(rows[rows.length() - 1].score),
      maximum: Some(rows[0].score),
    })
  }
}

///|
pub fn ScoreSummary::to_json(self : ScoreSummary) -> Json {
  let rows = self.rows.map(fn(r) {
    Json::object({
      "unit": Json::string(r.unit),
      "rank": Json(r.rank),
      "score": Json::number(r.score),
      "factor": Json::number(r.factor),
    })
  })
  Json::object({
    "rows": Json::array(rows),
    "failures": Json(self.failures),
    "mean": Json(self.mean),
    "minimum": Json(self.minimum),
    "maximum": Json(self.maximum),
  })
}

///|
/// Report serializes every row status; an all-failed run has null, never zero, statistics.
pub fn benchmark_report(
  data : Dataset,
  reference : Dataset,
  returns : Returns,
  output~ : Bool = false,
  refine~ : Bool = true,
  budget~ : Int32 = 10000,
) -> Result[Json, DeaError] {
  let results = evaluate(data, reference, returns, output~, refine~, budget~)
  let summary = match summarize(results, output~) {
    Ok(v) => v
    Err(e) => return Err(e)
  }
  let rows = results.map(fn(r) {
    match r {
      Ok(v) => v.to_json()
      Err(e) => e.to_json()
    }
  })
  let technology = match returns {
    CRS => "CRS"
    VRS => "VRS"
    NIRS => "NIRS"
    NDRS => "NDRS"
  }
  Ok(
    Json::object({
      "schema": Json::number(1.0),
      "orientation": Json::string(if output { "output" } else { "input" }),
      "returns": Json::string(technology),
      "summary": summary.to_json(),
      "results": Json::array(rows),
    }),
  )
}
