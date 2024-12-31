import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<dynamic> showDatePickerDialog(BuildContext context) {
  return showDialog<DateTime>(
    context: context,
    builder: (BuildContext contextDialog) {
      return AlertDialog(
          title: Text('select_current_date_msg'.tr()),
          scrollable: true,
          content: SizedBox(
            height: 300,
            width: 300,
            child: DatePicker(
              padding: EdgeInsets.all(8),
              centerLeadingDate: true,
              onDateSelected: (dateSelected) {
                Navigator.pop(contextDialog, dateSelected);
              },
              minDate: DateTime(DateTime.now().year - 100),
              maxDate: DateTime(DateTime.now().year - 18),
              initialDate: DateTime(DateTime.now().year - 20),
            ),
          ));
    },
  );
}
