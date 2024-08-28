import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:intl_phone_field/intl_phone_field.dart';




Widget getPhoneWidget(DynamicModel dynamicModel) {
return
  IntlPhoneField(
    showCountryFlag: false,
    decoration: InputDecoration(
      counterText: '',
      helperText: dynamicModel.helperText ?? '',
      labelText: dynamicModel.controlName,
      constraints:   const BoxConstraints.tightFor(height: 55),
    ),
    style: TextStyle(fontSize: 14),
    initialCountryCode: 'SA',
    controller: dynamicModel.controller,
  );
}
