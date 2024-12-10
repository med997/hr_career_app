import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/widgets/app_bar_function.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/stepper_cubit.dart';
import 'package:hr_career_platform/features/job/presentation/widgets/add_job_stepper.dart';
import 'package:hr_career_platform/features/job/presentation/widgets/strepper_page_body_widget.dart';

import '../../../auth/presentation/bloc/login_cubit.dart';
import '../../../home/presentation/bloc/home_cubit.dart';
import '../../../home/presentation/ui/company_home_page.dart';
import '../../../home/presentation/ui/company_main_home_page.dart';


class AddJobPage extends StatelessWidget {
  const AddJobPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: buildAppBar(
        userName: "add_job_msg".tr(),
        img: '',
        fullHeader: false,
        withBackBtn: true,
        onTap: (){
          if(context.read<StepperCubit>().state.activeStep==0){
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => HomeCompanyPage(auth: context.read<LoginCubit>().authenticatedUser!)
            ));

          }
          else {
            context.read<StepperCubit>().addJobChangeStep(
                context.read<StepperCubit>().state.activeStep - 1);
          }
        },
        userOrCompany: 'User',
        context: context,),
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
    );
  }
}