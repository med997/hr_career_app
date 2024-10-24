import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/features/home/presentation/widgets/featured_tenders.dart';
import 'package:hr_career_platform/features/home/presentation/widgets/recent_tenders.dart';
import '../../../../core/app_localizations.dart';
import '../../../../core/widgets/sub-title.dart';
import '../../../job/presentation/ui/all_jobs_page.dart';
import '../bloc/home_cubit.dart';
import '../widgets/featured_jobs.dart';
import '../widgets/recent_jobs.dart';

class HomeTenderPage extends StatefulWidget {
  const HomeTenderPage({super.key});

  @override
  State<HomeTenderPage> createState() => _HomeTenderPageState();
}

class _HomeTenderPageState extends State<HomeTenderPage> {



  @override
  Widget build(BuildContext context) {

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      children: [
        SubTitle(
          textColor: Colors.black,
          onShowMoreClicked: () {
            if (kDebugMode) print('showMoreClicked');
          },
          titleType: SubTitleType.textOnly,
          title: tr("featured_tender_msg"),
          icon: Icon(Icons.edit_note),
        ),
        FeaturedTenders(),
        SubTitle(
          onShowMoreClicked: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AllJobsPage()),
            );
          },
          textColor: Colors.black,
          titleType: SubTitleType.withShowMore,
          title: tr("recent_tender_msg"),
          icon: Icon(Icons.edit_note),
        ),
       RecentTenders(jobCardType: JobCardType.user,)
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getHomeUserTender();

  }
}
