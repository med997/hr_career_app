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
import '../../../job/domain/entities/job.dart';
import '../bloc/home_cubit.dart';
import '../widgets/recent_jobs.dart';

class CompanyTendersPage extends StatelessWidget {
  const CompanyTendersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          const SizedBox(
            height: 5,
          ),
          Center(
            child: ToggleBtnWidget(
              options: const ['Archive', 'Hidden', 'Complete'],
            ),
          ),
          const RecentTenders()

        ]);
    // return ListView(
    //   children: const [
    //
    //     // RecentJobsWidget(jobCardType: JobCardType.companyTender,)
    //   ],
    // );

  }
}
