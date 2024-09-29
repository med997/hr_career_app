import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/core/widgets/jobCard_widget.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/home_cubit.dart';
import 'package:hr_career_platform/features/job/domain/entities/job.dart';
import 'package:hr_career_platform/features/job/presentation/ui/job_details_page.dart';

import '../../../../core/app_localizations.dart';

class RecentJobsWidget extends StatelessWidget {
 final JobCardType jobCardType;

  const RecentJobsWidget({super.key, required this.jobCardType});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return LoadingWidget();
        } else if (state is HomeFetchedState) {
          return Responsive(
              mobile: _buildMobileLayout(state.homes.recentJobs),
              tablet:
                  _buildTabletDesktopLayout(state.homes.recentJobs, 2, context),
              desktop: _buildTabletDesktopLayout(
                  state.homes.recentJobs, 3, context));
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildMobileLayout(List<Job> job) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const PageScrollPhysics(),
        itemCount: job.length ?? 0,
        itemBuilder: (context, i) => jobCardType == JobCardType.user ?JobCard(
          jobCardType: JobCardType.user,
           job: job[i],) :
        JobCard(
          jobCardType: JobCardType.company,
            chipBgColor:primaryColor,
            chipText: tr("active_msg"),
            job: job[i],));
  }

  Widget _buildTabletDesktopLayout(
      List<Job> jobs, int columnCount, BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width / columnCount -50 ;
    if(Responsive.isDesktop(context))
       itemWidth = MediaQuery.of(context).size.width / columnCount -100 ;
    return Wrap(
        children: [
      ...jobs.map(
        (job) => SizedBox(
          width: itemWidth,
          child: jobCardType == JobCardType.user ? JobCard(
              job: job,
             columnWidth: itemWidth,) : JobCard(
            jobCardType: JobCardType.company,
            job: job,
            chipText: tr("active_msg"),
            chipBgColor: primaryColor,
            columnWidth: itemWidth,
          )
        ),
      )
    ]);
  }
}
