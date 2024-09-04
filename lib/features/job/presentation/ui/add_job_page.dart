import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/widgets/app_bar_function.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/stepper_cubit.dart';
import 'package:hr_career_platform/features/job/presentation/widgets/add_job_stepper.dart';
import 'package:hr_career_platform/features/payment/presentation/ui/payment_page.dart';

class AddJobPage extends StatelessWidget {
  const AddJobPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(userName: 'Job', img: '', fullHeader: false),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AddJobStepper(),
          BlocBuilder<StepperCubit, StepperState>(
            builder: (context, state) {
              return _stepperPageBody(state.activeStep);
            },
          )

        ],),
    );
  }

  Widget _stepperPageBody(int selectedTab) {
    switch (selectedTab) {
      case 0:
        return const PaymentPage();
      case 1:
        return const SizedBox();

      default:
        return const SizedBox();
    }
  }
}
