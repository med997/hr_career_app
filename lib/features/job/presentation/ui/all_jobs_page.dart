import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/widgets/app_bar_function.dart';
import 'package:hr_career_platform/core/widgets/jobCard_widget.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/features/job/domain/entities/job.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/job_cubit.dart';
import 'package:hr_career_platform/features/job/presentation/ui/job_details_page.dart';

class AllJobsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(userName: 'Jobs', img: '', fullHeader: false),
      body: BlocBuilder<JobCubit, JobState>(
        builder: (context, state) {
          if (state is JobLoadingState) {
            return const Center(
              child: LoadingWidget(),
            );
          } else if (state is JobFetchedState) {
            print('JobFetchedState');
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.jobs.length ?? 0 ,
              
                  itemBuilder: (context, index) {
                Job job = state.jobs[index];
                return InkWell(
                  onTap: () =>Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JobDetailsPage(job: job)),
                  ),
                  child: JobCard(
                      jobTitle: job.jobTitle,
                      companyName: job.company!.nameEn,
                      jobLocation: job.city,
                      companyLogo: job.company!.companyLogo ?? '',
                      jobDeadLine: '${job.deadlineDate.hour}h ago',
                      jobNationality: job.nationalities ?? ''),
                );
              }),
            );
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
    );
  }
}
