import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/core/widgets/app_bar_function.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/tab_nav_cubit.dart';
import 'package:hr_career_platform/features/home/presentation/ui/home_job_page.dart';
import 'package:hr_career_platform/features/home/presentation/ui/home_profile_page.dart';
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

  Widget mobileHomeBuilder() {
    return BlocBuilder<TabNavCubit, TabNavState>(
      builder: (context, state) {
        return Scaffold(
          appBar: (state is TabNavChangedState)
              ? buildAppBar(
                  userName: state.selectedTab == 4 ? 'Notifications'
                      : state.selectedTab == 2 ? tr("search_msg")
                          : state.selectedTab == 3 ? tr("profile_msg")
                              :auth.profile!.fullName??'',
                  img:  auth.profile!.avatarUrl!=null? '$BaseStorageUrl${auth.profile!.avatarUrl}':'',
                  userOrCompany: 'User',
                  fullHeader: (state.selectedTab == 4 ||
                          state.selectedTab == 3 ||
                          state.selectedTab == 2)
                      ? false
                      : true,
                  selectedTab: state.selectedTab,
                )
              : buildAppBar(
                  userName: auth.profile!.fullName??'',
                  img:auth.profile!.avatarUrl!=null? '$BaseStorageUrl${auth.profile!.avatarUrl}':'',
                  userOrCompany: 'User',
                  fullHeader: true,
                  selectedTab: state.selectedTab,
                ),
          body: (state is TabNavChangedState)
              ? _navPageBody(state.selectedTab,context)
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
            userOrCompany: 'User',
            userName: 'Mohammed adnan',
            img: '',
            fullHeader: true,
            selectedTab: state.selectedTab,

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
                    ? _navPageBody(state.selectedTab,context)
                    : SizedBox(),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _navPageBody(int selectedTab,BuildContext context) {
    switch (selectedTab) {
      case 0:
        return HomeJobPage();
      case 1:
        return SizedBox();
        case 2:
        return const SearchPage();
      case 3:
        return HomeProfilePage(auth: auth,);
      case 4:
        return NotificationPage(auth: auth,);
      default:
        return Placeholder();
    }
  }
}
