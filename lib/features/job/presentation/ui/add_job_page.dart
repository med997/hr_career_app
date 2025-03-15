import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/widgets/app_bar_function.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/stepper_cubit.dart';
import 'package:hr_career_platform/features/job/presentation/widgets/add_job_stepper.dart';
import 'package:hr_career_platform/features/job/presentation/widgets/strepper_page_body_widget.dart';

import '../../../../core/app_localizations.dart';
import '../../../../core/widgets/back_conf_dialog.dart';

class AddJobPage extends StatelessWidget {
  const AddJobPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await showBackDialog(context,'close_add_page_msg') ?? false;
        if (context.mounted && shouldPop) {
          context.read<StepperCubit>().job = null;
          context.read<StepperCubit>().tender = null;
          context.read<StepperCubit>().package = null;
          context.read<StepperCubit>().addJobChangeStep(0);
          context.read<StepperCubit>().addTenderChangeStep(0);
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: buildAppBar(
          userName: "add_job_msg".tr(),
          img: '',
          fullHeader: false,
          userOrCompany: 'User',
          context: context,

        ),
        body: Flex(
          direction: Axis.vertical,
          children: [
            AddJobStepper(),
            Flexible(
              fit: FlexFit.tight,
              child: BlocBuilder<StepperCubit, StepperState>(
                builder: (context, state) {
                  return stepperAddJobPageBody(state.activeStep);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
