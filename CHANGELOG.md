# Changelog

所有对 `jia_pu_widget` 库的重大更改都将记录在此文件中。

## [1.0.0] - 2025-07-17

### 新增
- **初始版本发布**：推出了 `jia_pu_widget`，一个用于在 Flutter 应用中展示家谱树的 widget。
- **核心功能**：
  - 支持通过 `JiaPuWidget` 显示多代家谱树，基于 `JiaPuMember` 数据模型。
  - 提供可定制的样式配置，通过 `JiaPuStyles` 类定义节点宽度、间距、层间距、背景颜色等。
  - 包含示例家谱数据（`buildStaticFamilyTree`），展示多代家族结构。
- **UI 特性**：
  - 提供 `nodeBuilder` 和 `generationLabelBuilder` 函数，允许用户自定义节点和世代标签的渲染方式。
  - 支持动态调整家谱树的布局参数（如节点宽度、高度、间距等）。
- **示例应用**：
  - 包含 `example/main.dart`，展示如何使用 `JiaPuWidget` 渲染家谱树。
- **测试支持**：
  - 提供单元测试和 widget 测试（`test/jia_pu_page_test.dart`），验证家谱树数据结构和 UI 渲染。

### 已知限制
- 当前版本仅支持静态家谱数据，暂不支持动态编辑或交互功能。
- 家谱树的渲染性能可能在超大规模家族数据下需要优化。

### 备注
- 这是 `jia_pu_widget` 的第一个正式版本，欢迎用户反馈以改进后续版本。
- 请参阅 `README.md` 获取更多使用说明和配置详情。