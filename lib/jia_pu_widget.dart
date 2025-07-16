// lib/jia_pu_widget.dart
import 'package:flutter/material.dart';
import 'package:jia_pu_widget/jia_pu_layout.dart';
import 'package:jia_pu_widget/jia_pu_painter.dart';
import 'package:jia_pu_widget/models/jia_pu_member.dart';
import 'package:jia_pu_widget/utils.dart';

class JiaPuWidget extends StatefulWidget {
  final JiaPuMember root;
  final Widget Function(JiaPuMember) nodeBuilder;
  final Widget Function(String generation)? generationLabelBuilder;
  final double nodeWidth;
  final double nodeSpacing;
  final double nodeHeight;
  final double layerSpacing;
  final double generationLabelOffsetX;
  final double startX;
  final double startY;

  const JiaPuWidget({
    Key? key,
    required this.root,
    required this.nodeBuilder,
    this.generationLabelBuilder,
    this.nodeWidth = 150.0,
    this.nodeSpacing = 50.0,
    this.nodeHeight = 80.0,
    this.layerSpacing = 100.0,
    this.generationLabelOffsetX = 0.0,
    this.startX = 100.0,
    this.startY = 100.0,
  }) : super(key: key);

  @override
  _JiaPuWidgetState createState() => _JiaPuWidgetState();
}

class _JiaPuWidgetState extends State<JiaPuWidget> {
  late JiaPuLayout layout;

  @override
  void initState() {
    super.initState();
    layout = JiaPuLayout(
      startX: widget.startX,
      startY: widget.startY,
      nodeWidth: widget.nodeWidth,
      nodeHeight: widget.nodeHeight,
      nodeSpacing: widget.nodeSpacing,
      layerSpacing: widget.layerSpacing,
      generationLabelOffsetX: widget.generationLabelOffsetX,
    );
    layout.calculateOffsets(widget.root, 0);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          width: layout.calculateCanvasWidth(widget.root),
          height: layout.calculateCanvasHeight(widget.root, 0),
          child: Stack(
            children: [
              CustomPaint(
                painter: JiaPuPainter(
                  root: widget.root,
                  nodeWidth: widget.nodeWidth,
                  nodeHeight: widget.nodeHeight,
                  layerSpacing: widget.layerSpacing,
                  startX: widget.startX,
                  startY: widget.startY,
                ),
                size: Size.infinite,
              ),
              ...buildNodeWidgets(widget.root, widget.startX, widget.startY, 0),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildNodeWidgets(
    JiaPuMember member,
    double x,
    double y,
    int depth,
  ) {
    final widgets = <Widget>[];

    final offsets = layout.calculateOffsets(member, depth);
    if (widget.generationLabelBuilder != null &&
        offsets.containsKey(depth) &&
        offsets[depth]!.isNotEmpty &&
        x == offsets[depth]!.first) {
      widgets.add(
        Positioned(
          left: widget.generationLabelOffsetX,
          top: y,
          child: widget.generationLabelBuilder!(
            convertToChineseNumber(depth + 1),
          ),
        ),
      );
    }

    widgets.add(Positioned(left: x, top: y, child: widget.nodeBuilder(member)));

    if (member.children.isNotEmpty) {
      double childY = y + widget.nodeHeight + widget.layerSpacing;
      for (var child in member.children) {
        widgets.addAll(
          buildNodeWidgets(child, child.nodeXOffset, childY, depth + 1),
        );
      }
    }

    return widgets;
  }
}
