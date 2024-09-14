import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/core/widgets/app_bar_function.dart';
import 'package:hr_career_platform/features/auth/presentation/bloc/login_cubit.dart';
import 'package:hr_career_platform/features/auth/presentation/bloc/login_cubit.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/tab_nav_cubit.dart';
import 'package:hr_career_platform/features/home/presentation/ui/home_job_page.dart';
import 'package:hr_career_platform/features/home/presentation/ui/home_profile_page.dart';
import 'package:hr_career_platform/features/home/presentation/ui/search_page.dart';
import 'package:hr_career_platform/features/profile/presentation/bloc/profile_cubit.dart';

import '../../../../core/util/const_val.dart';
import '../../../../core/widgets/notification_page.dart';
import '../../../company/presentation/ui/company_profile_page.dart';
import 'company_job_page.dart';
import 'company_tenders_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


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
                  userName: state.selectedTab == 4
                      ? 'Notifications'
                      : state.selectedTab == 2
                          ? 'Search'
                          : state.selectedTab == 3
                              ? 'Profile'
                              : 'Mohammed adnan',
                  img: '',
                  userOrCompany: 'User',
                  fullHeader: (state.selectedTab == 4 ||
                          state.selectedTab == 3 ||
                          state.selectedTab == 2)
                      ? false
                      : true,
                  selectedTab: state.selectedTab,
                )
              : buildAppBar(
                  userName: 'Mohammed adnan',
                  img: '',
                  userOrCompany: 'User',
                  fullHeader: true,
                  selectedTab: state.selectedTab,
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
                    ? _navPageBody(state.selectedTab)
                    : SizedBox(),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _navPageBody(int selectedTab) {
    switch (selectedTab) {
      case 0:
        return HomeJobPage();
      case 1:
        return SizedBox();
        case 2:

        return const SearchPage();
      case 3:
        context.read<LoginCubit>().checkLoginStatus();
        return BlocBuilder<LoginCubit ,LoginState>(
          builder: (context, state) {
            if (state is CurrentUserStatus) {
              context.read<ProfileCubit>().getUserByUuid(state.auth.userAuth!.id);
              return HomeProfilePage();
            }
            return SizedBox();
          },
        );
      case 4:
        return NotificationPage();
      default:
        return Placeholder();
    }
  }

  @override
  void initState() {

  }
}
