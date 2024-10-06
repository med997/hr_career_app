import 'dart:convert';

import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hr_career_platform/core/app_localizations.dart';
import 'package:hr_career_platform/core/cubit/toggle_btn_cubit.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:hr_career_platform/core/widgets/toggle_btn_widget.dart';
import 'package:hr_career_platform/features/job/domain/entities/job.dart';
import 'package:parchment_to_html/parachment_to_html.dart';

import '../../../../core/widgets/multi_line_dialog.dart';

class JobDetailsTabBar extends StatefulWidget {
  final Job job;

  JobDetailsTabBar({super.key, required this.job});

  @override
  State<JobDetailsTabBar> createState() => _JobDetailsTabBarState();
}

class _JobDetailsTabBarState extends State<JobDetailsTabBar> {
  @override
  Widget build(BuildContext context) {

    print(widget.job.jobReqFormated);
    final ParchmentDocument documentReq = ParchmentDocument.fromJson(jsonDecode(jsonEncode(widget.job.jobReqFormated)));
    final ParchmentDocument documentDesc = ParchmentDocument.fromJson(jsonDecode(jsonEncode(widget.job.jobDescFormated)));
     const converter = ParchmentHtmlCodec();
    String htmlReq = converter.encode(documentReq.toDelta());
    String htmlDesc = converter.encode(documentDesc.toDelta());
    return ListView(children: [
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
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Html(data: htmlDesc,),

              );
            case 1:
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Html(data: htmlReq,),

              );
            case 2:
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(''),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    ]);
  }
}
