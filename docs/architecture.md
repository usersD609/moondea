# 结构、方法与维护

数据通路：CSV/JSON → 不可变 Dataset → 列缩放 → DEA 约束 → 内部两阶段 tableau → 原约束/目标/投影验算 → 结果 → 报告/JSON。

|文件|职责|
|---|---|
|dataset / diagnostics|数据契约、复制、选择、单位换算及预检|
|tableau|内部 max-LP、人工变量 Phase I、Phase II、Bland pivot、终止验算|
|radial / slacks|规模约束、两种径向方向、原单位投影及第二阶段|
|additive / directional|归一化加性增益与相对方向|
|batch / scale / influence|逐行状态、超效率、规模与参考影响|
|malmquist / windows|同名跨期距离与合并参考观测|
|csv / snapshot|格式状态机、资源限制与严格 schema|
|protocol / report|操作门禁、集成接口、状态/排名/汇总|
|tools/generate_oracles.py|独立构造矩阵与 SciPy/HiGHS 对照，不是运行时实现|

LP 只在模块内部提供能力。solve_linear 限192变量、96约束；公共 DEA 最多128同伴、32个投入/产出限制及两条规模限制，均在边界内。人工变量在可行阶段完成后不得保留正质量；Phase I 可行不代替 Phase II 最优。

第二阶段固定径向因子，最大化 sum(sx/x0)+sum(sy/y0)，两阶段共享预算。加性在原目标直接最大化同样归一化和。方向模型 beta>=0，约束 Xλ<=(1-beta*gx)x0、Yλ>=(1+beta*gy)y0，方向可有零分量但不全零。

浮点终止不是精确证书。模型/残差异常显式传播；多重最优时 peers 不具业务唯一性。对照仅验目标与可行性，不强制同伴相同。不使用 warm start 或共享可变缓存；外部数组不能改变 Dataset。

修改模型须同步独立 oracle、解析算例与不变量，修改协议须同步拒绝和往返测试，发布核对接口与四后端 CI。精确版本的新消费者安装属于发布后验证。
