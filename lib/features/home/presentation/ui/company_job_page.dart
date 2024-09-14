import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/cubit/toggle_btn_cubit.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import '../../../../core/widgets/toggle_btn_widget.dart';
import '../widgets/recent_jobs.dart';

class CompanyJopPage extends StatelessWidget {
  const CompanyJopPage({super.key});

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
        const RecentJobsWidget(
          jobCardType: JobCardType.company,
        )
      ],
    );
  }
}
