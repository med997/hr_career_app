import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/features/job/domain/entities/job.dart';

import '../../../../core/app_theme.dart';

class JobDetailsTabBar extends StatefulWidget {
  final Job job;

  const JobDetailsTabBar({super.key, required this.job});

  @override
  State<JobDetailsTabBar> createState() => _JobDetailsTabBarState(job: job);
}

class _JobDetailsTabBarState extends State<JobDetailsTabBar>
    with TickerProviderStateMixin {
  final Job job;

  late final TabController _tabController;

  _JobDetailsTabBarState({required this.job});

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          TabBar.secondary(
            unselectedLabelStyle: const TextStyle(color: Colors.grey),
            labelColor: primaryColor,
            indicatorColor: primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.label,
            controller: _tabController,
            tabs: const <Widget>[
              Tab(text: 'Description'),
              Tab(text: 'Requirement'),
              Tab(text: 'How to apply?'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Text(
                    job.jobDesc,
                    textAlign: TextAlign.justify,
                    softWrap: true,
                    overflow: TextOverflow.visible,

                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Text(
                    job.jobRequirements,
                    textAlign: TextAlign.justify,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Text(
                    job.jobRequirements,
                    textAlign: TextAlign.justify,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
