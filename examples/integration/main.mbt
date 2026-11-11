///|
fn main {
  let table = @dea.read_csv("unit,input:cost,output:service\nA,1,1\nB,2,1").unwrap()
  let snapshot = table.to_json().stringify()
  let restored = @dea.read_json(snapshot).unwrap()
  let request = Json::object({
    "schema": Json(1),
    "operation": Json("radial"),
    "data": restored.to_json(),
    "unit": Json(1),
    "returns": Json("VRS"),
    "orientation": Json("input"),
  })
  let response = @dea.execute_request(request.stringify()).unwrap()
  println("integration: CSV -> snapshot -> strict request -> JSON result")
  println(response.stringify())
  let rejected = @dea.respond(
    "{\"schema\":99,\"operation\":\"radial\",\"data\":{}}",
  )
  assert_true(rejected.contains("invalid")) catch {
    _ => abort("invalid request accepted")
  }
  println(rejected)
}
