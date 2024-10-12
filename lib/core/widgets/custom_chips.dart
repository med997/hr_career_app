import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/app_theme.dart';

class CustomChips extends StatelessWidget {
  List<String> chipsTitles;
  Color? bgColor;
  Color? txtColor;
  double? txtSize;

  CustomChips(
      {required this.chipsTitles, this.bgColor, this.txtColor, this.txtSize});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      alignment: WrapAlignment.start,
      children: [
        ...chipsTitles.map(
          (title) {
            return Container(
              margin: EdgeInsets.only(bottom: 4),
              padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 12.0),
              decoration: BoxDecoration(
                  color: bgColor ?? primaryColor,
                  borderRadius: BorderRadius.circular(90),
                  border: Border.all(color: bgColor ?? primaryColor)),
              child: Text(
                title,
                style: TextStyle(
                    color: txtColor ?? Colors.white, fontSize: txtSize ?? 12),
              ),
            );
          },
        )
      ],
    );
  }
}
