// example/jia_pu_styles.dart
import 'package:flutter/material.dart';
import 'package:jia_pu_widget/models/jia_pu_member.dart';

class JiaPuStyles {
  static const Color primaryColor = Color(0xFF1C2859);
  static const Color treeBackgroundColor = Color(0xFFF6F6F6);
  static const Color textColor = Color(0xFF454A50);
  static const Color secondaryTextColor = Color(0x99454A50);

  static const double nodeWidth = 75.0;
  static const double nodeHeight = 96.0 / 4 * 3;
  static const double nodeSpacing = 32.0;
  static const double layerSpacing = 24.0;
  static const double generationLabelOffsetX = 12.0;
  static const double startX = 74.0;
  static const double startY = 12.0;

  static const TextStyle nodeNameStyle = TextStyle(
    color: primaryColor,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle nodeSpouseStyle = TextStyle(
    color: secondaryTextColor,
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle nodeOrderStyle = TextStyle(
    color: secondaryTextColor,
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle generationLabelStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static Widget buildGenerationLabel(String generation) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: primaryColor, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.all(6.0),
        child: Center(
          child: Text('$generation\n世', style: generationLabelStyle),
        ),
      ),
    );
  }

  static Widget buildNode(JiaPuMember member) {
    return GestureDetector(
      onTap: () => print('点击了${member.name}'),
      child: Container(
        width: nodeWidth,
        height: nodeHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 12,
              child: Text(
                member.spouse.characters.join('\n'),
                style: nodeSpouseStyle,
                overflow: TextOverflow.visible,
              ),
            ),
            const SizedBox(width: 4),
            SizedBox(
              width: 18,
              child: Text(
                member.name.characters.join('\n'),
                style: nodeNameStyle,
                overflow: TextOverflow.visible,
              ),
            ),
            const SizedBox(width: 4),
            SizedBox(
              width: 12,
              child: Text(
                member.order.characters.join('\n'),
                style: nodeOrderStyle,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
