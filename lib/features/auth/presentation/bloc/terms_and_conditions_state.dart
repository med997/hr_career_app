part of 'terms_and_conditions_cubit.dart';

@immutable
 class TermsAndConditionsState extends Equatable{
  @override
  List<Object?> get props => [];
}

class TermsAndConditionsInitial extends TermsAndConditionsState {}

class TermsAndConditionsChecked extends TermsAndConditionsState {
  final bool isChecked;
  TermsAndConditionsChecked(this.isChecked);
}
