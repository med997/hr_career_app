import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/widgets/square_button_function.dart';
import 'package:hr_career_platform/features/home/presentation/widgets/recent_tenders.dart';
import '../../../../core/cubit/toggle_btn_cubit.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/util/responsive.dart';
import '../../../../core/widgets/jobCard_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/toggle_btn_widget.dart';
import '../../../auth/presentation/bloc/login_cubit.dart';
import '../../../job/domain/entities/job.dart';
import '../bloc/home_cubit.dart';
import '../widgets/recent_jobs.dart';

class CompanyTendersPage extends StatelessWidget {
  const CompanyTendersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh:  () => context.read<HomeCubit>().getCompanyHome(
          context.read<LoginCubit>().authenticatedUser!.userAuth!.id),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Center(
            child: ToggleBtnWidget(
              options: ['active'.tr(), 'hidden'.tr(), 'completed'.tr()],
            ),
          ),
          Flexible(
            child: ListView(children:  [
              const SizedBox(
                height: 5,
              ),
              BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
                builder: (context, state) {
                  if(state is ToggleBtnChangedState){
                    return RecentTenders(
                      jobCardType: JobCardType.company,selectedJobState: state.selectedTab,
                    );
                  } else {
                    return const SizedBox();
                  }

                },
              ),

            ]),
          ),
        ],
      ),
    );
    // return ListView(
    //   children: const [
    //
    //     // RecentJobsWidget(jobCardType: JobCardType.companyTender,)
    //   ],
    // );
  }
}
