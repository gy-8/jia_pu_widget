// lib/jia_pu_layout.dart
import 'dart:math' as math;

import 'package:jia_pu_widget/models/jia_pu_member.dart';

class JiaPuLayout {
  final double startX;
  final double startY;
  final double nodeWidth;
  final double nodeHeight;
  final double nodeSpacing;
  final double layerSpacing;
  final double generationLabelOffsetX;

  JiaPuLayout({
    required this.startX,
    required this.startY,
    required this.nodeWidth,
    required this.nodeHeight,
    required this.nodeSpacing,
    required this.layerSpacing,
    required this.generationLabelOffsetX,
  });

  List<double> calculateOffsets(JiaPuMember member, int generation) {
    final offsets = <double>[];
    if (member.children.isEmpty) {
      member.subtreeMaxXOffset = member.nodeXOffset;
      offsets.add(member.nodeXOffset);
      return offsets;
    }

    double currentX = member.nodeXOffset;
    for (var child in member.children) {
      child.nodeXOffset = currentX;
      offsets.addAll(calculateOffsets(child, generation + 1));
      currentX = math.max(currentX, child.subtreeMaxXOffset) +
          nodeWidth +
          nodeSpacing;
      child.subtreeMaxXOffset = currentX;
    }

    member.subtreeMaxXOffset = currentX - nodeWidth - nodeSpacing;
    return offsets;
  }

  double calculateCanvasWidth(JiaPuMember? root) {
    if (root == null) return 0.0;

    return root.subtreeMaxXOffset + nodeWidth + startX;
  }

  double calculateCanvasHeight(JiaPuMember? root, int generation) {
    if (root == null) return 0.0;
    
    return (calculateTreeDepth(root) + 1) *
        (nodeHeight + layerSpacing) +
        startY;
  }

  int calculateTreeDepth(JiaPuMember? member) {
    if (member == null || member.children.isEmpty) return 0;
    int maxDepth = 0;
    for (var child in member.children) {
      int depth = calculateTreeDepth(child);
      if (depth > maxDepth) maxDepth = depth;
    }
    return maxDepth + 1;
  }
}
