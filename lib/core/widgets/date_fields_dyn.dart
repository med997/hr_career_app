


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/dynamic_form_cubit.dart';
import '../model/dynamic_model.dart';
import '../util/enums.dart';
import 'date_picker_dialog.dart';
Widget getDatePickerWidget(DynamicModel dynamicModel, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: TextFormField(
        onTap: () async{
          DateTime dateTime= await showDatePickerDialog(context);
          dynamicModel.controller!.text = dateTime.toString();
        } ,
        readOnly: true,
        enabled: !dynamicModel.disabled,
        controller: dynamicModel.controller,
        style: const TextStyle(fontSize: 14),
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
        keyboardType:TextInputType.text,
        maxLines: 1,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (text) {
          //To validate non-empty, it returns an error message if the text is empty.
          if (dynamicModel.isRequired && dynamicModel.validators!.any((element) => element.type == ValidatorType.notEmpty) &&
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