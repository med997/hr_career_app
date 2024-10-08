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
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        Flexible(

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Text(text, overflow: TextOverflow.ellipsis,
                softWrap: true, maxLines: 1, textAlign: TextAlign.start,
                style: TextStyle(color: textColor ?? primaryColor, fontSize: 12)),
          ),
        ),

      ],
    );
  }
}
