import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/app_theme.dart';

class AvatarNetwork extends StatelessWidget {
  String imgUrl;
  bool withBorder;
  double? redius;

  AvatarNetwork({
    super.key,
    required this.imgUrl,
    required this.withBorder,
    this.redius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
          color:  primaryTransparent,
          shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(redius ?? 48),
              side: withBorder? BorderSide(width:0.5, color: primaryColor)
                  :BorderSide(width:0.1, color: Colors.transparent))
      ),

      height: 38,
      width: 38,
      child: ClipOval(
        child: SizedBox.fromSize(
          size: Size.fromRadius(redius ?? 48), // Image radius
          child: Image.network(
            imgUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.person);
            },
          ),
        ),
      ),
    );
  }
}
