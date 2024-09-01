import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/core/widgets/jobCard_widget.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/home_cubit.dart';
import 'package:hr_career_platform/features/job/domain/entities/job.dart';
import 'package:hr_career_platform/features/job/presentation/ui/job_details_page.dart';

class RecentJobsWidget extends StatelessWidget {
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
        return Placeholder();
      },
    );
  }

  Widget _buildMobileLayout(List<Job> job) {
    return ListView.builder(
        shrinkWrap: true,
        physics: PageScrollPhysics(),
        itemCount: job.length ?? 0,
        itemBuilder: (context, i) => InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => JobDetailsPage(job: job[i])),
              ),
              child: JobCard(
                  jobTitle: job[i].jobTitle,
                  companyName: job[i].company!.nameEn ,
                  jobLocation: job[i].city,
                  companyLogo: job[i].company!.companyLogo ?? '',
                  jobDeadLine: '${job[i].deadlineDate.hour}h ago',
                  jobNationality: job[i].nationalities ?? ''),
            ));
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
          child: JobCard(
              jobTitle: job.jobTitle,
              companyName: job.company!.nameEn,
              jobLocation: job.city,
              companyLogo: job.company!.companyLogo ?? '',
              jobDeadLine: '${job.deadlineDate.hour}h ago',
              jobNationality: job.nationalities ?? '',
          columnWidth: itemWidth,),
        ),
      )
    ]);
  }
}
