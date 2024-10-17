import 'dart:convert';

import 'package:fleather/fleather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/toggle_btn_cubit.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/features/company/domain/entities/company.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/job_cubit.dart';
import 'package:parchment_to_html/parachment_to_html.dart';

import '../../../../core/app_localizations.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/widgets/jobCard_widget.dart';
import '../../../../core/widgets/toggle_btn_widget.dart';
import '../../../job/domain/entities/job.dart';
import '../widgets/company_appbar.dart';
import '../widgets/company_gallery.dart';


class CompanyProfileDetailPage extends StatefulWidget {
  final Company company;
  const CompanyProfileDetailPage({
    super.key, required this.company,
  });

  @override
  State<CompanyProfileDetailPage> createState() => _CompanyProfileDetailPageState();
}

class _CompanyProfileDetailPageState extends State<CompanyProfileDetailPage> {
  @override
  Widget build(BuildContext context) {
    ParchmentDocument? documentAboutUs = widget.company.aboutUsFormated!=null? ParchmentDocument.fromJson(jsonDecode(jsonEncode(widget.company.aboutUsFormated))):null;
    const converter = ParchmentHtmlCodec();
    String? htmlAboutUs =  documentAboutUs!=null?converter.encode(documentAboutUs.toDelta()):null;
    return Scaffold(
      body: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.vertical,
        children: [
          CompanyAppBarWidget(
            withBackBtn:true,
              company: widget.company,
              withContactsBtn: true,
              withEditing: false,
              ),
          Center(
            child: ToggleBtnWidget(
              options: [tr("about_us_msg"), tr("jobs_msg"),tr("tenders_msg"), tr("gallery_msg"),],
            ),
          ),
          BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
          builder: (context, state) {
            switch (state.selectedTab) {
              case 0:
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: htmlAboutUs!=null?  Html(data: htmlAboutUs,):Text(
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
                return SizedBox();
              case 3:
                return CompanyGallery(widget.company);
              default:
                return const SizedBox();
            }
          },
        ),]
      ),
    );
  }


  Widget _getCompanyJobList(BuildContext context) {
    context.read<JobCubit>().getAllJobsByCompany(widget.company.id!);
    return BlocBuilder<JobCubit, JobState>(
  builder: (context, state) {
    if(state is JobFetchedState){
  List<Job> job =state.jobs;
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8),
          shrinkWrap: true,
          physics: const PageScrollPhysics(),
          itemCount: job.length ?? 0,
          itemBuilder: (context, i) =>
              JobCard(
                jobCardType: JobCardType.user,
                job: job[i],));
    }else if (state is JobLoadingState){
      return LoadingWidget(progressColor: primaryColor,width: 2,);
    }
    return const SizedBox();

  },
);
  }

}
