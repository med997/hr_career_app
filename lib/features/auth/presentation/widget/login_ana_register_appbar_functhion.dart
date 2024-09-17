import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/app_theme.dart';

Widget loginAndRegisterAppBar({Color? bgColor = null}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Image.asset('assets/imgs/project_logo.png'),
       Text(
        'HR Applications',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: primaryColor),
      ),

       Text(
        "Let's log in. Apply or post to jobs!",
        style: TextStyle(fontSize: 12, color: primaryColor,),
      ),
    ],
  );
}

