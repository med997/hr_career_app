
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/util/enums.dart';

import '../../../../core/app_localizations.dart';
import '../../../../core/widgets/app_bar_function.dart';
import '../../../../core/widgets/back_conf_dialog.dart';
import '../../../job/presentation/bloc/stepper_cubit.dart';
import '../../../job/presentation/widgets/add_job_stepper.dart';
import '../../../payment/presentation/ui/payment_page.dart';
import '../../../payment/presentation/ui/pkg_Page.dart';
import 'add_tender_body_page.dart';

class AddTenderPage extends StatelessWidget {
  const AddTenderPage({super.key});

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

        appBar: buildAppBar(userName: "add_tender_msg".tr(), img: '', fullHeader: false, userOrCompany: 'User', context: context,),
        body: Flex(
          direction: Axis.vertical,
          children: [
            AddJobStepper(),

            Flexible(
              fit: FlexFit.tight,
              child: BlocBuilder<StepperCubit, StepperState>(
                builder: (context, state) {
                  return stepperAddTenderPageBody(state.activeStep);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget stepperAddTenderPageBody(int selectedTab) {
    switch (selectedTab) {
      case 0:
        return const AddTenderBodyPage();
      case 1:
        return const PkgPage(pkgType: PkgType.tender,);
      case 2:
        return  const PaymentPage(pkgType: PkgType.tender,);
      default:
        return const SizedBox();
    }
  }

}