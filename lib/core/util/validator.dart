import 'enums.dart';

class DynamicFormValidator {
  ValidatorType type;
  String errorMessage;
  String? compareText;
  int textLength;
  DynamicFormValidator(this.type, this.errorMessage, {this.textLength = 0, this.compareText});
}