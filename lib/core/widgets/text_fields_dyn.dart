import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:hr_career_platform/core/util/enums.dart';

Widget getTextWidget(DynamicModel dynamicModel, BuildContext context) {

  return Padding(
    padding: EdgeInsets.only(bottom: dynamicModel.padding ?? 2.0),
    child: Flex(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      direction: Axis.horizontal,
      children: [
        Flexible(
          child: TextFormField(
              key: Key(dynamicModel.controlName),
              enabled: !dynamicModel.disabled,
              textInputAction: dynamicModel.inputAction ?? TextInputAction.next,
              style: const TextStyle(fontSize: 14),
              controller: dynamicModel.controller,
              onSaved: (newValue) {
                dynamicModel.onSubmit ?? dynamicModel.onSubmit!();
              },
              obscureText: (dynamicModel.formType == FormType.password &&
                  dynamicModel.hidePass == true),
              decoration: InputDecoration(
                border: dynamicModel.inputBorder,
                suffixIcon: dynamicModel.formType == FormType.password
                    ? dynamicModel.hidePass == true
                        ? IconButton(
                    padding: EdgeInsets.all(0),
                            onPressed: () {
                              dynamicModel.hidePass = false;
                              context
                                  .read<DynamicFormCubit>()
                                  .updateFieldValue(dynamicModel);
                            },
                            icon: const Icon(Icons.visibility))
                        : IconButton(
                  padding: EdgeInsets.all(0),
                            onPressed: () {
                              dynamicModel.hidePass = true;
                              context
                                  .read<DynamicFormCubit>()
                                  .updateFieldValue(dynamicModel);
                            },
                            icon: const Icon(Icons.visibility_off))
                    : dynamicModel.icons,
                suffixIconConstraints:
                    const BoxConstraints.tightFor(height: 20, width: 40),
                helperText: dynamicModel.helperText ?? '',
                labelText: dynamicModel.controlName.tr(),
                errorMaxLines: 1,
                errorStyle: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 10.0,
                ),
                constraints:
                    BoxConstraints.tightFor(height: dynamicModel.hight ?? 55),
              ),
              keyboardType: dynamicModel.formType == FormType.number
                  ? TextInputType.number
                  : dynamicModel.formType == FormType.email
                      ? TextInputType.emailAddress
                      : TextInputType.text,
              maxLines: 1,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (text) {
                if (!dynamicModel.isRequired &&
                    dynamicModel.validators == null) {
                  return null;
                }
                if (dynamicModel.isRequired &&
                    (text == null || text.trim().isEmpty)) {
                  return 'this_field_is_required'.tr();
                }
                //To validate non-empty, it returns an error message if the text is empty.
                if (dynamicModel.validators!.any(
                        (element) => element.type == ValidatorType.notEmpty) &&
                    (text == null || text.isEmpty)) {
                  return dynamicModel.validators!
                      .firstWhere(
                          (element) => element.type == ValidatorType.notEmpty)
                      .errorMessage;
                }
                if (dynamicModel.formType == FormType.email) {
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(text!)) {
                    return 'enter_a_valid_email_address'.tr();
                  }
                }
                //To validate text length, it returns an error message if the text length is greater than the fixed length.
                if (dynamicModel.validators!.any(
                    (element) => element.type == ValidatorType.textLength)) {
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

                if (dynamicModel.validators!
                    .any((element) => element.type == ValidatorType.equalTo)) {
                  var validator = dynamicModel.validators!.firstWhere(
                      (element) => element.type == ValidatorType.equalTo);
                  String? compareText = dynamicModel.compareText;
                  print('compareText $compareText');
                  if (compareText != null && text != compareText) {
                    return validator.errorMessage;
                  }
                }
                return null;
              },
              onChanged: (value) {
                // (dynamicModel.controller as TextEditingController).text=value;
                context.read<DynamicFormCubit>().updateFieldValue(dynamicModel);
              }),
        ),
        if (dynamicModel.action != null && !dynamicModel.disabled)
          SizedBox(height: 35, width: 35, child: dynamicModel.action!),
      ],
    ),
  );
}
