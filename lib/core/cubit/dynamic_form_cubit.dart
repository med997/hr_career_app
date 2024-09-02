import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/util/validator.dart';
import 'package:meta/meta.dart';



class DynamicFormCubit extends Cubit<List<DynamicModel>> {
  DynamicFormCubit() : super([]);

  void addField(DynamicModel dynamicModel) {
    final currentFields = List<DynamicModel>.from(state);
    currentFields.add(dynamicModel);
    emit(currentFields);
  }

  void addAllFields(List<DynamicModel> dynamicModel) {
    final currentFields = dynamicModel;
    emit(currentFields);
  }

  void updateFieldValue(DynamicModel dynamicModel) {
    final currentFields = state.map((field) {
      if (field.controlName == dynamicModel.controlName) {
        if(field.controlName =='confirmPassword') {
          dynamicModel.compareText=getCurrentValue()['password'];
        }
        print('${dynamicModel.controlName} value: ${dynamicModel.value}');
        return dynamicModel;
      }
      return field;
    }).toList();
    emit(currentFields);
  }

  Map<String, dynamic> getCurrentValue(){
    final formData = <String, dynamic>{};
    for (var field in state) {
      formData[field.controlName] = field.value;
    }
    return formData;
  }

  String? _validateField(DynamicModel dynamicModel) {
    dynamicModel.validators!.map((e) {
      if (e.type == ValidatorType.notEmpty) {
        if (dynamicModel.value==null || dynamicModel.value!.isEmpty) {
          return e.errorMessage;
        }
      }
      if (e.type == ValidatorType.textLength) {
        if (dynamicModel.value!.length!= e.textLength) {
          return e.errorMessage;
        }
    }
    },);
    return null;
    // No error
  }

  void removeField(DynamicModel dynamicModel) {
    final currentFields = state.where((field) =>
    field.controlName != dynamicModel.controlName).toList();

    emit(currentFields);
  }

  void removeAllField() {
    state.clear();
    final currentFields = <DynamicModel>[];
    emit(currentFields);
  }
  void replaceAll(List<DynamicModel> dynamicModel) {
    final currentFields =dynamicModel;
    emit(currentFields);
  }
}