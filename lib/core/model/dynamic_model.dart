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
  bool disabled;
  double width;
  List<DynamicFormValidator> validators;

  DynamicModel(this.controlName, this.formType,
      {required this.value,
      this.items = const [],
      this.disabled = false,
      this.selectedItem,
      this.width = 350,
      this.helperText,
      this.isRequired = false,
      this.validators = const []});
}

class ItemModel {
  String key;
  String value;

  ItemModel({required this.key, required this.value});
}
