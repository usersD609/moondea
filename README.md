# MoonDEA：可复现的数据包络分析

MoonDEA 将可比较单位的投入、产出矩阵转为径向效率、参考同伴和改进目标，并支持跨期生产率与参考集敏感性分析。面向分支运营分析人员、嵌入效率分析的数据平台作者、跨期研究者。核心计算、格式校验和报告均由 MoonBit 实现，无 Python、网络服务或本机求解器运行时依赖。

模块：`usersD609/moondea@0.1.0`。MIT 许可证。结果是相对于选定参考集的描述性效率，不能解释为因果关系或统计显著性。

## 已实现功能

- 投入收缩与产出扩张：CRS（CCR）、VRS（BCC）、NIRS、NDRS；评估集可与参考集不同。
- 固定径向最优值的第二阶段松弛量优化；同伴权重、原单位投影、松弛量、残差与强效率。
- 单位无关的归一化加性模型，以及指定投入/产出方向的方向距离。
- 排除自身的超效率、CRS/VRS 规模分解、逐参考单位剔除敏感性。
- 同名单位对齐的两期 CRS 投入型 Malmquist 指数、滚动参考窗口。
- 严格 CSV、版本化 JSON 快照、七种操作的 JSON 请求接口、显式失败与排名报告。
- 重复观测与列动态范围诊断，显式计量单位换算。

当前不提供零/负数据、非期望产出、网络/动态 DEA、权重限制、随机前沿、bootstrap、大规模稀疏求解或图形界面。

## 环境与安装

开发和 CI 固定官方 `moonc v0.10.18+6c83a7f62`、`moon 0.1.20261028`，满足 `moonc >=0.10.16`。使用官方 MoonBit 工具链并以 `moon version --all` 核对。支持 wasm-gc、wasm、js、native。JS 需要 Node.js；native 需要平台 C 工具链，Windows 需要 MSVC C++ 工具和 Windows SDK。

在新消费项目添加精确版本：

```sh
moon new dea-consumer
cd dea-consumer
moon add usersD609/moondea@0.1.0
```

消费主包的 `moon.pkg`：

```moonbit
import { "usersD609/moondea" @dea }
options("is-main": true)
```

消费主文件：

```moonbit
///|
fn main {
  let data = @dea.Dataset::new(
    ["A", "B"], [[1.0], [2.0]], [[1.0], [1.0]],
  ).unwrap()
  let result = @dea.input_crs(data, 1, data).unwrap()
  println(result.factor) // 0.5
  println(result.to_json().stringify())
}
```

现代模板的主包通常是 `cmd/main`；替换该包主文件后 `moon run cmd/main`。示例为简洁使用 unwrap；业务代码应匹配 Ok/Err。

## 三个可复现的完整工作流

```sh
git clone https://github.com/usersD609/moondea.git
cd moondea
moon run examples/operations
moon run examples/integration
moon run examples/research
```

1. **运营分析**：读取三区域工时、面积、服务量 CSV，预检范围，计算 CRS 同伴目标并导出排名和完整 JSON。operations 内断言西区效率 0.5、目标工时不超过 2。
2. **数据平台**：CSV 转 JSON 快照，再构造严格 radial 请求得到机器可读结果；错误 schema 返回 invalid。integration 同时验证成功和拒绝路径，无须服务器。
3. **跨期研究**：两期投入减半且名称顺序不同；对齐后生产率指数为 2，分析逐参考单位剔除影响，再构造四观测滚动窗口。research 验证结果后输出。

以上均为独立合成数据，不声称来自真实企业。

## 数据与模型约定

Dataset::new 深复制数据；getter 返回副本。允许 1..128 观测、各 1..16 投入/产出，所有数据有限且严格为正，范围 `[1e-9,1e9]`。名称唯一、非空、最多 128 UTF-16 code units。评估和参考集的列顺序、含义和计量单位须一致；库校验维度，业务负责语义可比。

每次按目标行与参考集的列最大值缩放，任一列动态范围超过 1e6 即拒绝。方向为 [0,1] 的相对比例，至少一个非零；非零分量乘缩放后评估值低于 1e-8 时拒绝，防止低于 pivot 精度。

投入模型最小化 theta：`Xλ <= theta*x0, Yλ >= y0`。产出模型最大化 phi：`Xλ <= x0, Yλ >= phi*y0`。λ 非负；VRS 加 sum λ=1，NIRS 加 sum λ<=1，NDRS 加 sum λ>=1。投入分数 theta，产出分数 1/phi；同参考集通常在 (0,1]，跨参考/超效率不适用此范围。

RadialResult.factor 始终为原始 theta 或 phi。同伴投影 Xλ、Yλ 保持原单位；松弛相对于径向目标。radial_refined 最大化归一化松弛总和；strongly_efficient 应用于精化结果。同伴分解和多重最优目标不唯一，不承诺与其他求解器逐权重一致。

|任务|主要 API|
|---|---|
|径向/二阶段/批量|input_radial、output_radial、radial_refined、evaluate|
|加性/方向改善|additive、directional|
|超效率/规模分解|super_efficiency、scale_efficiency|
|跨期/影响/窗口|malmquist、sensitivity、rolling_windows|
|诊断与报告|diagnose、benchmark_report|

规模分解为 theta_CRS = scale_efficiency * theta_VRS。Malmquist 用 CRS 投入因子，theta_ab 表示 a 期观测对 b 期技术：`M=sqrt((theta10/theta00)*(theta11/theta01))`，大于 1 为该约定下进步；`EC=theta11/theta00`，`TC=sqrt((theta10/theta11)*(theta00/theta01))`，M=EC*TC。两期必须同名同规模，可换行顺序。

sensitivity 的范围包括基线及成功剔除项，失败另列；不是置信区间。rolling_windows 使用包含当期的尾随窗口；不是动态技术模型。超效率及异参考模型可能不可行。

## CSV 和 JSON 接口

CSV 首列 unit，接连续 input:变量名，再接连续 output:变量名，变量名称全表唯一。支持 Unicode、引号转义、字段内换行、LF/CRLF；拒绝裸 CR 和结束引号后多余字符。数值使用 JSON 十进制语法，不接受 NaN、Infinity、空值或千分位。文本最多 262144 code units、含表头129条记录、33列、字段8192字符。

```csv
unit,input:成本,output:服务
东区,2,1
西区,4,1
```

read_csv / PanelTable::to_csv 和 read_json / PanelTable::to_json 保持数据往返，不保留 CSV 原空格/引号格式。JSON 快照：

```json
{"schema":1,"names":["A","B"],"inputs":[[1],[2]],"outputs":[[1],[1]],"input_names":["成本"],"output_names":["服务"]}
```

execute_request / respond 接收以下请求；data 为完整快照，不能是文件路径：

```json
{"schema":1,"operation":"radial","data":{"schema":1,"names":["A","B"],"inputs":[[1],[2]],"outputs":[[1],[1]],"input_names":["成本"],"output_names":["服务"]},"unit":1,"returns":"VRS","orientation":"input","refine":true,"budget":10000}
```

|operation|可选参数（均可指定 budget）|额外必需字段|
|---|---|---|
|benchmark|reference、returns、orientation、refine|无，遍历全部单位|
|radial|reference、returns、orientation、refine|unit|
|additive|reference、returns|unit|
|directional|reference、returns|unit、gx、gy|
|super|returns、orientation|unit|
|scale|无|unit|
|productivity|无|unit、after 快照|

默认 CRS、input、refine=true、reference=data。每种操作拒绝不能履行的字段。JSON 限长262144 code units、深度8，拒绝重复键、未知键和未来 schema。unit 从0起，budget 为0..50000整数，默认10000。径向精化两阶段共享预算；批量/跨期/敏感性按每次模型求解适用预算。

错误码为 invalid、infeasible、unbounded、iteration_limit、numerical。respond 将错误转 JSON。benchmark 的顶层成功仍可能含失败行，须检查 summary.failures 和每行 status；全部失败时 mean/minimum/maximum 为 null。失败不参与排名，成功按分数降序竞争排名，同分容差 `1e-7*(1+abs(anchor))`，同分保持评估顺序。

## 验证与数值边界

```sh
moon version --all
moon info
moon fmt --check
moon check --deny-warn
moon test --deny-warn
moon build --deny-warn
python tools/audit_source.py
```

对 wasm-gc、wasm、js、native 分别追加 `--target <target>`。CI 在四后端运行检查、测试、构建、三个场景、接口及格式验证。目前 **58项测试**，其中32个固定种子独立合成面板、**512个 SciPy/HiGHS 最优值**，比较四种规模技术下的投入、产出、加性和方向模型，容差 `1e-6*(1+abs(expected))`，不比较非唯一权重。

独立重算：Python3.9+，`python -m pip install scipy==1.14.1` 后 `python tools/generate_oracles.py`，再 moon fmt 和 moon test。本地最初生成使用 SciPy1.9.1；CI以1.14.1重算并按1e-7相对/绝对容差比较保存值。Python/SciPy 不是运行时依赖。另有解析算例、尺度/置换不变量、最大维度、冗余约束、预算及格式错误回归。

内部两阶段单纯形采用双精度、Bland选择和迭代上限，原始约束及投影独立验算。原约束尺度容差1e-7、投影相对容差1e-6；不是精确算术证明或条件数保证。病态输入可能返回 Numerical/IterationLimit。没有性能或统计覆盖率百分比的承诺。

方法和结构见 [architecture.md](docs/architecture.md)，公共接口见 [pkg.generated.mbti](pkg.generated.mbti)，选题比较见 [duplicate-check.md](docs/competition/duplicate-check.md)，验收门禁见 [acceptance.md](docs/competition/acceptance.md)。

## 许可、参考与 AI

[LICENSE](LICENSE) 为 MIT；[NOTICE.md](NOTICE.md) 说明来源；[AI-USE.md](AI-USE.md) 披露 AI 使用。参考 DataEnvelopmentAnalysis.jl（MIT）的数学功能语义，未复制代码、文档或数据，不是全量移植。运行时仅依赖 MoonBit core 标准库。AI 辅助设计、实现、测试和文档；自验不等于赛事组正式验收。
