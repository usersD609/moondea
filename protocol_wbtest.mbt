///|
test "request dispatch validates operation fields and executes every operation" {
  let table = read_csv("unit,input:x,output:y\nA,1,1\nB,2,1").unwrap()
  for
    op in [
      "radial", "additive", "directional", "super", "scale", "productivity",
    ] {
    let request = {
      "schema": Json(1),
      "operation": Json(op),
      "data": table.to_json(),
      "unit": Json(1),
    }
    if op == "directional" {
      request["gx"] = Json([1.0])
      request["gy"] = Json([0.0])
    }
    if op == "productivity" {
      request["after"] = table.to_json()
    }
    assert_true(execute_request(Json::object(request).stringify()) is Ok(_))
  }
  let base = {
    "schema": Json(1),
    "operation": Json("benchmark"),
    "data": table.to_json(),
  }
  assert_true(execute_request(Json::object(base).stringify()) is Ok(_))
  base["unit"] = Json(0)
  assert_true(execute_request(Json::object(base).stringify()) is Err(_))
  base["operation"] = Json("radial")
  base["unit"] = Json(0.5)
  assert_true(execute_request(Json::object(base).stringify()) is Err(_))
  base["unit"] = Json(0)
  base["budget"] = Json(-1)
  assert_true(execute_request(Json::object(base).stringify()) is Err(_))
  assert_true(respond("{}").contains("invalid"))
}
