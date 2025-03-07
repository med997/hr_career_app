import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/core/widgets/square_button_function.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/home_cubit.dart';
import 'package:hr_career_platform/features/home/presentation/widgets/recent_tenders.dart';
import 'package:hr_career_platform/features/job/domain/entities/job.dart';
import 'package:hr_career_platform/features/job/presentation/ui/add_job_page.dart';

import '../../../../core/app_localizations.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/widgets/sub-title.dart';
import '../../../tender/presentation/ui/add_tender_page.dart';
import '../widgets/recent_jobs.dart';

class CompanyMainHomePage extends StatefulWidget {
  final String authId;

  const CompanyMainHomePage({super.key, required this.authId});

  @override
  State<CompanyMainHomePage> createState() => _CompanyMainHomePageState();
}

class _CompanyMainHomePageState extends State<CompanyMainHomePage> {
  @override
  Widget build(BuildContext context) {

          return _buildMobileLayout(context);

  }


  @override
  void initState() {
    super.initState();

    context.read<HomeCubit>().getCompanyHome(widget.authId);

  }

  Widget _buildMobileLayout( BuildContext context) {

    return  RefreshIndicator(
      onRefresh: () => context.read<HomeCubit>().getCompanyHome(widget.authId),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12),
        children: [
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              squareButton(
                  clr: primaryColor,
                  icn: Icons.work_outline,
                  iconLabel: "add_job_msg".tr(),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>  const AddJobPage(),
                    ));
                  }),
              const SizedBox(
                width: 5,
              ),
              squareButton(
                  clr: Colors.yellow.shade700,
                  icn: Icons.bookmark_added_outlined,
                  iconLabel: tr("add_tender_msg"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>  const AddTenderPage(),
                    ));

                  })
            ],
          ),
          SubTitle(
            titleType: SubTitleType.textOnly,
            title: tr("recent_job_msg"),
            icon: const Icon(Icons.edit_note),
          ),
           RecentJobsWidget(jobCardType: JobCardType.company,),

          SubTitle(
            titleType: SubTitleType.textOnly,
            title: tr("recent_tender_msg"),
            icon: const Icon(Icons.edit_note),
          ),
           RecentTenders(jobCardType: JobCardType.company,)
        ],
      ),
    );
  }

  Widget _buildTabletDesktopLayout(
      List<Job> jobs, int columnCount, BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width / columnCount - 50;
    if (Responsive.isDesktop(context))
      itemWidth = MediaQuery.of(context).size.width / columnCount - 100;
    return Wrap(children: [
      squareButton(
          clr: Colors.white,
          icn: Icons.work_outline,
          iconLabel: tr("add_job_msg"),
          onTap: () {})
    ]);
  }
}
