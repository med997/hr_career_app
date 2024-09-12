import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/widgets/square_button_function.dart';
import '../../../../core/cubit/toggle_btn_cubit.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/util/responsive.dart';
import '../../../../core/widgets/jobCard_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/toggle_btn_widget.dart';
import '../../../job/domain/entities/job.dart';
import '../bloc/home_cubit.dart';

class CompanyTendersPage extends StatelessWidget {
  const CompanyTendersPage({super.key});

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
    return Column(
      children: [
        ToggleBtnWidget(
          options: ['active', 'hidden', 'complete'],
        ),
        const SizedBox(
          height: 5,
        ),
        BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
          builder: (context, state) {
            return ListView.builder(
                shrinkWrap: true,
                physics: const PageScrollPhysics(),
                itemCount: job.length ?? 0,
                itemBuilder: (context, i) => InkWell(
                    child: state.selectedTab == 0
                        ? JobCard(
                            jobCardType: JobCardType.companyTender,
                            createdAt: job[i].createdAt,
                            jobTitle: job[i].jobTitle,
                            companyName: job[i].company!.nameEn ,
                            companyLogo: job[i].company!.companyLogo ?? '',
                            jobDeadLine: '${job[i].deadlineDate.hour}h ago',
                            jobNationality: job[i].nationalities ?? '',
                            jobLocation: '',
                          )
                        : state.selectedTab == 1
                            ? JobCard(
                                jobCardType: JobCardType.companyTender,
                                jobTitle: job[i].jobTitle,
                                createdAt: job[i].createdAt,
                                companyName: job[i].company!.nameEn ,
                                jobLocation: '',
                                companyLogo: job[i].company!.companyLogo ?? '',
                                jobDeadLine: '${job[i].deadlineDate.hour}h ago',
                                jobNationality: '')
                            : JobCard(
                                jobCardType: JobCardType.companyTender,
                                jobTitle: job[i].jobTitle,
                                createdAt: job[i].createdAt,
                                companyName: job[i].company!.nameEn,
                                jobLocation: job[i].city,
                                companyLogo: job[i].company!.companyLogo ?? '',
                                jobDeadLine: '${job[i].deadlineDate.hour}h ago',
                                jobNationality: job[i].nationalities ?? '')));
          },
        ),],
    );
  }



  Widget _buildTabletDesktopLayout(
      List<Job> jobs, int columnCount, BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width / columnCount - 50;
    if (Responsive.isDesktop(context))
      itemWidth = MediaQuery.of(context).size.width / columnCount - 100;
    return Wrap(children: [
      ToggleBtnWidget(
        options: ['active', 'hidden', 'complete'],
      ),
      ...jobs.map(
        (job) => BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
          builder: (context, state) {
            return SizedBox(
                width: itemWidth,
                child: state.selectedTab == 0
                    ? JobCard(
                        jobCardType: JobCardType.companyTender,
                        jobTitle: job.jobTitle,
                        createdAt: job.createdAt,
                        companyName: job.company!.nameEn ,
                        jobLocation: '',
                        companyLogo: job.company!.companyLogo ?? '',
                        jobDeadLine: '${job.deadlineDate.hour}h ago',
                        jobNationality: '',
                        columnWidth: itemWidth,
                      )
                    : state.selectedTab == 1
                        ? JobCard(
                            jobCardType: JobCardType.companyTender,
                            jobTitle: job.jobTitle,
                            createdAt: job.createdAt,
                            companyName:
                                job.company!.nameEn ,
                            jobLocation: '',
                            companyLogo: job.company!.companyLogo ?? '',
                            jobDeadLine: '${job.deadlineDate.hour}h ago',
                            jobNationality: '',
                            columnWidth: itemWidth,
                          )
                        : JobCard(
                            jobCardType: JobCardType.companyTender,
                            jobTitle: job.jobTitle,
                            createdAt: job.createdAt,
                            companyName:
                                job.company!.nameEn ,
                            jobLocation: '',
                            companyLogo: job.company!.companyLogo ?? '',
                            jobDeadLine: '${job.deadlineDate.hour}h ago',
                            jobNationality: '',
                            columnWidth: itemWidth,
                          ));
          },
        ),
      )
    ]);
  }
}
