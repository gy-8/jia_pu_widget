// example/main.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jia_pu_widget/jia_pu_widget.dart';
import 'package:jia_pu_widget/models/jia_pu_member.dart';

import 'jia_pu_styles.dart';

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
  const JiaPuPage({super.key});

  JiaPuMember generateFamilyTree(
    int generation,
    int maxGenerations,
    int maxChildren,
  ) {
    const orders = ['长子', '次子', '三子', '四子', '五子', '六子', '七子', '八子', '九子', '十子'];
    const femaleOrders = [
      '长女',
      '次女',
      '三女',
      '四女',
      '五女',
      '六女',
      '七女',
      '八女',
      '九女',
      '十女',
    ];
    final random = Random();

    final isMale = random.nextBool();
    final orderList = isMale ? orders : femaleOrders;

    final name = '张$generation${random.nextInt(1000)}';
    final spouse = random.nextBool()
        ? '李$generation${random.nextInt(1000)}'
        : '';
    final order = orderList[random.nextInt(orderList.length)];

    if (generation >= maxGenerations) {
      return JiaPuMember(
        name: name,
        spouse: spouse,
        order: order,
        children: [],
      );
    }

    final childCount = random.nextInt(maxChildren) + 1;
    final children = <JiaPuMember>[];
    for (int i = 0; i < childCount && i < maxChildren; i++) {
      children.add(
        generateFamilyTree(generation + 1, maxGenerations, maxChildren),
      );
    }

    return JiaPuMember(
      name: name,
      spouse: spouse,
      order: order,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    final root = generateFamilyTree(1, 1, 10);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '家谱',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: JiaPuStyles.treeBackgroundColor,
        child: JiaPuWidget(
          root: root,
          generationLabelBuilder: JiaPuStyles.buildGenerationLabel,
          nodeBuilder: JiaPuStyles.buildNode,
          nodeWidth: JiaPuStyles.nodeWidth,
          nodeSpacing: JiaPuStyles.nodeSpacing,
          nodeHeight: JiaPuStyles.nodeHeight,
          layerSpacing: JiaPuStyles.layerSpacing,
          generationLabelOffsetX: JiaPuStyles.generationLabelOffsetX,
          startX: JiaPuStyles.startX,
          startY: JiaPuStyles.startY,
        ),
      ),
    );
  }
}
