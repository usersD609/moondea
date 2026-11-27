///|
test "reports rank successful rows and keep failure statistics nullable" {
  let d = Dataset::new(["A", "B", "C"], [[1.0], [2.0], [1.0]], [
    [1.0],
    [1.0],
    [1.0],
  ]).unwrap()
  let s = summarize(evaluate(d, d, CRS)).unwrap()
  assert_eq(s.rows.map(fn(r) { r.unit }), ["A", "C", "B"])
  assert_eq(s.rows.map(fn(r) { r.rank }), [1, 1, 3])
  near(s.mean.unwrap(), 2.5 / 3.0)
  let failed = summarize(evaluate(d, d, CRS, budget=0)).unwrap()
  assert_eq(failed.failures, 3)
  assert_eq(failed.mean, None)
  assert_true(failed.to_json().stringify().contains("null"))
  let out = summarize(evaluate(d, d, CRS, output=true), output=true).unwrap()
  near(out.rows[2].score, 0.5)
  let report = benchmark_report(d, d, CRS).unwrap()
  assert_true(@json.valid(report.stringify()[:]))
  assert_eq(DeaError::IterationLimit.code(), "iteration_limit")
}

///|
test "report statistics serialize as numeric scalars or null through public request" {
  let table = read_csv("unit,input:x,output:y\nA,1,1\nB,2,1\n").unwrap()
  let request = Json::object({
    "schema": Json::number(1.0),
    "operation": Json::string("benchmark"),
    "data": table.to_json(),
  })
  let check = fn(j : Json, failed : Bool) raise {
    match j {
      Object(o) =>
        match o["summary"] {
          Object(s) => {
            for name in ["mean", "minimum", "maximum"] {
              if failed {
                assert_true(s[name] is Null)
              } else {
                assert_true(s[name] is Number(_))
              }
            }
            if !failed {
              match s["mean"] {
                Number(v, ..) => near(v, 0.75)
                _ => fail("mean must be scalar")
              }
            }
          }
          _ => fail("summary must be object")
        }
      _ => fail("report must be object")
    }
  }
  check(execute_request(request.stringify()).unwrap(), false)
  let failed = benchmark_report(table.dataset(), table.dataset(), CRS, budget=0).unwrap()
  check(failed, true)
}
