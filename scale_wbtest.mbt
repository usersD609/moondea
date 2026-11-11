///|
test "scale inefficiency separates from pure technical inefficiency" {
  let d = Dataset::new(["small", "large", "poor"], [[1.0], [3.0], [4.0]], [
    [1.0],
    [2.0],
    [2.0],
  ]).unwrap()
  let s = scale_efficiency(d, 1).unwrap()
  near(s.crs_efficiency, 2.0 / 3.0)
  near(s.vrs_efficiency, 1.0)
  near(s.scale_efficiency, 2.0 / 3.0)
  let poor = scale_efficiency(d, 2).unwrap()
  near(poor.vrs_efficiency, 0.75)
  near(poor.crs_efficiency, poor.scale_efficiency * poor.vrs_efficiency)
}
