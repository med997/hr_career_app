import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/core/widgets/app_bar_function.dart';
import 'package:hr_career_platform/core/widgets/custom_chips.dart';
import 'package:hr_career_platform/core/widgets/sub-title.dart';
import 'package:hr_career_platform/features/company/presentation/ui/company_profile_page.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/home_cubit.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/tab_nav_cubit.dart';
import 'package:hr_career_platform/features/home/presentation/ui/home_job_page.dart';
import 'package:hr_career_platform/features/home/presentation/ui/home_profile_page.dart';
import 'package:hr_career_platform/features/home/presentation/widgets/featured_jobs.dart';
import 'package:hr_career_platform/features/home/presentation/widgets/recent_jobs.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/job_cubit.dart';

import '../../../../core/util/const_val.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: mobileHomeBuilder(),
        tablet: desktopHomeBuilder(context),
        desktop: desktopHomeBuilder(context));
  }

  Widget mobileHomeBuilder() {
    return BlocBuilder<TabNavCubit, TabNavState>(
      builder: (context, state) {
        return Scaffold(
          appBar: buildAppBar(
            userName: 'Mohammed adnan',
            img: '',
            fullHeader: true,
          ),
          body: (state is TabNavChangedState)
              ? _navPageBody(state.selectedTab)
              : SizedBox(),
          bottomNavigationBar: NavigationBar(
            destinations: navUserItem,
            selectedIndex: state.selectedTab,
            onDestinationSelected: (value) =>
                context.read<TabNavCubit>().changeTab(value),
          ),
        );
      },
    );
  }

  Widget desktopHomeBuilder(BuildContext context) {
    return BlocBuilder<TabNavCubit, TabNavState>(
      builder: (context, state) {
        return Scaffold(
          appBar: buildAppBar(
            userName: 'Mohammed adnan',
            img: '',
            fullHeader: true,
          ),
          body: Row(
            children: [
              NavigationRail(
                  labelType: Responsive.isTablet(context)
                      ? NavigationRailLabelType.selected
                      : NavigationRailLabelType.none,
                  extended: Responsive.isDesktop(context),
                  minWidth: 72,
                  minExtendedWidth: 192,
                  onDestinationSelected: (value) =>
                      context.read<TabNavCubit>().changeTab(value),
                  destinations: navRailUserItem,
                  selectedIndex: state.selectedTab),
              Expanded(
                child: (state is TabNavChangedState)
                    ? _navPageBody(state.selectedTab)
                    : SizedBox(),
              )
            ],
          ),
        );
      },
    );
  }

/*  return (
  transitionDuration: Duration(milliseconds: 1000),
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
  appBar: buildAppBar(userName: 'Mohammed adnan', img: '', fullHeader: true, ),
  extraLargeBody: (_) {
  if ((state is TabNavChangedState)) {
  return _navPageBody(state.selectedTab);
  }
  return SizedBox();
  },
  appBarBreakpoint: Breakpoints.standard,
  mediumLargeBody: (_) {
  if ((state is TabNavChangedState)) {
  return _navPageBody(state.selectedTab);
  }
  return SizedBox();
  },
  smallBody: (_) {
  if ((state is TabNavChangedState)) {
  return _navPageBody(state.selectedTab);
  }
  return SizedBox();
  },
  body:(_) {
  if ((state is TabNavChangedState)) {
  return _navPageBody(state.selectedTab);
  }
  return SizedBox();
  },

  largeBody: (_) {
  if ((state is TabNavChangedState)) {
  return _navPageBody(state.selectedTab);
  }
  return SizedBox();
  },
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
  );*/
  Widget _navPageBody(int selectedTab) {
    switch (selectedTab) {
      case 0:
        return HomeJobPage();
      case 1:
        return CompanyProfilePage();
      case 4:
        return HomeProfilePage();
      default:
        return Placeholder();
    }
  }
}
