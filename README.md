# 家谱部件 (JiaPu Widget)

`jia_pu_widget` 是一个 Flutter 部件，用于渲染中国家谱图，支持无限世代和每世无限人数，节点和世代标签可完全自定义，适用于展示复杂的家族关系。

![家谱全览](screenshots/family_tree_overview.png)

## 功能特性

- **无限世代与人数**：支持任意世代深度和每世任意人数，节点布局自动调整，无重叠。
- **自定义节点与标签**：通过 `nodeBuilder` 和 `generationLabelBuilder` 自定义节点（姓名、配偶、排行）和世代标签样式。
- **节点交互支持**：节点为用户自定义 `Widget`，支持点击、长按等交互事件，增强用户体验。
- **内置滚动**：支持左右和上下滚动，适配大型家谱。
- **交互支持**：配合外部 `InteractiveViewer` 实现缩放和拖动，适合移动和桌面设备。
- **跨平台支持**：兼容 Android、iOS、Web、Windows、macOS、Linux。

## 安装

在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  jia_pu_widget: ^1.0.0
```

运行以下命令安装：

```bash
flutter pub get
```

## 使用示例

以下是一个简单家谱示例，展示如何使用 `JiaPuWidget` 并为节点添加点击事件：

```dart
import 'package:flutter/material.dart';
import 'package:jia_pu_widget/jia_pu_widget.dart';
import 'package:jia_pu_widget/models/jia_pu_member.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: JiaPuPage());
  }
}

class JiaPuPage extends StatelessWidget {
  const JiaPuPage({Key? key}) : super(key: key);

  JiaPuMember buildFamilyTree() {
    return JiaPuMember(
      name: '张文博',
      spouse: '李丽华',
      order: '长子',
      children: [
        JiaPuMember(
          name: '张志远',
          spouse: '王芳',
          order: '长子',
          children: [
            JiaPuMember(name: '张明辉', spouse: '', order: '长子'),
            JiaPuMember(name: '张静怡', spouse: '', order: '长女'),
          ],
        ),
        JiaPuMember(name: '张丽芳', spouse: '', order: '长女'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final root = buildFamilyTree();
    return Scaffold(
      appBar: AppBar(title: const Text('家谱')),
      body: Container(
        color: const Color(0xFFF6F6F6),
        child: InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(20.0),
          minScale: 0.5,
          maxScale: 2.0,
          child: JiaPuWidget(
            root: root,
            nodeBuilder: (member) => GestureDetector(
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('点击了 ${member.name}')),
              ),
              child: Container(
                width: 75.0,
                height: 72.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(member.order, style: const TextStyle(fontSize: 12)),
                    Text(member.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(member.spouse, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
            ),
            generationLabelBuilder: (gen) => Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.white,
              ),
              child: Text('$gen\n世', style: const TextStyle(fontSize: 14)),
            ),
            nodeWidth: 75.0,
            nodeSpacing: 32.0,
            nodeHeight: 72.0,
            layerSpacing: 24.0,
            generationLabelOffsetX: 12.0,
            startX: 74.0,
            startY: 12.0,
          ),
        ),
      ),
    );
  }
}
```

更多复杂样式和大型家谱示例，请查看 [`example/main.dart`](./example/main.dart)。

## 快速开始

1. 使用 `JiaPuMember` 定义家谱数据（姓名、配偶、排行、子节点）。
2. 将 `JiaPuWidget` 嵌入 Flutter 应用，自定义节点和世代标签样式。
3. 为节点添加交互事件（如点击、长按），通过 `GestureDetector` 或其他交互部件。
4. 可选：使用 `InteractiveViewer` 包裹 `JiaPuWidget` 以支持缩放和拖动。
5. 运行应用，查看家谱效果。

## 平台支持

- **已支持**：Android、iOS、Web、Windows、macOS、Linux。

## 贡献

欢迎提交问题和拉取请求！请访问 [GitHub 仓库](https://github.com/gy-8/jia_pu_widget)。

## 许可证

MIT License