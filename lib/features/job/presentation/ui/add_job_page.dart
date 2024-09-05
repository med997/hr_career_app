import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/widgets/app_bar_function.dart';
import 'package:hr_career_platform/features/general/presentation/ui/add_job_body_page.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/stepper_cubit.dart';
import 'package:hr_career_platform/features/job/presentation/widgets/add_job_stepper.dart';
import 'package:hr_career_platform/features/job/presentation/widgets/strepper_page_body_widget.dart';
import 'package:hr_career_platform/features/payment/presentation/ui/payment_page.dart';
import 'package:hr_career_platform/features/payment/presentation/ui/pkg_Page.dart';

class AddJobPage extends StatelessWidget {
  const AddJobPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(userName: 'Job', img: '', fullHeader: false,),
      body: Flex(
        direction: Axis.vertical,
        children: [
          AddJobStepper(),
          Flexible(
            fit: FlexFit.tight,
            child: BlocBuilder<StepperCubit, StepperState>(
              builder: (context, state) {
                return stepperPageBody(state.activeStep);
              },
            ),
          )
        ],
      ),
    );
  }
}