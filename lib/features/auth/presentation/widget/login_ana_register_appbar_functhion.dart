import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/app_theme.dart';

Widget loginAndRegisterAppBar({Color? bgColor = null}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Image.asset('assets/imgs/project_logo.png'),
       Text(
        'hr_applications'.tr(),
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: primaryColor),
      ),

       Text(
        "lets_log_in_apply_or_post_to_jobs".tr(),
        style: TextStyle(fontSize: 12, color: primaryColor,),
      ),
    ],
  );
}

