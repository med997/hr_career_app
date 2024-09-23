import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../util/enums.dart';
import '../util/validator.dart';


class DynamicModel {
  String key;
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
  List<DynamicModel>? subDynamicModel;
  List<List<DynamicModel>>? listSubDynamicModel;
  GlobalKey<FormState>? subFormKey;
  bool?  subIsResponsive;
  String? error;
  TextEditingController? controller;
  double width;
  double? hight;
  List<DynamicFormValidator>? validators;
  Widget? action;


  DynamicModel(this.controlName, this.formType,
      { this.value,
      this.items = const [],
      this.disabled = false,
      required this.key ,
      this.selectedItem,
       this.icons,
        this.error,
        this.controller,
        this.compareText,
        this.subFormKey,
        this.listSubDynamicModel,
        this.subIsResponsive,
        this.subDynamicModel,
      this.width = 300,
      this.helperText,
      this.isRequired = false,
      this.validators });
}

class ItemModel {
  String key;
  String value;

  ItemModel({required this.key, required this.value});
}
