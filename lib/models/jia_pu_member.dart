// lib/models/jia_pu_member.dart
class JiaPuMember {
  final String name;
  final String spouse;
  final String order;
  final List<JiaPuMember> children;
  double nodeXOffset;
  double subtreeMaxXOffset;

  JiaPuMember({
    required this.name,
    required this.spouse,
    required this.order,
    this.children = const [],
    this.nodeXOffset = 0.0,
    this.subtreeMaxXOffset = 0.0,
  });
}
