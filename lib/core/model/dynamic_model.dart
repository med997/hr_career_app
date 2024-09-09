import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/util/validator.dart';

class DynamicModel {
  String controlName;
  FormType formType;
  Icon? icons;
  bool withAction;
  String? value;
  String? helperText;
  List<ItemModel> items;
  ItemModel? selectedItem;
  bool isRequired;
  String? compareText;
  bool disabled;
  String? error;
  TextEditingController? controller;
  double width;
  List<DynamicFormValidator>? validators;

  DynamicModel(this.controlName, this.formType,
      { this.value,
        this.icons,
        this.withAction = false,
      this.items = const [],
      this.disabled = false,
      this.selectedItem,
        this.error,
        this.controller,
        this.compareText,
      this.width = 350,
      this.helperText,
      this.isRequired = false,
      this.validators });
}

class ItemModel {
  String key;
  String value;

  ItemModel({required this.key, required this.value});
}
