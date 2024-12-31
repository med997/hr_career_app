import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../app_theme.dart';

Widget getPhoneWidget(DynamicModel dynamicModel, [BuildContext? context]) {
  final List<Country> countriesList =
      countries.where((element) => element.code == 'YE').toList();
  return Padding(
    padding: EdgeInsets.only(bottom: dynamicModel.padding ?? 8.0),
    child: IntlPhoneField(
        readOnly: dynamicModel.disabled,
        disableAutoFillHints: true,
        textInputAction: dynamicModel.inputAction ?? TextInputAction.next,
        textAlign: TextAlign.start,
        key: Key(dynamicModel.key),
        enabled: !dynamicModel.disabled,
        flagsButtonMargin: const EdgeInsets.symmetric(vertical: 4),
        flagsButtonPadding: const EdgeInsets.symmetric(vertical: 4),
        controller: dynamicModel.controller,
        showCountryFlag: false,
        decoration: InputDecoration(
          counterText: '',
          helperText: dynamicModel.helperText ?? '',
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
          labelText: dynamicModel.controlName.tr(),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          constraints: const BoxConstraints.tightFor(height: 60),
        ),
        validator: (text) {
          //To validate non-empty, it returns an error message if the text is empty.
          if (!dynamicModel.isRequired && dynamicModel.validators == null) {
            return null;
          }
          if (dynamicModel.isRequired && text == null ) {
            return 'this_phone_number_is_required'.tr();
          }
          if (dynamicModel.validators!
                  .any((element) => element.type == ValidatorType.notEmpty) &&
              (text == null || text.number.isEmpty)) {
            return dynamicModel.validators!
                .firstWhere((element) => element.type == ValidatorType.notEmpty)
                .errorMessage;
          }
          return null;
        },
        countries: countriesList,
        style: const TextStyle(fontSize: 14),
        initialCountryCode: 'YE',
        onChanged: (value) {
          context!.read<DynamicFormCubit>().updateFieldValue(dynamicModel);
        }),
  );
}
