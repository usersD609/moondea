# 来源和许可证

MoonDEA 是独立编写的 MoonBit 实现，MIT，版权见 LICENSE。

功能对标为 javierbarbero/DataEnvelopmentAnalysis.jl（https://github.com/javierbarbero/DataEnvelopmentAnalysis.jl ，MIT）。阅读其径向源码与测试以核对数学语义；未复制其代码、文档、测试数据或可版权表达，不声称完整移植或上游认可。未覆盖其权重限制、网络/动态 DEA 等全部能力。

数学基线为 CCR/BCC 包络约束、归一化松弛目标、四距离 Malmquist 分解；公式和取向见 README。

MoonBit core（https://github.com/moonbitlang/core ，Apache-2.0）为工具链标准库，不将其 vendored 入仓库。

验证使用 SciPy/HiGHS（https://scipy.org/ ，SciPy BSD-3-Clause，HiGHS MIT），仅用于验证，不是运行依赖。面板为固定种子独立生成。GitHub Actions checkout/setup-python 按不可变提交引用，遵守其 MIT 许可，未复制实现。
