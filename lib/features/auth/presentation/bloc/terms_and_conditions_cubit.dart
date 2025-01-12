import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'terms_and_conditions_state.dart';

class TermsAndConditionsCubit extends Cubit<TermsAndConditionsState> {
  TermsAndConditionsCubit() : super(TermsAndConditionsUnchecked());

  void toggleCheckbox(bool isChecked) {
    if (isChecked) {
      emit(TermsAndConditionsChecked());
    } else {
      emit(TermsAndConditionsUnchecked());
    }
  }
}