import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/widgets/app_bar_function.dart';

class ApplyNowPage extends StatelessWidget {
  const ApplyNowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(
          userName: 'Ibrahim Murad',
          img: '',
          userOrCompany: 'User',
        ),
        body: const SizedBox());
  }
}
