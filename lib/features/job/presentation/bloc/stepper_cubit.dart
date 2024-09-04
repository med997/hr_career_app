import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stepper_state.dart';

class StepperCubit extends Cubit<StepperState> {
  StepperCubit() : super(const StepperChangedState(activeStep: 0));
  Future<void> changeStep(int tabIndex) async {
    emit(StepperChangedState(activeStep: tabIndex));


  }
}
