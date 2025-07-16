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