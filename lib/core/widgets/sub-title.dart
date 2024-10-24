import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hr_career_platform/core/app_localizations.dart';
import 'package:hr_career_platform/core/app_theme.dart';

enum SubTitleType { textOnly, withIcon, withShowMore }

class SubTitle extends StatelessWidget {
  String title;
  Icon? icon;
  double? txtSize;
  IconButton? iconButton;
  Color? textColor;
  SubTitleType titleType = SubTitleType.textOnly;
  Function? onShowMoreClicked;

  SubTitle({required this.title, this.icon, this.txtSize,this.iconButton, this.textColor, required this.titleType, this.onShowMoreClicked });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2 ,vertical: 8),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Text(
            title,
            style:
                 TextStyle(fontWeight: FontWeight.bold, fontSize: txtSize?? 14, color: textColor?? primaryColor),
          ),
          if (titleType == SubTitleType.withIcon)
            Center(child: icon ?? iconButton)
          else if (titleType == SubTitleType.withShowMore)
            Container(
              child: InkWell(
                onTap: () => onShowMoreClicked!(),
                  child: Text(
                    tr("show_more_msg"),
                style: TextStyle(color: Colors.black54),
              )),
            )
          else
            SizedBox(),
        ],
      ),
    );
  }
}
