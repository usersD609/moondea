# 验收门禁（0.1.0）

本表为项目自验映射，不是赛事组通过通知。CI 和发布须核对平台实际记录。

|验收项|入口|
|---|---|
|MoonBit 为主、moonc>=0.10.16|16个生产 .mbt；固定 v0.10.18+6c83a7f62，CI 核对版本|
|公开仓库和清晰历史|usersD609/moondea，真实逐功能提交|
|核心功能|数据、径向、加性、方向、跨期及参考集模块|
|中文说明|根 README.md：精确版本、安装、API、协议、三个场景及边界|
|CI 检查/构建/测试|四目标矩阵与独立 oracle 重算|
|可运行样例|examples/operations、integration、research，含结果断言|
|核心测试|58测试，含512独立 HiGHS 目标值、错误/不变量/上限回归|
|MoonCakes|usersD609/moondea@0.1.0；发布后验公开元数据、包内容和无凭据新消费项目|
|OSI 开源和来源|MIT LICENSE、NOTICE.md、AI-USE.md|

`python tools/audit_source.py` 排除测试、示例、生成接口、Python、文档及配置，实测2135物理行生产 MoonBit，其中1501行含实质字母/数字且非空非注释。有效工程提交在本地报告逐 SHA 保守审计，纯文档和后续微修补不冒充算法工作量。

发布前验最终接口、严格四后端命令、三个流程、独立目标值、隐私扫描 Git 历史和真实归档、双平台服务端身份、默认分支真实 CI。Windows 缺 MSVC 的本机 native 限制如实记录，native 执行由 Linux CI 提供。

完整交付报告和中文申报材料在仓库之外，均不作为公开归档附件。
