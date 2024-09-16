import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:hr_career_platform/core/app_theme.dart';
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
        mainAxisAlignment: MainAxisAlignment.start,
        direction: Axis.vertical,
        children: [
          Flexible(
              flex: 1,
              child: JobDetailsHeader(
                job: job,
                profileFilledText: FilledButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.black12)),
                  onPressed: () {},
                  child: const Text(
                    'profile',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                profileIcoButton: IconButton(
                  onPressed: () => {},
                  icon: const Icon(Icons.visibility_off_outlined, size: 18),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.orangeAccent.shade400,
                  hoverColor: Colors.orangeAccent,
                  iconSize: 18,
                  splashRadius: 12,
                ),
              )),
          Expanded(
              /*fit: FlexFit.tight,flex: 1,*/
              flex: 2,
              child: JobDetailsTabBar(job: job)),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: SizedBox(
              width: 260,
              height: 35,
              child: MaterialButton(
                color: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                onPressed: () {},
                child: const Text(
                  'Apply now',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
