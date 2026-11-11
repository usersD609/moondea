///|
test "versioned JSON snapshots preserve exact arrays headers and row identities" {
  let t = read_csv("unit,input:成本,output:服务\nA,2,1\nB,4,1").unwrap()
  let r = read_json(t.to_json().stringify()).unwrap()
  assert_eq(r.dataset().inputs(), t.dataset().inputs())
  assert_eq(r.input_names(), t.input_names())
  assert_eq(r.to_csv(), t.to_csv())
}

///|
test "JSON rejects duplicate keys unknown fields wrong types and future schema" {
  let base = read_csv("unit,input:x,output:y\nA,1,1").unwrap().to_json()
  let obj = match base {
    Object(o) => o
    _ => abort("expected object")
  }
  obj["extra"] = Json::null()
  assert_true(read_json(Json::object(obj).stringify()) is Err(_))
  obj.remove("extra") |> ignore
  obj["schema"] = Json::number(2.0)
  assert_true(read_json(Json::object(obj).stringify()) is Err(_))
  assert_true(read_json("{\"schema\":1,\"schema\":1}") is Err(_))
  assert_true(read_json("null") is Err(_))
  assert_true(read_json("[[[[[[[[[0]]]]]]]]]") is Err(_))
}
