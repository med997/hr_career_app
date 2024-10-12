import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';

import '../cubit/dynamic_form_cubit.dart';

Widget buildCustomDropDownMenu( BuildContext context,
  DynamicModel dynModel,
) {
  print('buildCustomDropDownMenu');
  return Padding(
    padding:  EdgeInsets.only(bottom: dynModel.padding??28.0),
    child: DropdownMenu(
      key: Key(dynModel.key),
       // initialSelection: dynModel.value,
      controller: dynModel.controller,
      enabled: !dynModel.disabled,
      width: dynModel.width ,
      expandedInsets: EdgeInsets.zero,
      trailingIcon: Transform.translate(
        offset: const Offset(3, -7),
        child: const Icon(Icons.keyboard_arrow_down),
      ),
      label: Text(dynModel.controlName),
      dropdownMenuEntries:  dynModel.items
          .map(
            (e) => DropdownMenuEntry(value: e.key, label: e.value),
      ).toList(),

      onSelected: (value) {
       dynModel.controller!.text = value!;
        context.read<DynamicFormCubit>().updateFieldValue(dynModel);
      },
    ),
  );
}
