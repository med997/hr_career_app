import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<bool?> showBackDialog(BuildContext context,String closeMsg) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('are_you_sure'.tr()),
        content:  Text(
          closeMsg.tr(),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: Text('cancel'.tr()),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child:  Text('close_page'.tr()),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ],
      );
    },
  );
}
