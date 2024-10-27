import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/app_theme.dart';

Widget squareButton(
    {required Color clr, required IconData icn, required String iconLabel, required Function() onTap}) {
  return InkWell(
    onTap:() =>  onTap(),
    child: Container(
      height: 75,
      width: 110,

      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: clr,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(onPressed: onTap, icon: Icon(icn,color: Colors.white,size: 24,),),
          Text(

            iconLabel,style:  TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),)
        ],
      ),
    ),
  );
}