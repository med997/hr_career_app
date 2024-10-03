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
          steps: const [
            EasyStep(icon: Icon(Icons.add), title: 'add Job'),
            EasyStep(icon: Icon(Icons.card_membership), title: 'chose package'),
            EasyStep(icon: Icon(Icons.payment), title: 'payment'),
          ],
          onStepReached: (index) =>
              context.read<StepperCubit>().changeStep(index),
        );
      },
    );
  }
}
