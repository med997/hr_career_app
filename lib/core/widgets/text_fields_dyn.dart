import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:hr_career_platform/core/util/enums.dart';

Widget getTextWidget(DynamicModel dynamicModel) {
  return TextFormField(
    enabled: !dynamicModel.disabled,
    style: TextStyle(fontSize: 14),
    obscureText: dynamicModel.formType== FormType.password,
    decoration: InputDecoration(
      helperText: dynamicModel.helperText ?? '',
      labelText: dynamicModel.controlName,
      constraints: const BoxConstraints.tightFor(height: 55),
    ),
    controller: dynamicModel.controller,
    keyboardType: dynamicModel.formType == FormType.number
        ? TextInputType.number
        : TextInputType.text,
    maxLines: 1,

    onChanged: (text) {
      dynamicModel.value = text;
    },
  );
}
