import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
Future<dynamic> showColorPickerDialog(BuildContext context) {
  Color pickColor = Color.fromARGB(255, 232, 185, 49);
  return showDialog<Color>(
    context: context,
    builder: (BuildContext contextDialog) {

      return AlertDialog(
        title:  Text('select_current_date_msg'.tr()),
        scrollable: true,
        content: SizedBox(
          height: 500,
          width: 300,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              ColorPicker(
                colorPickerWidth: 300,
                paletteType: PaletteType.hsvWithHue,
                portraitOnly: true,
                pickerColor:  pickColor,
                onColorChanged: (Color value) {
                  pickColor = value;

                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('cancel'.tr()),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(contextDialog,pickColor);
            },
            child: Text('ok'.tr()),
          ),
        ],

      );
    },
  );
}