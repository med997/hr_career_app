import 'package:easy_localization/easy_localization.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/stepper_cubit.dart';

class AddJobStepper extends StatelessWidget {
  AddJobStepper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepperCubit, StepperState>(
      builder: (context, state) {
        return EasyStepper(
          activeStep: state.activeStep,
          stepShape: StepShape.rRectangle,
          stepBorderRadius: 12,
          borderThickness: 2,
          stepRadius: 28,
          fitWidth: true,
          enableStepTapping: false,
          unreachedStepIconColor: Colors.grey,
          finishedStepBorderColor: primaryColor,
          finishedStepTextColor: primaryColor,
          finishedStepIconColor: Colors.white,
          finishedStepBackgroundColor: primaryColor,
          activeStepTextColor: primaryColor,
          activeStepBorderColor: primaryColor,
          activeStepIconColor: primaryColor,
          showLoadingAnimation: false,
          steps:  [
            EasyStep(icon: const Icon(Icons.add), title: 'information'.tr()),
            EasyStep(icon: const Icon(Icons.card_membership), title: 'selectPackage'.tr()),
            EasyStep(icon: const Icon(Icons.payment), title: 'payment'.tr()),
          ],
          onStepReached: (index) =>
              context.read<StepperCubit>().addJobChangeStep(index),
        );
      },
    );
  }
}
