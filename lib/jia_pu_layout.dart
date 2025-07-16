// lib/jia_pu_layout.dart
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

  Map<int, List<double>> calculateOffsets(JiaPuMember? root, int generation) {
    final offsets = <int, List<double>>{};

    if (root == null) return offsets;

    if (!offsets.containsKey(generation)) {
      offsets[generation] = [];
    }

    root.nodeXOffset = startX;
    offsets[generation]!.add(startX);

    double nextX = startX;
    for (var child in root.children) {
      final childOffsets = calculateOffsets(child, generation + 1);
      offsets.addAll(childOffsets);

      if (childOffsets.containsKey(generation + 1) &&
          childOffsets[generation + 1]!.isNotEmpty) {
        final childCount = childOffsets[generation + 1]!.length;
        final totalChildWidth =
            childCount * nodeWidth + (childCount - 1) * nodeSpacing;
        final childStartX = nextX;
        for (int i = 0; i < childCount; i++) {
          final childX = childStartX + i * (nodeWidth + nodeSpacing);
          childOffsets[generation + 1]![i] = childX;
          if (i < child.children.length) {
            child.children[i].nodeXOffset = childX;
          }
        }
        nextX = childStartX + totalChildWidth + nodeSpacing;
      }
    }

    if (root.children.isNotEmpty && offsets.containsKey(generation + 1)) {
      final childOffsets = offsets[generation + 1]!;
      if (childOffsets.isNotEmpty) {
        root.nodeXOffset = (childOffsets.first + childOffsets.last) / 2;
        offsets[generation]![0] = root.nodeXOffset;
      }
    }

    root.subtreeMaxXOffset = nextX - nodeWidth - nodeSpacing;
    return offsets;
  }

  double calculateCanvasWidth(JiaPuMember? root) {
    if (root == null) return 0.0;

    double maxWidth = (root.nodeXOffset + nodeWidth);
    for (var child in root.children) {
      final childWidth = calculateCanvasWidth(child);
      maxWidth = maxWidth > childWidth ? maxWidth : childWidth;
    }
    return maxWidth + nodeSpacing;
  }

  double calculateCanvasHeight(JiaPuMember? root, int generation) {
    if (root == null) return 0.0;

    double maxHeight =
        startY + nodeHeight + (generation * (nodeHeight + layerSpacing));
    for (var child in root.children) {
      final childHeight = calculateCanvasHeight(child, generation + 1);
      maxHeight = maxHeight > childHeight ? maxHeight : childHeight;
    }
    return maxHeight;
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
