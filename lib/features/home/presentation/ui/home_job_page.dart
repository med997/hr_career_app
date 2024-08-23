

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/widgets/search_widget.dart';
import 'package:hr_career_platform/core/widgets/sub-title.dart';
import 'package:hr_career_platform/features/home/presentation/widgets/featured_jobs.dart';
import 'package:hr_career_platform/features/home/presentation/widgets/recent_jobs.dart';
import 'package:hr_career_platform/features/job/presentation/ui/all_jobs_page.dart';

class HomeJobPage extends StatelessWidget {
  const HomeJobPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SearchWidget(),
        SubTitle(
          onShowMoreClicked: () {
            if (kDebugMode) print('showMoreClicked');
          },
          titleType: SubTitleType.textOnly,
          title: 'Featured Jobs',
          icon: Icon(Icons.edit_note),
        ),
        FeaturedJobs(),
        SubTitle(
          onShowMoreClicked: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AllJobsPage()),
            );
          },
          titleType: SubTitleType.withShowMore,
          title: 'Recent Jobs',
          icon: Icon(Icons.edit_note),
        ),
        RecentJobsWidget()
      ],
    );
  }
}
