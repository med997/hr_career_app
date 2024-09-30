import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hr_career_platform/features/payment/domain/entities/package.dart';

import '../../domain/entities/job.dart';

part 'stepper_state.dart';

class StepperCubit extends Cubit<StepperState> {
  Job? job;
  Package? package;

  StepperCubit() : super(const StepperChangedState(activeStep: 0));

  Future<void> changeStep(int tabIndex,
      {Job? addedJob, Package? selectedPackage}) async {
    job = addedJob;
    package = selectedPackage;
    emit(StepperChangedState(activeStep: tabIndex));
  }
}
