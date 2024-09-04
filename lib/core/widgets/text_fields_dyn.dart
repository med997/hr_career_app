import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:hr_career_platform/core/util/enums.dart';

Widget getTextWidget(DynamicModel dynamicModel, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: TextFormField(
        enabled: !dynamicModel.disabled,
        style: const TextStyle(fontSize: 14),
        obscureText: dynamicModel.formType == FormType.password,
        decoration: InputDecoration(
          helperText: dynamicModel.helperText ?? '',
          labelText: dynamicModel.controlName,
          errorMaxLines: 1,
          errorStyle: const TextStyle(
            color: Colors.redAccent,
            fontSize: 10.0,
          ),
          constraints: const BoxConstraints.tightFor(height: 55),
        ),
        keyboardType: dynamicModel.formType == FormType.number
            ? TextInputType.number
            : dynamicModel.formType ==FormType.email
            ? TextInputType.emailAddress
            : TextInputType.text,
        maxLines: 1,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (text) {
          //To validate non-empty, it returns an error message if the text is empty.
          if (dynamicModel.isRequired &&
              dynamicModel.validators!
                  .any((element) => element.type == ValidatorType.notEmpty) &&
              (text == null || text.isEmpty)) {
            return dynamicModel.validators!
                .firstWhere((element) => element.type == ValidatorType.notEmpty)
                .errorMessage;
          }
          if (dynamicModel.formType == FormType.email) {
            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
            if (!emailRegex.hasMatch(text!)) {
              return 'Enter a valid email address';
            }
          }
          //To validate text length, it returns an error message if the text length is greater than the fixed length.
          if (dynamicModel.validators!
              .any((element) => element.type == ValidatorType.textLength)) {
            var validator = dynamicModel.validators!.firstWhere(
                (element) => element.type == ValidatorType.textLength);
            int? len = text?.length;
            if (len != null && len > validator.textLength) {
              return validator.errorMessage;
            }
            }
  //To validate text equal to another text ,
  //
  // it returns an error message if the text length is greater than the fixed length.

  if (dynamicModel.validators!.any((element) => element.type == ValidatorType.equalTo)) {
    var validator = dynamicModel.validators!.firstWhere(
            (element) => element.type == ValidatorType.equalTo);
            String? compareText =  dynamicModel.compareText;
            print('compareText $compareText');
            if (compareText!=null && text !=compareText) {
              return validator.errorMessage;
            }
          }
          return null;
        },
        onChanged: (value) {
          dynamicModel.value = value;
          context.read<DynamicFormCubit>().updateFieldValue(dynamicModel);
        }),
  );
}
