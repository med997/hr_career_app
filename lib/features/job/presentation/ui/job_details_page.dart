import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:fleather/fleather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hr_career_platform/core/app_localizations.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/features/company/presentation/ui/company_details_profile_page.dart';
import 'package:hr_career_platform/features/job/domain/entities/job.dart';
import 'package:hr_career_platform/features/job/presentation/ui/apply_now_page.dart';
import 'package:hr_career_platform/features/job/presentation/widgets/job_details_header.dart';
import 'package:hr_career_platform/features/job/presentation/widgets/job_details_tabbar.dart';
import 'package:parchment_to_html/parachment_to_html.dart';

import '../../../../core/util/responsive.dart';
import '../../../../core/widgets/sub-title.dart';

class JobDetailsPage extends StatefulWidget {
  final Job job;

  const JobDetailsPage({super.key, required this.job});

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
            child: Responsive(
                mobile: _buildMobileWidget(context),
                tablet: _buildTabletAndDesktopWidget(context),
                desktop: _buildTabletAndDesktopWidget(context))),
    );
  }

  _buildMobileWidget(
    BuildContext context,
  ) {
    return Flex(
      mainAxisAlignment: MainAxisAlignment.start,
      direction: Axis.vertical,
      children: [
        Flexible(
            flex: 2,
            child: JobDetailsHeader(
              job: widget.job,
              profileFilledText: MaterialButton(
                minWidth: 35,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.all(0),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CompanyProfileDetailPage(
                              company: widget.job.company!)));
                },
                child: const Icon(
                  Icons.person,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              profileIcoButton: MaterialButton(
                minWidth: 25,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.all(0),
                child: const Icon(
                  Icons.visibility_off_outlined,
                  size: 18,
                  color: Colors.orangeAccent,
                ),
                onPressed: () {},
              ),
            )),
        Expanded(
            /*fit: FlexFit.tight,flex: 1,*/
            flex: 3,
            child: JobDetailsTabBar(job: widget.job)),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: SizedBox(
            width: 260,
            height: 35,
            child: MaterialButton(
              color: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ApplyNowPage(
                              job: widget.job,
                            )));
              },
              child: Text(
                "apply_now_msg".tr(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }

  _buildTabletAndDesktopWidget(
    BuildContext context,
  ) {
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
    double width = 400 /*MediaQuery.of(context).size.width*/;
    return Flex(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      direction: Axis.horizontal,
      children: [
        Flex(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          direction: Axis.vertical,
          children: [
            SizedBox(
              width: 400,
              child: JobDetailsHeader(
                job: widget.job,
                profileFilledText: MaterialButton(
                  minWidth: 35,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CompanyProfileDetailPage(
                                company: widget.job.company!)));
                  },
                  child: const Icon(
                    Icons.person,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
                profileIcoButton: MaterialButton(
                  minWidth: 25,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.all(0),
                  child: const Icon(
                    Icons.visibility_off_outlined,
                    size: 18,
                    color: Colors.orangeAccent,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            SubTitle(
              title: "description_msg".tr(),
              titleType: SubTitleType.textOnly,
            ),
            Expanded(
              child: SizedBox(
                width: width,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    Padding(
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
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: SizedBox(
                width: 260,
                height: 35,
                child: MaterialButton(
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ApplyNowPage(
                                  job: widget.job,
                                )));
                  },
                  child: Text(
                    "apply_now_msg".tr(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,vertical: 16
            ),
            children: [
              SubTitle(
                title: "requirement_msg".tr(),
                titleType: SubTitleType.textOnly,
              ),

              htmlReq != null
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
              const SizedBox(
                height: 12,
              ),
              const Divider(
                height: 100,
                color: Colors.black,
                thickness:1,
                indent: 100,
                endIndent: 100,
              ),
              SubTitle(
                title: "how_to_apply_msg".tr(),
                titleType: SubTitleType.textOnly,
              ),


            ],
          ),
        )
      ],
    );
  }
}
