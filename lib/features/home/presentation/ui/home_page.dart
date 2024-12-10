import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/core/widgets/app_bar_function.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/tab_nav_cubit.dart';
import 'package:hr_career_platform/features/home/presentation/ui/home_job_page.dart';
import 'package:hr_career_platform/features/home/presentation/ui/home_profile_page.dart';
import 'package:hr_career_platform/features/home/presentation/ui/home_tender_page.dart';
import 'package:hr_career_platform/features/home/presentation/ui/search_page.dart';

import '../../../../core/app_localizations.dart';
import '../../../../core/util/const_val.dart';
import '../../../../core/widgets/notification_page.dart';
import '../../../auth/domain/entities/auth.dart';

class HomePage extends StatelessWidget {
  final Auth auth;

  const HomePage({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: mobileHomeBuilder(),
        tablet: desktopHomeBuilder(context),
        desktop: desktopHomeBuilder(context));
  }

  bool checkIsGust() {
    return  auth.email == GustEmail;
  }

  Widget mobileHomeBuilder() {
    return BlocBuilder<TabNavCubit, TabNavState>(
      builder: (context, state) {
        return Scaffold(
          appBar: (state is TabNavChangedState)
              ? buildAppBar(
                  userName: state.selectedTab == 4
                      ? 'Notification'.tr()
                      : state.selectedTab == 2
                          ? "search_msg".tr()
                          : state.selectedTab == 3
                              ? "profile_msg".tr()
                              :checkIsGust()?'GustUser'.tr():
                  auth.profile!.fullName ?? '',
                  img: checkIsGust()?'': auth.profile!.avatarUrl ?? '',
                  userOrCompany: 'User',
                  fullHeader: (state.selectedTab == 4 ||
                          state.selectedTab == 3 ||
                          state.selectedTab == 2)
                      ? false
                      : true,
                  selectedTab: state.selectedTab,
                  context: context,
                )
              : buildAppBar(
                  userName:checkIsGust()?'GustUser'.tr(): auth.profile!.fullName ?? '',
                  img:checkIsGust()?'': auth.profile!.avatarUrl ?? '',
                  userOrCompany: 'User',
                  fullHeader: true,
                  selectedTab: state.selectedTab,
                  context: context,
                ),
          body: (state is TabNavChangedState)
              ? _navPageBody(state.selectedTab, context)
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
          appBar: (state is TabNavChangedState)
              ? buildAppBar(
                  userName: state.selectedTab == 4
                      ? 'Notification'.tr()
                      : state.selectedTab == 2
                          ? "search_msg".tr()
                          : state.selectedTab == 3
                              ? "profile_msg".tr()
                              :checkIsGust()?'GustUser'.tr(): auth.profile!.fullName ?? '',
                  img:checkIsGust()?'': auth.profile!.avatarUrl ?? '',
                  userOrCompany: 'User',
                  fullHeader: (state.selectedTab == 4 ||
                          state.selectedTab == 3 ||
                          state.selectedTab == 2)
                      ? false
                      : true,
                  selectedTab: state.selectedTab,
                  context: context,
                )
              : buildAppBar(
                  userName:checkIsGust()?'GustUser'.tr(): auth.profile!.fullName ?? '',
                  img:checkIsGust()?'': auth.profile!.avatarUrl ?? '',
                  userOrCompany: 'User',
                  fullHeader: true,
                  selectedTab: state.selectedTab,
                  context: context,
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
                    ? _navPageBody(state.selectedTab, context)
                    : SizedBox(),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _navPageBody(int selectedTab, BuildContext context) {
    switch (selectedTab) {
      case 0:
        return HomeJobPage();
      case 1:
        return const HomeTenderPage();
      case 2:
        return SearchPage();
      case 3:
        return HomeProfilePage(
          auth: auth,
        );
      case 4:
        return NotificationPage(
          auth: auth,
        );
      default:
        return Placeholder();
    }
  }
}
