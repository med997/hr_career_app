import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import '../../../../core/util/responsive.dart';
import '../../../../core/widgets/jobCard_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../job/domain/entities/job.dart';
import '../../../job/presentation/ui/job_details_page.dart';
import '../bloc/home_cubit.dart';

class RecentTenders extends StatelessWidget {
  const RecentTenders({super.key});

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
  }}

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
          jobCardType: JobCardType.userTender,
            job: job[i],),
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
              job: job,
              jobCardType: JobCardType.userTender,
              columnWidth: itemWidth,),
          ),
        )
      ]);
}