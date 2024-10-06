import 'dart:convert';

import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_localizations.dart';
import 'package:hr_career_platform/core/cubit/toggle_btn_cubit.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:hr_career_platform/core/widgets/toggle_btn_widget.dart';
import 'package:hr_career_platform/features/job/domain/entities/job.dart';

import '../../../../core/widgets/multi_line_dialog.dart';

class JobDetailsTabBar extends StatelessWidget {
  final Job job;

   JobDetailsTabBar({super.key, required this.job});
  // final document = ParchmentDocument.fromJson([job.jobDescFormated]);
  // final controller = FleatherController(document);

  @override
  Widget build(BuildContext context) {
    final data = job.jobDescFormated as Map<String, dynamic>;
    final jsonData = data['job_desc_formated'] as List<dynamic>;
    final p = ParchmentDocument.fromJson(jsonData);
    print(p);
    return ListView(
      children: [
        Center(
          child: ToggleBtnWidget(
            options: [
              tr("description_msg"),
              tr("requirement_msg"),
              tr("how_to_apply_msg")
            ], // Adjusted options
          ),
        ),
        BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
        builder: (context, state) {

          switch (state.selectedTab) {
            case 0:
              return  Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
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
            case 1:
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
