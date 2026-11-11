# 选题与语义查重（2026-11-11）

## 需求、三个候选与选择

|候选领域|真实成熟依据|具体任务与用户|需求/复用/深度/验证/维护（各5）|硬门禁|
|---|---|---|---|---|
|数据包络分析 MoonDEA|[DataEnvelopmentAnalysis.jl](https://github.com/javierbarbero/DataEnvelopmentAnalysis.jl)，MIT，已查看 radial 模型源与测试|分支运营分析、数据平台嵌入、跨期研究：投入/产出矩阵转为效率、同伴投影和跨期分解|5/5/5/5/4|通过已记录范围查重，选中|
|湿空气 HVAC|[energybalance](https://github.com/liying-han/moonbit-energybalance) 0.2.3|暖通工程、设备选型、能耗分析|5/4/4/4/4|淘汰：实际 psychrometrics.mbt、reports/tests 已覆盖|
|疲劳雨流计数|[fatigue-spectrum](https://github.com/gckbbrant/fatigue-spectrum)|机械可靠性、结构分析、传感数据处理|5/4/4/5/4|淘汰：rainflow.mbt、damage 和测试为直接替代|

未提供参赛者从业背景；需求依据是成熟跨生态工作流，不冒充用户访谈。优先实现投入/产出径向 CRS/VRS、参考集、同伴/松弛/诊断、可比较跨期分析与可嵌入数据接口；不从通用 LP 库换名包装。全部源码在独立目录新写。

## 实际执行的检索

已阅读并执行安装的 osc2026-guide 的 Project Research Guide；比赛规则采用 builder 固定九月要求及本对话验收要求，未切换为八月赛事。

`moon search <keyword> --limit 100`：envelopment、DataEnvelopment、CCR、BCC、DEA、frontier、efficiency、data envelopment、rainflow、fatigue、psychrometric。DEA79项、frontier15项、efficiency58项（以原始保存结果为准）；fuzzy 同字片段命中不是功能证据。rainflow 零包命中但 GitHub 找到直接替代，已淘汰。

GitHub repository/code `per_page=100`，语言 MoonBit：DataEnvelopmentAnalysis、data envelopment、DEA+efficiency、BCC+CCR、data_envelopment、radial_efficiency、dea_radial、数据包络、benchmarking+efficiency、peer_weights；精确主行为标识未命中直接实现；宽词命中 core/BioSeqs/games 等噪声。返回 incomplete_results=false 的单页结果未超过100；不把 GitHub 搜索当全网证明。psychrometric/rainflow/fatigue/linear programming/MDP/simulation 同样调查，后两方向有直接现成实现，不进入开发。

[官方 awesome-moonbit](https://github.com/moonbitlang/awesome-moonbit) 完整 README 经 GitHub API读取；raw 下载失败记录保留，非假定通过。MoonCakes 文档实际读取：Freon793/moonopt、Luna-Flow/linear-program、liying-han/moonbit-energybalance、gckbbrant/fatigue-spectrum。网页存在不等于发布了对应版本；其源与接口另行核对。

## 相邻能力矩阵与独立必要性

|项目|实际查看|重叠与边界|
|---|---|---|
|Freon793/moonopt 0.6.0|README、model/pkg.generated.mbti、simplex/result、certificate、differential tests|通用LP/MIP建模与求解，不是 DMU 队列、多模型参考集与跨期效率解释；不竞争通用求解器API|
|Luna-Flow/linear-program|README、src约束/基础源、tree|通用LP；README声明已知缺陷、尚未以命名空间发布；不是DEA工作流|
|energybalance 0.2.3|psychrometrics.mbt、psychrometric_reports、analysis_test|直接替代被淘汰 HVAC 候选|
|fatigue-spectrum|rainflow.mbt、rainflow_test、damage_test|直接替代被淘汰疲劳候选|
|MoonQP / MoonOT|永久注册表完整能力指纹、外部邻居记录|约束二次规划/熵正则运输；目标、输入、输出均不等同DEA|
|MoonChoice / MoonQueueLab / MoonCoDA|永久注册表完整指纹|离散选择、排队容量、成分数据几何；不借其源码或仓库|

扩展通用 LP 求解器只能解决基础最优化，不能替代完整 DEA 数据契约、模型构造、同伴投影、尺度与跨期分析；以专门模块独立交付有可复用的用户入口。内部求解器限有界稠密DEA模型，不导出为另一套通用LP产品。

## 许可与验收计划

数学模型独立实现，参考 DataEnvelopmentAnalysis.jl（MIT）的功能语义；未复制实现、文档或测试数据。使用独立合成数据和 SciPy/HiGHS 外部求解器对照、解析小例与尺度/置换不变量。准确报告未收敛、不适用和数值错误，不把不可解状态写成效率。至少三个可运行场景；正式发布前再次反向查重。

## 结论与限制

永久注册表在独占锁内重读，2026-11-11 原子预留。已记录检索范围内未发现成熟维护的直接DEA替代；不是绝对唯一性保证，不是组委会裁决。搜索索引、语言识别、网页缓存与未索引私有/新项目均存在限制；如发现不确定直接替代，先核对并停止受影响实施。

## 发布前反向复核

2026-11-11 实施后再次执行扩大限额的 DEA、frontier、efficiency、envelopment MoonCakes 检索；GitHub code 对 envelopment、Malmquist、radial_efficiency、data envelopment、peer_weights 再查。精确查询返回0、incomplete_results=false；未发现新增直接替代。含空格/引号的首次命令被CLI参数解析拒绝，改为URL编码查询后实际成功，不把失败当零结果。已交付三个场景及四类模型独立对照；结论仍仅适用于记录范围，非绝对唯一性或官方审核。
