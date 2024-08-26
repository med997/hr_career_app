import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:hr_career_platform/core/util/enums.dart';

Widget getTextWidget(DynamicModel dynamicModel) {
  return TextFormField(
    enabled: !dynamicModel.disabled,
    style: TextStyle(fontSize: 14),
    decoration: InputDecoration(
        helperText: dynamicModel.helperText ?? '',
        labelText: dynamicModel.controlName,
      constraints: const BoxConstraints.tightFor(height: 55),

    ),

    keyboardType: TextInputType.text,
    maxLines: null,
   /* validator: (text) {
      var selectedField = dynamicModel.validators;

      //To validate non-empty, it returns an error message if the text is empty.
      if (selectedField.isRequired && selectedField.validators
              .any((element) => element.type == ValidatorType.notEmpty) &&
          (text == null || text.isEmpty)) {
        return selectedField.validators
            .firstWhere(
                (element) => element.type == ValidatorType.notEmpty)
            .errorMessage;
      }

      //To validate text length, it returns an error message if the text length is greater than the fixed length.
      if (selectedField.validators
          .any((element) => element.type == ValidatorType.textLength)) {
        var validator = selectedField.validators.firstWhere(
                (element) => element.type == ValidatorType.textLength);
        int? len = text?.length;
        if (len != null && len > validator.textLength) {
          return validator.errorMessage;
        }
      }
      return null;
    },*/
    onChanged: (text) {
      dynamicModel.value = text;
    },
  );
}