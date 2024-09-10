import 'package:flutter/cupertino.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/util/validator.dart';

class DynamicModel {
  String controlName;
  FormType formType;
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
  Widget? action;


  DynamicModel(this.controlName, this.formType,
      { this.value,
      this.items = const [],
      this.disabled = false,
      this.selectedItem,
        this.error,
        this.controller,
        this.compareText,
      this.width = 350,
      this.helperText,
      this.isRequired = false,
      this.validators,
      this.action});
}

class ItemModel {
  String key;
  String value;

  ItemModel({required this.key, required this.value});
}
