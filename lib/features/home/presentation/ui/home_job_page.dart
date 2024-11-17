

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/widgets/search_widget.dart';
import 'package:hr_career_platform/core/widgets/sub-title.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/tab_nav_cubit.dart';
import 'package:hr_career_platform/features/home/presentation/widgets/featured_jobs.dart';
import 'package:hr_career_platform/features/home/presentation/widgets/recent_jobs.dart';
import 'package:hr_career_platform/features/job/presentation/ui/all_jobs_page.dart';

import '../../../../core/app_localizations.dart';
import '../bloc/home_cubit.dart';

class HomeJobPage extends StatefulWidget {
  const HomeJobPage({super.key});

  @override
  State<HomeJobPage> createState() => _HomeJobPageState();
}

class _HomeJobPageState extends State<HomeJobPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => context.read<HomeCubit>().getUserHome(),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          children: [
            // SearchWidget(),
            SubTitle(
              onShowMoreClicked: () {
                if (kDebugMode) print('showMoreClicked');
              },
              titleType: SubTitleType.textOnly,
              title: "featured_job_msg".tr(),
              icon: Icon(Icons.edit_note),
            ),
            FeaturedJobs(),
            SubTitle(
              onShowMoreClicked: () {
                context.read<TabNavCubit>().changeTab(2);
              },
              titleType: SubTitleType.withShowMore,
              title: tr("recent_job_msg"),
              icon: Icon(Icons.edit_note),
            ),
            RecentJobsWidget(jobCardType: JobCardType.user,)
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getUserHome();

  }
}
