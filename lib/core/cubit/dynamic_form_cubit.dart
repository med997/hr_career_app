import 'package:bloc/bloc.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:hr_career_platform/core/util/enums.dart';



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
  void setDisableFiled(bool disabled) {
    final currentFields = state.map((field) {
      field.disabled = disabled;
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
  void addMenuItems(String key,List<ItemModel> itemModels,String selectedItem) {
    final currentFields = state.map((field) {
      if(field.formType == FormType.subDynForm){
        field.subDynamicModel!.map((e){
          if (e.key == key) {
            e.items= itemModels;
            e.controller!.text= selectedItem;
            return e;
          }
        });
      }else{
        if (field.key == key) {

          field.items= itemModels;
          field.controller!.text= selectedItem;
          print('${field.key} ${selectedItem}');
          return field;
        }
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
        formData[field.controlName] = field.value;
      }
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