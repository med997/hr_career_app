import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/app_theme.dart';

class CustomChips extends StatelessWidget {
  List<String> chipsTitles;
  Color? bgColor;
  Color? txtColor;
  CustomChips({required this.chipsTitles, this.bgColor, this.txtColor});

  @override
  Widget build(BuildContext context) {
    return Wrap(

      children: [

        ...chipsTitles.map(
          (title) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 1.0),
              padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 15.0),
              decoration: BoxDecoration(color: bgColor??primaryColor, borderRadius: BorderRadius.circular(90),
                  border: Border.all(color: bgColor??primaryColor)),
              child: Text(
                title,
                style: TextStyle(color: txtColor?? Colors.white),
              ),
            );
          },
        )
      ],
    );
  }
}
