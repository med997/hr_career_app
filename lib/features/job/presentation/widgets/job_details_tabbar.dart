import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/cubit/toggle_btn_cubit.dart';
import 'package:hr_career_platform/core/widgets/toggle_btn_widget.dart';
import 'package:hr_career_platform/features/job/domain/entities/job.dart';

import '../../../../core/app_theme.dart';

class JobDetailsTabBar extends StatelessWidget {
  final Job job;

  const JobDetailsTabBar({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: ToggleBtnWidget(
            options: const [
              'Description',
              'Requirement',
              'How to apply?'
            ], // Adjusted options
          ),
        ),
        BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
        builder: (context, state) {
          switch (state.selectedTab) {
            case 0:
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  job.jobRequirements,
                  textAlign: TextAlign.justify,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              );
            case 1:
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  job.jobDesc,
                  textAlign: TextAlign.justify,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              );
            case 2:
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  job.jobDesc,
                  textAlign: TextAlign.justify,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    ]);
  }
}
