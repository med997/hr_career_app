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
              job: job[i],) :
            jobCardType == JobCardType.company ?JobCard(
                jobCardType: JobCardType.company,
                chipBgColor:primaryColor,
                chipText: 'Active',
               job: job[i],)
                :JobCard(
                jobCardType: JobCardType.companyTender,
                chipBgColor:Colors.orange,
                chipText: 'Active',
               job: job[i],) ));
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
                job: job,
                  columnWidth: itemWidth,) : jobCardType == JobCardType.company ?JobCard(
                  jobCardType: JobCardType.company,

                  chipText: 'Active',
                  chipBgColor: primaryColor,
             job: job,
                  columnWidth: itemWidth,
                ):
                JobCard(
                  jobCardType: JobCardType.companyTender,

                  chipText: 'Active',
                  chipBgColor: Colors.orange,
                  job: job,
                  columnWidth: itemWidth,
                )
            ),
          )
        ]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<JobCubit, JobState>(
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
      ),
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
