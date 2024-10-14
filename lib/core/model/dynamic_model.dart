import 'package:fleather/fleather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
   Widget? subFormHeader;
   Widget? subFormFooter;
   Function? onSubmit;
  String? compareText;
  Icon? icons;
  bool disabled;
  List<DynamicModel>? subDynamicModel;
  List<List<DynamicModel>>? listSubDynamicModel;
  GlobalKey<FormState>? subFormKey;
  bool?  subIsResponsive;
  TextInputAction? inputAction;
  String? error;
  TextEditingController? controller;
  FleatherController? controllerFlt;
  double? width;
  double? padding;
  double? hight;
  List<DynamicFormValidator>? validators;
  Widget? action;

  DynamicModel(this.controlName, this.formType,
      {this.value,
      this.items = const [],
      this.disabled = false,
      this.key = '',
      this.selectedItem,
      this.icons,
      this.error,
      this.controller,
      this.controllerFlt,
      this.padding,
      this.inputAction,
      this.action,
      this.compareText,
      this.subFormKey,
      this.onSubmit,
      this.subFormHeader,
      this.subFormFooter,
      this.listSubDynamicModel,
      this.subIsResponsive,
      this.subDynamicModel,
      this.width = 300,
      this.helperText,
      this.inputBorder,
      this.isRequired = false,
      this.validators});
}

class ItemModel {
  String key;
  String value;

  ItemModel({required this.key, required this.value});
}
