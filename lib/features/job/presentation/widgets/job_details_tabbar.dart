import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
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
    ParchmentDocument? documentReq = widget.job.jobReqFormated != null
        ? ParchmentDocument.fromJson(
            jsonDecode(jsonEncode(widget.job.jobReqFormated)))
        : null;
    ParchmentDocument? documentDesc = widget.job.jobDescFormated != null
        ? ParchmentDocument.fromJson(
            jsonDecode(jsonEncode(widget.job.jobDescFormated)))
        : null;
    const converter = ParchmentHtmlCodec();
    String? htmlReq =
        documentReq != null ? converter.encode(documentReq.toDelta()) : null;
    String? htmlDesc =
        documentDesc != null ? converter.encode(documentDesc.toDelta()) : null;
    return Column(
      children: [
        Center(
          child: ToggleBtnWidget(
            options: [
              "description_msg".tr(),
              "requirement_msg".tr(),
              "how_to_apply_msg".tr()
            ], // Adjusted options
          ),
        ),
        Flexible(
          child: ListView(children: [
            BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
              builder: (context, state) {
                switch (state.selectedTab) {
                  case 0:
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: htmlDesc != null
                          ? Html(
                              data: htmlDesc,
                            )
                          : Text(
                              widget.job.jobDesc,
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
                      child: htmlReq != null
                          ? Html(
                              data: htmlReq,
                            )
                          : Text(
                              widget.job.jobRequirements,
                              textAlign: TextAlign.justify,
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                    );
                  case 2:
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(''),
                    );
                  default:
                    return const SizedBox();
                }
              },
            ),
          ]),
        ),
      ],
    );
  }
}
