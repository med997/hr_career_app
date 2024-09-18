import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hr_career_platform/features/home/presentation/widgets/recent_tenders.dart';
import '../../../../core/app_localizations.dart';
import '../../../../core/widgets/sub-title.dart';
import '../../../job/presentation/ui/all_jobs_page.dart';
import '../widgets/featured_jobs.dart';
import '../widgets/recent_jobs.dart';

class HomeTenderPage extends StatelessWidget {
  const HomeTenderPage({super.key});

  @override
  Widget build(BuildContext context) {

    return ListView(
      children: [
        SubTitle(
          onShowMoreClicked: () {
            if (kDebugMode) print('showMoreClicked');
          },
          titleType: SubTitleType.textOnly,
          title: AppLocalizations.of(context)!.translate("featured_tender_msg"),
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
          title: AppLocalizations.of(context)!.translate("recent_tender_msg"),
          icon: Icon(Icons.edit_note),
        ),
       RecentTenders()
      ],
    );
  }
}
