import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/app_theme.dart';

enum SubTitleType { textOnly, withIcon, withShowMore }

class SubTitle extends StatelessWidget {
  String title;
  Icon? icon;
  SubTitleType titleType = SubTitleType.textOnly;
  Function? onShowMoreClicked;

  SubTitle({required this.title, this.icon, required this.titleType, this.onShowMoreClicked });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: primaryColor),
          ),
          if (titleType == SubTitleType.withIcon)
            Container(
              height: 24,
              width: 24,
              child: icon,
            )
          else if (titleType == SubTitleType.withShowMore)
            Container(
              child: InkWell(
                onTap: () => onShowMoreClicked!(),
                  child: const Text(
                'show more',
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
