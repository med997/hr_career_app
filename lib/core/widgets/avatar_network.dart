import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/app_theme.dart';

class AvatarNetwork extends StatelessWidget {
  final String imgUrl;
  final bool withBorder;
  final bool? withEditBtn;
  final double? redius;
  final Function? editClicked;
  final double? size;
  final Color? bgColor;
  final Color? borderColor;

  const AvatarNetwork({
    super.key,
    required this.imgUrl,
    required this.withBorder,
    this.bgColor,
    this.size,
    this.editClicked,
    this.withEditBtn,
    this.borderColor,
    this.redius,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: ShapeDecoration(
              color: bgColor ?? primaryTransparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(redius ?? 48),
                  side: withBorder
                      ? BorderSide(width: 0.5, color:borderColor??primaryColor)
                      : BorderSide(width: 0.1, color: Colors.transparent))),
          height: size??38,
          width: size??38,
          child: ClipOval(
            child: SizedBox.fromSize(
              size: Size.fromRadius(redius ?? 48), // Image radius
              child: buildImage(),
            ),
          ),
        ),
        if (withEditBtn == true)
          InkWell(
            onTap: () => editClicked!(),
            child: Container(
                padding: EdgeInsets.all(2),
                decoration: ShapeDecoration(
                    shape: CircleBorder(), color: Colors.yellow.shade700),
                child: Icon(
                  Icons.edit,
                  size: 12,
                  color: primaryColor,
                )),
          )
      ],
    );
  }

  Image buildImage() {
    if (imgUrl.startsWith('http://') || imgUrl.startsWith('https://')) {
      return Image.network(
        imgUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print(error);
          return const Icon(Icons.person);
        },
      );
    } else {
      return Image.asset(
        imgUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print(error);
          return const Icon(Icons.person);
        },
      );
    }
  }
}
