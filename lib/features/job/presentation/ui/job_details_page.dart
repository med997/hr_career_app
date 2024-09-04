
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:hr_career_platform/features/job/domain/entities/job.dart';
import 'package:hr_career_platform/features/job/presentation/widgets/job_details_header.dart';
import 'package:hr_career_platform/features/job/presentation/widgets/job_details_tabbar.dart';

class JobDetailsPage extends StatelessWidget {
  final Job job;
  const JobDetailsPage({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(
        direction: Axis.vertical,
        children: [
          Flexible(child: JobDetailsHeader(job: job)),
          Flexible(child: JobDetailsTabBar(job: job))
        ],
      ),
    );
  }
}
