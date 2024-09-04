import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:intl_phone_field/intl_phone_field.dart';




Widget getPhoneWidget(DynamicModel dynamicModel,[BuildContext? context]) {
return
  IntlPhoneField(
      initialValue: dynamicModel.value,
    showCountryFlag: false,
    decoration: InputDecoration(
      counterText: '',
      helperText: dynamicModel.helperText ?? '',
      labelText: dynamicModel.controlName,
      constraints:   const BoxConstraints.tightFor(height: 55),
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
        dynamicModel.value = value.completeNumber;
        context!.read<DynamicFormCubit>().updateFieldValue(dynamicModel);
      }
  );
}
