import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsDialog extends StatelessWidget {
  const TermsAndConditionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Terms and Conditions'.tr()),
      content:  SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Please read these terms and conditions carefully.'.tr()),
            Text('Term 1: ...'.tr()),
            Text('Term 2: ...'.tr()),
            Text('Term 3: ...'.tr()),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Ok'.tr()),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
