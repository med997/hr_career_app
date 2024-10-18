
import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/features/job/presentation/ui/add_job_body_page.dart';
import 'package:hr_career_platform/features/payment/presentation/ui/payment_page.dart';
import 'package:hr_career_platform/features/payment/presentation/ui/pkg_Page.dart';

Widget stepperAddJobPageBody(int selectedTab) {
  switch (selectedTab) {
    case 0:
      return AddJobBodyPage();
    case 1:
      return const PkgPage(pkgType: PkgType.job,);
    case 2:
      return   PaymentPage(pkgType: PkgType.job,);
    default:
      return const SizedBox();
  }
}

