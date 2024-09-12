import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/core/widgets/square_button_function.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/home_cubit.dart';
import 'package:hr_career_platform/features/job/domain/entities/job.dart';
import 'package:hr_career_platform/features/job/presentation/ui/add_job_page.dart';

class CompanyMainHomePage extends StatelessWidget {
  const CompanyMainHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return LoadingWidget();
        } else if (state is HomeFetchedState) {
          return Responsive(
              mobile: _buildMobileLayout(state.homes.recentJobs,context),
              tablet:
              _buildTabletDesktopLayout(state.homes.recentJobs, 2, context),
              desktop: _buildTabletDesktopLayout(
                  state.homes.recentJobs, 3, context));
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildMobileLayout(List<Job> job,BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        squareButton(clr: Colors.white, icn: Icons.work_outline, iconLabel: 'Add Job', onTap: (){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddJobPage(),));
        })
      ],
    );
  }



  Widget _buildTabletDesktopLayout(
      List<Job> jobs, int columnCount, BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width / columnCount - 50;
    if (Responsive.isDesktop(context))
      itemWidth = MediaQuery.of(context).size.width / columnCount - 100;
    return Wrap(children: [
      squareButton(clr: Colors.white, icn: Icons.work_outline, iconLabel: 'Add Job', onTap: (){})
    ]);
  }
}
