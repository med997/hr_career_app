import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../app_theme.dart';




Widget getPhoneWidget(DynamicModel dynamicModel,[BuildContext? context]) {
return
  Padding(
    padding:  EdgeInsets.only(bottom: dynamicModel.padding??8.0),
    child: IntlPhoneField(
      enabled: !dynamicModel.disabled,
flagsButtonMargin: EdgeInsets.symmetric(vertical: 4),
        flagsButtonPadding: EdgeInsets.symmetric(vertical: 4),
       controller: dynamicModel.controller,
      showCountryFlag: false,
      decoration: InputDecoration(
        counterText: '',
        helperText: dynamicModel.helperText ?? '',
        alignLabelWithHint: false,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
        labelText: dynamicModel.controlName,
        contentPadding: EdgeInsets.symmetric(vertical: 12),
        constraints:   const BoxConstraints.tightFor(height: 60),
      ),
        validator: (text) {
          //To validate non-empty, it returns an error message if the text is empty.
          if (dynamicModel.isRequired &&
              dynamicModel.validators!
                  .any((element) => element.type == ValidatorType.notEmpty) &&
              (text == null || text.number.isEmpty)) {
            return dynamicModel.validators!
                .firstWhere((element) => element.type == ValidatorType.notEmpty)
                .errorMessage;
          }

          return null;
        },
      style: TextStyle(fontSize: 14),

      initialCountryCode: 'SA',
        onChanged: (value) {
          context!.read<DynamicFormCubit>().updateFieldValue(dynamicModel);
        }
    ),
  );
}
