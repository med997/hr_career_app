import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hr_career_platform/features/payment/domain/entities/package.dart';
import 'package:hr_career_platform/features/tender/domain/entities/tender.dart';

import '../../domain/entities/job.dart';

part 'stepper_state.dart';

class StepperCubit extends Cubit<StepperState> {
  Job? job;
  Tender? tender;
  Package? package;

  StepperCubit() : super(const StepperChangedState(activeStep: 0));

  Future<void> addJobChangeStep(int tabIndex,
      {Job? addedJob, Package? selectedPackage}) async {
    if(addedJob!=null) {
      job = addedJob;
    }
    if(selectedPackage!=null){
      package = selectedPackage;
    }

    emit(StepperChangedState(activeStep: tabIndex));
  }

  Future<void> backStep(int tabIndex,) async {

    emit(StepperChangedState(activeStep: tabIndex-1));
  }

  Future<void> addTenderChangeStep(int tabIndex,
      {Tender? addedTender, Package? selectedPackage}) async {
    if(addedTender!=null) {
      tender = addedTender;
    }
    if(selectedPackage!=null){
      package = selectedPackage;
    }

    emit(StepperChangedState(activeStep: tabIndex));
  }

}
