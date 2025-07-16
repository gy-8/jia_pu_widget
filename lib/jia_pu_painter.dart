// lib/jia_pu_painter.dart
import 'package:flutter/material.dart';
import 'package:jia_pu_widget/models/jia_pu_member.dart';

class JiaPuPainter extends CustomPainter {
  final JiaPuMember root;
  final double nodeWidth;
  final double nodeHeight;
  final double layerSpacing;
  final double startX;
  final double startY;

  JiaPuPainter({
    required this.root,
    required this.nodeWidth,
    required this.nodeHeight,
    required this.layerSpacing,
    required this.startX,
    required this.startY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    drawTree(canvas, root, startX, startY);
  }

  void drawTree(Canvas canvas, JiaPuMember member, double x, double y) {
    final nodeCenter = Offset(x + nodeWidth / 2, y + nodeHeight);

    if (member.children.isNotEmpty) {
      double childY = y + nodeHeight + layerSpacing;
      for (var child in member.children) {
        final childCenter = Offset(child.nodeXOffset + nodeWidth / 2, childY);
        final paint = Paint()
          ..color = Colors.black
          ..strokeWidth = 1;

        if (child.nodeXOffset == x) {
          canvas.drawLine(nodeCenter, childCenter, paint);
        } else {
          final midY = (nodeCenter.dy + childCenter.dy) / 2;
          if (member.children.last == child) {
            canvas.drawLine(
              Offset(nodeCenter.dx, midY),
              Offset(childCenter.dx, midY),
              paint,
            );
          }
          canvas.drawLine(Offset(childCenter.dx, midY), childCenter, paint);
        }

        drawTree(canvas, child, child.nodeXOffset, childY);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
