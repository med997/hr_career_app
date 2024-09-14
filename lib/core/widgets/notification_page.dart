import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/widgets/app_bar_function.dart';
import 'package:hr_career_platform/core/widgets/toggle_btn_widget.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
            children: [
          ToggleBtnWidget(
            options: const ['All', 'Following', 'Archive'],
          ),
          const SizedBox(
            height: 5,
          ),
        ]),
      ),
    );
  }
}
