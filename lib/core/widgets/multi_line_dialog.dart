import 'dart:convert';

import 'package:fleather/fleather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/dynamic_form_cubit.dart';
import '../model/dynamic_model.dart';

Future<dynamic> showMultiLineDialog(
    DynamicModel dynamicModel, BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext contextDialog) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(2),
        title: FleatherToolbar.basic(controller: dynamicModel.controller),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.80,
          width: MediaQuery.of(context).size.width,
          child: FleatherEditor(
            controller: dynamicModel.controller,
            scrollable: true,
            expands: true,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final text =
                  (dynamicModel.controller as FleatherController).document;
              print(jsonEncode(text.toJson()));

              return Navigator.pop(contextDialog, text);
            },
            child: Text('ok'),
          ),
        ],
      );
    },
  );
}
