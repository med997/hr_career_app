import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';

class JobDetailsTabbar extends StatefulWidget {
  const JobDetailsTabbar({super.key});

  @override
  State<JobDetailsTabbar> createState() => _JobDetailsTabbarState();
}

class _JobDetailsTabbarState extends State<JobDetailsTabbar>
    with TickerProviderStateMixin {
  late final TabController _tabController;

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
            indicatorSize: TabBarIndicatorSize.label,
            controller: _tabController,
            tabs: const <Widget>[
              Tab(text: 'Description'),
              Tab(text: 'Requirement'),
              Tab(text: 'How to apply ?'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[],
            ),
          ),
        ],
      ),
    );
  }
}
