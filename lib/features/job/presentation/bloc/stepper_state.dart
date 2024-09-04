part of 'stepper_cubit.dart';

sealed class StepperState extends Equatable {
  final  int activeStep;
  const StepperState({required this.activeStep});
  @override
  List<Object> get props => [activeStep];

}

class StepperChangedState extends StepperState{
  const StepperChangedState({required super.activeStep});

}