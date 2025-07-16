// example/main.dart
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
  const JiaPuPage({Key? key}) : super(key: key);

  JiaPuMember buildStaticFamilyTree() {
    const orders = ['长子', '次子', '三子', '四子', '五子', '六子', '七子', '八子'];
    const femaleOrders = ['长女', '次女', '三女', '四女', '五女', '六女', '七女', '八女'];

    // 第 1 世
    final gen1 = JiaPuMember(
      name: '张文博',
      spouse: '李丽华',
      order: orders[0],
      children: [
        // 第 2 世
        JiaPuMember(
          name: '张志远',
          spouse: '王芳',
          order: orders[0],
          children: [
            // 第 3 世
            JiaPuMember(name: '张明辉', spouse: '', order: orders[0], children: [
              JiaPuMember(name: '张浩然', spouse: '刘静', order: orders[0], children: [
                JiaPuMember(name: '张子昂', spouse: '', order: orders[0], children: [
                  JiaPuMember(name: '张天宇', spouse: '陈怡', order: orders[0], children: [
                    JiaPuMember(name: '张睿哲', spouse: '', order: orders[0], children: [
                      JiaPuMember(name: '张博文', spouse: '孙悦', order: orders[0]),
                    ]),
                    JiaPuMember(name: '张睿杰', spouse: '赵琳', order: orders[1], children: [
                      JiaPuMember(name: '张雅雯', spouse: '', order: femaleOrders[0]),
                    ]),
                  ]),
                ]),
                JiaPuMember(name: '张子琪', spouse: '杨雪', order: orders[1], children: [
                  JiaPuMember(name: '张晨阳', spouse: '', order: orders[0], children: [
                    JiaPuMember(name: '张思远', spouse: '王娜', order: orders[0]),
                  ]),
                ]),
              ]),
              JiaPuMember(name: '张浩宇', spouse: '', order: orders[1], children: [
                JiaPuMember(name: '张若熙', spouse: '李芸', order: femaleOrders[0]),
              ]),
            ]),
            JiaPuMember(name: '张建华', spouse: '陈丽', order: orders[1], children: [
              JiaPuMember(name: '张晓峰', spouse: '', order: orders[0], children: [
                JiaPuMember(name: '张雨晨', spouse: '赵静', order: orders[0], children: [
                  JiaPuMember(name: '张梓萱', spouse: '', order: femaleOrders[0]),
                ]),
              ]),
              JiaPuMember(name: '张晓东', spouse: '刘颖', order: orders[1], children: [
                JiaPuMember(name: '张诗涵', spouse: '', order: femaleOrders[0]),
              ]),
            ]),
            JiaPuMember(name: '张静怡', spouse: '', order: femaleOrders[0], children: [
              JiaPuMember(name: '张欣怡', spouse: '杨帆', order: femaleOrders[0], children: [
                JiaPuMember(name: '张若涵', spouse: '', order: femaleOrders[0]),
              ]),
            ]),
          ],
        ),
        JiaPuMember(
          name: '张伟民',
          spouse: '',
          order: orders[1],
          children: [
            JiaPuMember(name: '张国强', spouse: '孙雯', order: orders[0], children: [
              JiaPuMember(name: '张子豪', spouse: '', order: orders[0], children: [
                JiaPuMember(name: '张晨曦', spouse: '陈瑶', order: orders[0], children: [
                  JiaPuMember(name: '张梓晨', spouse: '', order: orders[0]),
                ]),
              ]),
            ]),
            JiaPuMember(name: '张美玲', spouse: '', order: femaleOrders[0], children: [
              JiaPuMember(name: '张欣然', spouse: '李强', order: femaleOrders[0], children: [
                JiaPuMember(name: '张若雪', spouse: '', order: femaleOrders[0]),
              ]),
            ]),
          ],
        ),
        JiaPuMember(
          name: '张丽芳',
          spouse: '王强',
          order: femaleOrders[0],
          children: [
            JiaPuMember(name: '张志强', spouse: '', order: orders[0], children: [
              JiaPuMember(name: '张子轩', spouse: '刘娜', order: orders[0], children: [
                JiaPuMember(name: '张雨涵', spouse: '', order: femaleOrders[0]),
              ]),
            ]),
            JiaPuMember(name: '张雅婷', spouse: '赵宇', order: femaleOrders[0], children: [
              JiaPuMember(name: '张若琳', spouse: '', order: femaleOrders[0]),
            ]),
          ],
        ),
        JiaPuMember(
          name: '张建国',
          spouse: '',
          order: orders[2],
          children: [
            JiaPuMember(name: '张宏伟', spouse: '陈雪', order: orders[0], children: [
              JiaPuMember(name: '张子健', spouse: '', order: orders[0], children: [
                JiaPuMember(name: '张雨泽', spouse: '孙琳', order: orders[0]),
              ]),
            ]),
          ],
        ),
      ],
    );

    return gen1;
  }

  @override
  Widget build(BuildContext context) {
    final root = buildStaticFamilyTree();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '家谱',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: JiaPuStyles.primaryColor,
      ),
      body: Stack(
        children: [Positioned.fill(
          left: 12,
          right: 12,
          top: 12,
          bottom: 12,
          child: Container(
            color: Colors.white,
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
              backgroundColor: Color(0X2D000000),
            ),
          ),
        ),]
      ),
    );
  }
}