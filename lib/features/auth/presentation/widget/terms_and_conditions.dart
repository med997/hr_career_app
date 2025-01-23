import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsDialog extends StatelessWidget {
  const TermsAndConditionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('termsAndConditionsTitle'.tr()),
      content:  SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('termsAndConditionsDetails'.tr()),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('iAgree'.tr()),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
