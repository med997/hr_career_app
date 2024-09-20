import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/features/company/presentation/ui/company_details_profile_page.dart';
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
              flex: 2,
              child: JobDetailsHeader(
                job: job,
                profileFilledText: FilledButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.black12)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyProfileDetailPage( )));
                  },
                  child: Text(
                    'profile',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                profileIcoButton: IconButton(
                  onPressed: () => {},
                  icon: Icon(Icons.visibility_off_outlined, size: 18),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.orangeAccent.shade400,
                  hoverColor: Colors.orangeAccent,
                  iconSize: 18,
                  splashRadius: 12,
                ),
              )),
          Expanded(
              /*fit: FlexFit.tight,flex: 1,*/
              flex: 3,
              child: JobDetailsTabBar(job: job)),
          SizedBox(
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
                child: Text(
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
