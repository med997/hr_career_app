import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/widgets/app_bar_function.dart';
import 'package:hr_career_platform/core/widgets/jobCard_widget.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/features/job/domain/entities/job.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/job_cubit.dart';
import 'package:hr_career_platform/features/job/presentation/ui/job_details_page.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/util/responsive.dart';

class AllJobsPage extends StatelessWidget {

  Widget _buildMobileLayout(List<Job> job,JobCardType jobCardType) {
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
            child: jobCardType == JobCardType.user ?JobCard(
                jobCardType: JobCardType.user,
                jobTitle: job[i].jobTitle,
                companyName: job[i].company!.nameEn ,
                jobLocation: job[i].city,
                companyLogo: job[i].company!.companyLogo ?? '',
                jobDeadLine: '${job[i].deadlineDate.hour}h ago',
                jobNationality: job[i].nationalities ?? '') :
            jobCardType == JobCardType.company ?JobCard(
                jobCardType: JobCardType.company,
                chipBgColor:primaryColor,
                chipText: 'Active',
                jobTitle: job[i].jobTitle,
                companyName: job[i].company!.nameEn ,
                jobLocation: job[i].city,
                companyLogo: job[i].company!.companyLogo ?? '',
                jobDeadLine: '${job[i].deadlineDate.hour}h ago',
                jobNationality: job[i].nationalities ?? '')
                :JobCard(
                jobCardType: JobCardType.companyTender,
                chipBgColor:Colors.orange,
                chipText: 'Active',
                jobTitle: job[i].jobTitle,
                companyName: job[i].company!.nameEn ,
                jobLocation: job[i].city,
                companyLogo: job[i].company!.companyLogo ?? '',
                jobDeadLine: '${job[i].deadlineDate.hour}h ago',
                jobNationality: job[i].nationalities ?? '') ));
  }

  Widget _buildTabletDesktopLayout(
      List<Job> jobs, int columnCount, BuildContext context,JobCardType jobCardType) {
    double itemWidth = MediaQuery.of(context).size.width / columnCount -50 ;
    if(Responsive.isDesktop(context))
      itemWidth = MediaQuery.of(context).size.width / columnCount -100 ;
    return Wrap(
        children: [
          ...jobs.map(
                (job) => SizedBox(
                width: itemWidth,
                child: jobCardType == JobCardType.user ? JobCard(
                  jobTitle: job.jobTitle,
                  companyName: job.company!.nameEn,
                  jobLocation: job.city,
                  companyLogo: job.company!.companyLogo ?? '',
                  jobDeadLine: '${job.deadlineDate.hour}h ago',
                  jobNationality: job.nationalities ?? '',
                  columnWidth: itemWidth,) : jobCardType == JobCardType.company ?JobCard(
                  jobCardType: JobCardType.company,
                  jobTitle: job.jobTitle,
                  chipText: 'Active',
                  chipBgColor: primaryColor,
                  companyName: job.company!.nameEn,
                  jobLocation: job.city,
                  companyLogo: job.company!.companyLogo ?? '',
                  jobDeadLine: '${job.deadlineDate.hour}h ago',
                  jobNationality: job.nationalities ?? '',
                  columnWidth: itemWidth,
                ):
                JobCard(
                  jobCardType: JobCardType.companyTender,
                  jobTitle: job.jobTitle,
                  chipText: 'Active',
                  chipBgColor: Colors.orange,
                  companyName: job.company!.nameEn,
                  jobLocation: job.city,
                  companyLogo: job.company!.companyLogo ?? '',
                  jobDeadLine: '${job.deadlineDate.hour}h ago',
                  jobNationality: job.nationalities ?? '',
                  columnWidth: itemWidth,
                )
            ),
          )
        ]);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobCubit, JobState>(
        builder: (context, state) {
                if (state is JobLoadingState) {
                  return  Center(
                    child: LoadingWidget(),
                  );
                } else if (state is JobFetchedState) {
            print('JobFetchedState');
            return Responsive(
                mobile: _buildMobileLayout(state.jobs, JobCardType.user),
                tablet:
                _buildTabletDesktopLayout(state.jobs, 2, context,JobCardType.user),
                desktop:  _buildTabletDesktopLayout(state.jobs, 3, context,JobCardType.user),);
          } else if (state is JobErrorState) {
            print('JobErrorState');
            return Text(
              state.msg,
              style: TextStyle(color: Colors.red),
            );
          }
          return SizedBox();
        },
      );
  }
}
/*
return Scaffold(
appBar: buildAppBar(userName: 'Jobs', img: '', fullHeader: false),
body: BlocBuilder<JobCubit, JobState>(
builder: (context, state) {
if (state is JobLoadingState) {
return  Center(
child: LoadingWidget(),
);
} else if (state is JobFetchedState) {
print('JobFetchedState');
return Responsive(
mobile: _buildMobileLayout(state.jobs, JobCardType.user),
tablet:
_buildTabletDesktopLayout(state.jobs, 2, context,JobCardType.user),
desktop:  _buildTabletDesktopLayout(state.jobs, 3, context,JobCardType.user),);
} else if (state is JobErrorState) {
print('JobErrorState');
return Text(
state.msg,
style: TextStyle(color: Colors.red),
);
}
return SizedBox();
},
),
);*/
