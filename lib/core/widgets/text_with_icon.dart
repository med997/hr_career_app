import 'package:flutter/cupertino.dart';
import 'package:hr_career_platform/core/app_theme.dart';

class TextWithIcon extends StatelessWidget {
  final Icon icon;
  final String text;
  final Color? textColor;

  const TextWithIcon(
      {super.key, required this.icon, required this.text, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 2,
      children: [
        icon,
        Text(text,
            style: TextStyle(color: textColor ?? primaryColor, fontSize: 14)),

      ],
    );
  }
}
