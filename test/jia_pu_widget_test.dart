import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jia_pu_widget/jia_pu_widget.dart';
import 'package:jia_pu_widget/models/jia_pu_member.dart';

import '../example/jia_pu_styles.dart';
import '../example/main.dart';


void main() {
  // 测试 JiaPuPage 的 widget 渲染
  group('JiaPuPage Widget Tests', () {
    testWidgets('JiaPuPage renders correctly with AppBar and JiaPuWidget', (WidgetTester tester) async {
      // 构建 JiaPuPage
      await tester.pumpWidget(const MaterialApp(home: JiaPuPage()));

      // 验证 AppBar 是否渲染并包含标题“家谱”
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('家谱'), findsOneWidget);

      // 验证 JiaPuWidget 是否渲染
      expect(find.byType(JiaPuWidget), findsOneWidget);

      // 验证 Scaffold 是否存在
      expect(find.byType(Scaffold), findsOneWidget);

      // 验证 Stack 中的 Container 是否存在并有正确的背景颜色
      final containerFinder = find.descendant(
        of: find.byType(Stack),
        matching: find.byWidgetPredicate(
              (widget) => widget is Container && widget.color == Colors.white,
        ),
      );
      expect(containerFinder, findsOneWidget);
    });

    testWidgets('JiaPuWidget receives correct root and styling properties', (WidgetTester tester) async {
      // 构建 JiaPuPage
      await tester.pumpWidget(const MaterialApp(home: JiaPuPage()));

      // 获取 JiaPuWidget
      final jiaPuWidget = tester.widget<JiaPuWidget>(find.byType(JiaPuWidget));

      // 验证 JiaPuWidget 的属性
      expect(jiaPuWidget.nodeWidth, JiaPuStyles.nodeWidth);
      expect(jiaPuWidget.nodeSpacing, JiaPuStyles.nodeSpacing);
      expect(jiaPuWidget.nodeHeight, JiaPuStyles.nodeHeight);
      expect(jiaPuWidget.layerSpacing, JiaPuStyles.layerSpacing);
      expect(jiaPuWidget.generationLabelOffsetX, JiaPuStyles.generationLabelOffsetX);
      expect(jiaPuWidget.startX, JiaPuStyles.startX);
      expect(jiaPuWidget.startY, JiaPuStyles.startY);
      expect(jiaPuWidget.backgroundColor, const Color(0x2D000000));
    });
  });

  // 测试 buildStaticFamilyTree 方法
  group('buildStaticFamilyTree Tests', () {
    test('buildStaticFamilyTree creates correct family tree structure', () {
      final jiaPuPage = JiaPuPage();
      final root = jiaPuPage.buildStaticFamilyTree();

      // 验证第一世
      expect(root.name, '张文博');
      expect(root.spouse, '李丽华');
      expect(root.order, '长子');
      expect(root.children.length, 4);

      // 验证第二世（张志远）
      final gen2 = root.children[0];
      expect(gen2.name, '张志远');
      expect(gen2.spouse, '王芳');
      expect(gen2.order, '长子');
      expect(gen2.children.length, 3);

      // 验证第三世（张明辉）
      final gen3 = gen2.children[0];
      expect(gen3.name, '张明辉');
      expect(gen3.spouse, '');
      expect(gen3.order, '长子');
      expect(gen3.children.length, 2);

      // 验证第四世（张浩然）
      final gen4 = gen3.children[0];
      expect(gen4.name, '张浩然');
      expect(gen4.spouse, '刘静');
      expect(gen4.order, '长子');
      expect(gen4.children.length, 2);
    });
  });
}