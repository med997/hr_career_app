import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:fleather/fleather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/toggle_btn_cubit.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/features/company/domain/entities/company.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/home_cubit.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/job_cubit.dart';
import 'package:hr_career_platform/features/tender/presentation/bloc/curd_tender_cubit.dart';
import 'package:parchment_to_html/parachment_to_html.dart';

import '../../../../core/app_localizations.dart';
import '../../../../core/strings/failures.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/util/responsive.dart';
import '../../../../core/widgets/err_widget.dart';
import '../../../../core/widgets/jobCard_widget.dart';
import '../../../../core/widgets/sub-title.dart';
import '../../../../core/widgets/tender_card_widget.dart';
import '../../../../core/widgets/toggle_btn_widget.dart';
import '../../../home/presentation/widgets/recent_tenders.dart';
import '../../../job/domain/entities/job.dart';
import '../../../tender/domain/entities/tender.dart';
import '../../../tender/presentation/ui/tender_detail_page.dart';
import '../widgets/company_appbar.dart';
import '../widgets/company_gallery.dart';

class CompanyProfileDetailPage extends StatefulWidget {
  final Company company;

  const CompanyProfileDetailPage({
    super.key,
    required this.company,
  });

  @override
  State<CompanyProfileDetailPage> createState() =>
      _CompanyProfileDetailPageState();
}

class _CompanyProfileDetailPageState extends State<CompanyProfileDetailPage> {
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

  Widget _getCompanyJobList(BuildContext context) {
    context.read<JobCubit>().getAllJobsByCompany(widget.company.id!);
    return BlocBuilder<JobCubit, JobState>(
      builder: (context, state) {
        if (state is JobFetchedState) {
          List<Job> job = state.jobs;
          return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              shrinkWrap: true,
              physics: const PageScrollPhysics(),
              itemCount: job.length ?? 0,
              itemBuilder: (context, i) => JobCard(
                    jobCardType: JobCardType.user,
                    job: job[i],
                  ));
        } else if (state is JobLoadingState) {
          return LoadingWidget(
            progressColor: primaryColor,
            width: 2,
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _getCompanyTenderbList(BuildContext context) {
    context.read<HomeCubit>().getCompanyHome(widget.company.id!);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeFetchedState) {
          List<Tender>? tender = state.homes.recentTender;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            shrinkWrap: true,
            physics: const PageScrollPhysics(),
            itemCount: tender!.length ?? 0,
            itemBuilder: (context, i) => InkWell(
              child: TenderCard(tender: tender[i]),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return TenderDetailsPage(tender: tender[i]);
                }),
              ),
            ),
          );
        } else if (state is HomeLoading) {
          return LoadingWidget(
            progressColor: primaryColor,
            width: 2,
          );
        }
        return const SizedBox();
      },
    );
  }

  _buildMobileWidget(
    BuildContext context,
  ) {
    ParchmentDocument? documentAboutUs = widget.company.aboutUsFormated != null
        ? ParchmentDocument.fromJson(
            jsonDecode(jsonEncode(widget.company.aboutUsFormated)))
        : null;
    const converter = ParchmentHtmlCodec();
    String? htmlAboutUs = documentAboutUs != null
        ? converter.encode(documentAboutUs.toDelta())
        : null;
    return Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.vertical,
        children: [
          CompanyAppBarWidget(
            withBackBtn: true,
            company: widget.company,
            withContactsBtn: true,
            withEditing: false,
            useMobile: true,
          ),
          Center(
            child: ToggleBtnWidget(
              options: [
                "about_us_msg".tr(),
                "jobs_msg".tr(),
                "tenders_msg".tr(),
                "gallery_msg".tr(),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
                  builder: (context, state) {
                    switch (state.selectedTab) {
                      case 0:
                        return Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: htmlAboutUs != null
                                ? Html(
                                    data: htmlAboutUs,
                                  )
                                : Text(
                                    widget.company.aboutUs,
                                    textAlign: TextAlign.justify,
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                          ),
                        );
                      case 1:
                        return _getCompanyJobList(context);
                      case 2:
                        return _getCompanyTenderbList(context);
                      case 3:
                        return CompanyGallery(widget.company);
                      default:
                        return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ]);
  }

  _buildTabletAndDesktopWidget(
    BuildContext context,
  ) {
    ParchmentDocument? documentAboutUs = widget.company.aboutUsFormated != null
        ? ParchmentDocument.fromJson(
            jsonDecode(jsonEncode(widget.company.aboutUsFormated)))
        : null;
    const converter = ParchmentHtmlCodec();
    String? htmlAboutUs = documentAboutUs != null
        ? converter.encode(documentAboutUs.toDelta())
        : null;
    double width = 400 /*MediaQuery.of(context).size.width*/;
    return Flex(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      direction: Axis.horizontal,
      children: [
        Flex(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          direction: Axis.vertical,
          children: [
            SizedBox(
              width: 400,
              child: CompanyAppBarWidget(
                withBackBtn: true,
                company: widget.company,
                withContactsBtn: true,
                withEditing: false,
                useMobile: true,
              ),
            ),
            SubTitle(
              title: "about_us_msg".tr(),
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
                      child: htmlAboutUs != null
                          ? Html(
                              data: htmlAboutUs,
                            )
                          : Text(
                              widget.company.aboutUs,
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
          ],
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            children: [
              SubTitle(
                title: "jobs_msg".tr(),
                titleType: SubTitleType.textOnly,
              ),
              _getCompanyJobList(context),
              const Divider(
                height: 100,
                color: Colors.black,
                thickness: 2,
                indent: 100,
                endIndent: 100,
              ),
              SubTitle(
                title: "tenders_msg".tr(),
                titleType: SubTitleType.textOnly,
              ),

              //Tenders here
              _getCompanyTenderbList(context),

              const Divider(
                height: 100,
                color: Colors.black,
                thickness: 2,
                indent: 100,
                endIndent: 100,
              ),
              SubTitle(
                title: "gallery_msg".tr(),
                titleType: SubTitleType.textOnly,
              ),
              CompanyGallery(widget.company)
            ],
          ),
        )
      ],
    );
  }
}
