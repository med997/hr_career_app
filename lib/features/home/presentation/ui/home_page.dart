import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/widgets/custom_chips.dart';
import 'package:hr_career_platform/core/widgets/sub-title.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/home_cubit.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/tab_nav_cubit.dart';
import 'package:hr_career_platform/features/home/presentation/widgets/featured_jobs.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/job_cubit.dart';

import '../../../../core/util/const_val.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabNavCubit, TabNavState>(
      builder: (context, state) {
        return AdaptiveScaffold(
          // An option to override the default transition duration.
          transitionDuration: Duration(milliseconds: 1000),
          // An option to override the default breakpoints used for small, medium,
          // mediumLarge, large, and extraLarge.
          bodyRatio: 0.8,
          smallBreakpoint: const Breakpoint(endWidth: 700),

          mediumBreakpoint: const Breakpoint(beginWidth: 700, endWidth: 1000),
          mediumLargeBreakpoint:
              const Breakpoint(beginWidth: 1000, endWidth: 1200),
          largeBreakpoint: const Breakpoint(beginWidth: 1200, endWidth: 1600),
          extraLargeBreakpoint: const Breakpoint(beginWidth: 1600),
          useDrawer: false,
          selectedIndex: (state is TabNavChangedState) ? state.selectedTab : 0,
          onSelectedIndexChange: (int index) {
            context.read<TabNavCubit>().changeTab(index);
          },
          destinations: navUserItem,
          bodyOrientation: Axis.vertical,
          extraLargeBody: (_) {
            if ((state is TabNavChangedState)) {
              switch (state.selectedTab){
                case 0:
                  return ListView(
                    children: [
                      Text('extraLargeBody'),
                      SubTitle(
                        onShowMoreClicked: () {
                          if (kDebugMode) print('showMoreClicked');
                        },
                        titleType: SubTitleType.withShowMore,
                        title: 'Featured Jobs',
                        icon: Icon(Icons.edit_note),
                      ),
                      FeaturedJobs()
                    ],
                  );
                case 1 :
                  return ListView(
                    children: [
                      Text('extraLargeBody2'),
                      SubTitle(
                        onShowMoreClicked: () {
                          if (kDebugMode) print('showMoreClicked');
                        },
                        titleType: SubTitleType.withShowMore,
                        title: 'Featured Jobs',
                        icon: Icon(Icons.edit_note),
                      ),
                      FeaturedJobs()
                    ],
                  );
              }
            }
            return SizedBox();
          },

          mediumLargeBody: (_) => ListView(
            children: [
              Text('mediumLargeBody'),
              SubTitle(
                onShowMoreClicked: () {
                  if (kDebugMode) print('showMoreClicked');
                },
                titleType: SubTitleType.withShowMore,
                title: 'Featured Jobs',
                icon: Icon(Icons.edit_note),
              ),
              FeaturedJobs()
            ],
          ),
          smallBody: (_) => ListView(
            children: [
              SubTitle(
                onShowMoreClicked: () {
                  if (kDebugMode) print('showMoreClicked');
                },
                titleType: SubTitleType.withShowMore,
                title: 'Featured Jobs',
                icon: Icon(Icons.edit_note),
              ),
              FeaturedJobs()
            ],
          ),
          body: (_) => ListView(
            scrollDirection: Axis.vertical,
            children: [
              Text('body'),
              SubTitle(
                onShowMoreClicked: () {
                  if (kDebugMode) print('showMoreClicked');
                },
                titleType: SubTitleType.withShowMore,
                title: 'Featured Jobs',
                icon: Icon(Icons.edit_note),
              ),
              FeaturedJobs()
            ],
          ),

          largeBody: (_) => ListView(
            scrollDirection: Axis.vertical,
            children: [
              Text('largeBody'),
              SubTitle(
                onShowMoreClicked: () {
                  if (kDebugMode) print('showMoreClicked');
                },
                titleType: SubTitleType.withShowMore,
                title: 'Featured Jobs',
                icon: Icon(Icons.edit_note),
              ),
              FeaturedJobs()
            ],
          ),

          smallSecondaryBody: AdaptiveScaffold.emptyBuilder,
          secondaryBody: (_) => Container(
            color: bgColor,
          ),
          mediumLargeSecondaryBody: (_) => Container(
            color: bgColor,
          ),
          largeSecondaryBody: (_) => Container(
            color: bgColor,
          ),
          extraLargeSecondaryBody: (_) => Container(
            color: bgColor,
          ),
        );
      },
    );
  }
}
