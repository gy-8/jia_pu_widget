// test/jia_pu_widget_test.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jia_pu_widget/jia_pu_widget.dart';
import 'package:jia_pu_widget/models/jia_pu_member.dart';

import '../example/jia_pu_styles.dart';

void main() {
  JiaPuMember generateTestFamilyTree(
    int generation,
    int maxGenerations,
    int maxChildren,
  ) {
    const orders = ['长子', '次子', '三子'];
    const femaleOrders = ['长女', '次女', '三女'];
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
        generateTestFamilyTree(generation + 1, maxGenerations, maxChildren),
      );
    }

    return JiaPuMember(
      name: name,
      spouse: spouse,
      order: order,
      children: children,
    );
  }

  testWidgets('JiaPuWidget renders correctly with sample family data', (
    WidgetTester tester,
  ) async {
    final root = generateTestFamilyTree(1, 3, 3);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: JiaPuWidget(
            root: root,
            nodeBuilder: JiaPuStyles.buildNode,
            generationLabelBuilder: JiaPuStyles.buildGenerationLabel,
            nodeWidth: JiaPuStyles.nodeWidth,
            nodeSpacing: JiaPuStyles.nodeSpacing,
            nodeHeight: JiaPuStyles.nodeHeight,
            layerSpacing: JiaPuStyles.layerSpacing,
            generationLabelOffsetX: JiaPuStyles.generationLabelOffsetX,
            startX: JiaPuStyles.startX,
            startY: JiaPuStyles.startY,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(
      find.textContaining('张1'),
      findsOneWidget,
      reason: 'Should find first generation node name',
    );
    expect(
      find.textContaining('张2'),
      findsWidgets,
      reason: 'Should find second generation node names',
    );
    expect(
      find.textContaining('张3'),
      findsWidgets,
      reason: 'Should find third generation node names',
    );
    expect(
      find.textContaining('李'),
      findsWidgets,
      reason: 'Should find spouse names',
    );
    expect(
      find.textContaining(RegExp('长子|次子|三子|长女|次女|三女')),
      findsWidgets,
      reason: 'Should find order in multiple nodes',
    );

    expect(
      find.textContaining('一\n世'),
      findsOneWidget,
      reason: 'Should find first generation label',
    );
    expect(
      find.textContaining('二\n世'),
      findsOneWidget,
      reason: 'Should find second generation label',
    );
    expect(
      find.textContaining('三\n世'),
      findsOneWidget,
      reason: 'Should find third generation label',
    );

    // 验证节点不重叠
    final positionedWidgets = find.byType(Positioned).evaluate().toList();
    final positions = positionedWidgets
        .map((e) => (e.widget as Positioned).left)
        .toSet();
    expect(
      positions.length,
      positionedWidgets.length,
      reason: 'Nodes should have unique x positions',
    );
  });
}
