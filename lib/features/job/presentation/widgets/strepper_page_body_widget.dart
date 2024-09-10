
import 'package:flutter/material.dart';
import 'package:hr_career_platform/features/general/presentation/ui/add_job_body_page.dart';
import 'package:hr_career_platform/features/payment/presentation/ui/payment_page.dart';
import 'package:hr_career_platform/features/payment/presentation/ui/pkg_Page.dart';

Widget stepperPageBody(int selectedTab) {
  switch (selectedTab) {
    case 0:
      return AddJobBodyPage();
    case 1:
      return const PkgPage();
    case 2:
      return const PaymentPage();
    default:
      return const SizedBox();
  }
}

