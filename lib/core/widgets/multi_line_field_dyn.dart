import 'package:easy_localization/easy_localization.dart';
import 'package:fleather/fleather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/widgets/multi_line_dialog.dart';

import '../cubit/dynamic_form_cubit.dart';
import '../model/dynamic_model.dart';
import '../util/enums.dart';

Widget getMultiLineFieldWidget(
    DynamicModel dynamicModel, BuildContext context) {
  return Padding(
    padding:  EdgeInsets.only(bottom: dynamicModel.padding??8.0),
    child: TextFormField(
        key: Key(dynamicModel.key),
        onTap: () async {
          final content = await showMultiLineDialog(dynamicModel, context);
          dynamicModel.controller!.text = content.toPlainText();
        },
        controller: dynamicModel.controller,
        readOnly: true,
        enabled: !dynamicModel.disabled,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          helperText: dynamicModel.helperText ?? '',
          labelText: dynamicModel.controlName.tr(),
          errorMaxLines: 1,
          errorStyle: const TextStyle(
            color: Colors.redAccent,
            fontSize: 10.0,
          ),
          constraints: const BoxConstraints.tightFor(height: 55),
        ),
        keyboardType: TextInputType.text,
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
        },
        onChanged: (value) {
          print(value);
          context.read<DynamicFormCubit>().updateFieldValue(dynamicModel);
        }),
  );
}
