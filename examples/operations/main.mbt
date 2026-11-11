///|
fn main {
  let csv = "unit,input:工时,input:面积,output:服务量\n东区,2,4,1\n西区,4,8,1\n南区,4,6,2\n"
  let table = @dea.read_csv(csv).unwrap()
  let data = table.dataset()
  let diagnostics = @dea.diagnose(data)
  assert_true(diagnostics.within_solver_range) catch {
    _ => abort("preflight failed")
  }
  let results = @dea.evaluate(data, data, @dea.CRS)
  let summary = @dea.summarize(results).unwrap()
  let west = results[1].unwrap()
  assert_true((west.factor - 0.5).abs() < 1.0e-6) catch {
    _ => abort("unexpected efficiency")
  }
  assert_true(west.projected_inputs[0] <= 2.0 + 1.0e-6) catch {
    _ => abort("invalid target")
  }
  println("operations: units=3; west theta=0.5; best rank=1")
  println(summary.to_json().stringify())
  println(@dea.benchmark_report(data, data, @dea.CRS).unwrap().stringify())
}
