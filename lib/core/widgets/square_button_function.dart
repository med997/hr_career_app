import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/app_theme.dart';

SizedBox squareButton(
    {required Color clr, required IconData icn, required String iconLabel, required Function() onTap}) {
  return SizedBox(
    height: 75,
    width: 105,
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        color: clr,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(onPressed: onTap, icon: Icon(icn,color: Colors.white,),),
          Text(iconLabel,style: TextStyle(color: Colors.white),)
        ],
      ),
    ),
  );
}