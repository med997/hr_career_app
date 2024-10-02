import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:hr_career_platform/core/util/enums.dart';

import '../app_theme.dart';
import '../widgets/map_icon_button.dart';



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
  void setDisableFiled(bool disabled,  BuildContext?  context
      ) {
    final currentFields = state.map((field) {
      field.disabled = disabled;
      if (field.controlName =='address'){
        print(disabled);
        field.action =Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: MaterialButton(
              disabledColor: Colors.grey.shade600,
              padding: EdgeInsets.all(4),
              onPressed: disabled ==true ? null  :  () {
                Navigator.of(context!)
                    .push(MaterialPageRoute(
                  builder: (context) => LocationWidget(),
                ))
                    .then((value) {
                  context
                      .read<DynamicFormCubit>()
                      .updateValueOnly('address', value[0].toString());
                  print('cubittttttttttttttttttttttttttttttttttttttttt');

                  print(value[0]);
                  print(value[1]);
                });
              },
              shape: const CircleBorder(),
              color: primaryColor,
              child: const Icon(
                Icons.location_on_outlined,
                color: Colors.white,
                size: 18,
              )),
        );
      }
      return field;
    }).toList();
    emit(currentFields);
  }
  void updateFieldValue(DynamicModel dynamicModel) {
    final currentFields = state.map((field) {
      if (field.key == dynamicModel.key) {
        if(field.key =='confirmPassword') {
          dynamicModel.compareText=getCurrentValue()['password'];
        }
        print('${dynamicModel.key} value: ${dynamicModel.value}');
        return dynamicModel;
      }
      return field;
    }).toList();
    emit(currentFields);
  }
  void addMenuItems(DynamicModel dynamicModel,List<ItemModel> itemModels,String selectedItem) {
    print('addMenuItems');
    final currentFields = state.map((field) {
      if (field.key == dynamicModel.key) {
        dynamicModel.items= itemModels;
        // field.value = selectedItem;
          field.controller!.text= selectedItem;
        print('${field.key} ${selectedItem}');
        return dynamicModel;
      }
      return field;
    }).toList();
    emit(currentFields);
  }
  void addMenuItems2(String key,List<ItemModel> itemModels,String selectedItem) {
    print('addMenuItems');
    final currentFields = state.map((field) {
      if (field.key ==  key) {
        final dynamicModel = field;
        dynamicModel.items= itemModels;

        dynamicModel.controller!.text= selectedItem;
        print('${field.key} ${selectedItem}');
        return dynamicModel;
      }
      return field;
    }).toList();
    emit(currentFields);
  }
  void addSubFormMenuItems(String key,String subKey,List<ItemModel> itemModels) {
    final currentFields = state.map((field) {
        if (field.key == key) {
          if(field.formType == FormType.subDynForm){
           field.subDynamicModel= field.subDynamicModel!.map((e){
              if (e.key == subKey) {
                e.items= itemModels;
                 // e.controller!.text= selectedItem;
                return e;
              }
              return e;
            }).toList();
           return field;
          }
          return field;
      }
      return field;
    }).toList();
    emit(currentFields);
  }
  void updateValueOnly(String key, String value) {
    final currentFields = state.map((field) {
      if (field.key == key) {
        field.controller!.text = value;
        field.value = value;
        print('${field.controlName} ${field.value}');
        return field;
      }
      return field;
    }).toList();
    emit(currentFields);
  }

  Map<String, dynamic> getCurrentValue(){
    final formData = <String, dynamic>{};
    for (var field in state) {
      if(field.formType== FormType.date){
        formData[field.controlName]= field.controller!.value.text;
      }else if (field.formType== FormType.color){
        formData[field.controlName]= field.controller!.value.text;
      }else if(field.formType==FormType.subDynForm){
        final Map<String,dynamic> data ={} ;
        for (var e in field.subDynamicModel!) {
          data[e.controlName]=e.controller!.value.text;
        }
        formData[field.controlName]= data;
      }else if(field.formType==FormType.listSubDynForm){

        final List<Map<String,dynamic>> dataList =[] ;
        for (var element in field.listSubDynamicModel!) {
          Map<String,dynamic> data ={} ;
          for (var e in element) {
            data[e.controlName]=e.controller!.value.text;
          }
          dataList.add(data);
        }
        formData[field.controlName]= dataList;
      }
      else {
        formData[field.controlName] = field.controller!.value.text;
      }
    }
    return formData;
  }


  void removeField(DynamicModel dynamicModel) {
    final currentFields = state.where((field) =>
    field.key != dynamicModel.key).toList();
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