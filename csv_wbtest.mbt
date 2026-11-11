///|
test "typed CSV roundtrip quotes Unicode commas newlines and CRLF" {
  let text = "unit,input:成本,output:产量\r\n\"东,区\",2,1\r\n\"西\"\"区\n分部\",4,1\r\n"
  let table = read_csv(text).unwrap()
  assert_eq(table.dataset().names()[0], "东,区")
  assert_eq(table.dataset().names()[1], "西\"区\n分部")
  let restored = read_csv(table.to_csv()).unwrap()
  assert_eq(restored.input_names(), ["成本"])
  assert_eq(restored.dataset().names(), table.dataset().names())
  near(
    input_crs(restored.dataset(), 1, restored.dataset()).unwrap().factor,
    0.5,
  )
}

///|
test "CSV rejects malformed quoting headers values and records" {
  for
    s in [
      "", "unit,input:x,output:y\nA,1", "unit,input:x,output:y\nA,NaN,1", "unit,input:x,output:y\nA,0,1",
      "unit,input:x,output:y\n\"A\"z,1,1", "unit,input:x,output:y\n\"A,1,1", "unit,output:y,input:x\nA,1,1",
      "unit,input:x,output:x\nA,1,1", "unit,input:x,output:y\rA,1,1", "unit,input:x,output:y\nA,1,1\n\n",
    ] {
    assert_true(read_csv(s) is Err(_))
  }
}
