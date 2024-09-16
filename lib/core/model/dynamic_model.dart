import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/util/validator.dart';

class DynamicModel {
  Map<String,List<DynamicModel>>? subDynModel;
  String controlName;
  InputBorder? inputBorder;
  FormType formType;
  String? value;
  String? helperText;
  List<ItemModel> items;
  ItemModel? selectedItem;
  bool isRequired;
  String? compareText;
  Icon? icons;
  bool disabled;
  String? error;
  TextEditingController? controller;
  double width;
  double? hight;
  List<DynamicFormValidator>? validators;
  Widget? action;


  DynamicModel(this.controlName, this.formType,
      { this.value,
        this.subDynModel,
        this.inputBorder,
      this.items = const [],
      this.disabled = false,
      this.selectedItem,
       this.icons,
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
