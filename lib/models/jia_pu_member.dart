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

  factory JiaPuMember.fromJson(Map<String, dynamic> json) {
    return JiaPuMember(
      name: json['name'] ?? '',
      spouse: json['spouse'] ?? '',
      order: json['order'] ?? '',
      children: (json['children'] as List<dynamic>?)
          ?.map((child) => JiaPuMember.fromJson(child))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'spouse': spouse,
    'order': order,
    'children': children.map((child) => child.toJson()).toList(),
  };
}
