import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_localizations.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/features/auth/presentation/bloc/login_cubit.dart';
import 'package:hr_career_platform/features/company/presentation/bloc/company_profile_cubit.dart';
import 'package:hr_career_platform/features/company/presentation/ui/company_profile_page.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/home_cubit.dart';
import 'package:hr_career_platform/features/home/presentation/ui/company_job_page.dart';
import 'package:hr_career_platform/features/home/presentation/ui/company_main_home_page.dart';
import 'package:hr_career_platform/features/job/presentation/ui/add_job_page.dart';
import '../../../../core/util/const_val.dart';
import '../../../../core/widgets/app_bar_function.dart';
import '../../../auth/domain/entities/auth.dart';
import '../../../profile/presentation/bloc/profile_cubit.dart';
import '../bloc/tab_nav_cubit.dart';
import 'company_tenders_page.dart';

class HomeCompanyPage extends StatefulWidget {
  final Auth auth;
   const HomeCompanyPage({super.key, required this.auth});
  @override
  State<HomeCompanyPage> createState() => _HomeCompanyPageState();
}


class _HomeCompanyPageState extends State<HomeCompanyPage> {

  @override
  void initState() {
    super.initState();

    context.read<CompanyProfileCubit>().getCompanyByUuid(
        context.read<LoginCubit>().authenticatedUser!.userAuth!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: mobileHomeBuilder(),
        tablet: desktopHomeBuilder(context),
        desktop: desktopHomeBuilder(context)
    );
  }

  Widget mobileHomeBuilder() {
    return BlocBuilder<TabNavCubit, TabNavState>(
      builder: (context, state) {
        return Scaffold(
          appBar: state.selectedTab != 3 ? buildAppBar(
            userOrCompany: 'Company',
            userName: state.selectedTab == 3 ? tr("profile_msg")
                : state.selectedTab == 1 ? 'Jobs'
                : state.selectedTab == 2 ? tr("tenders_msg")
                : widget.auth.company!.nameEn  ?? '',
            img:  widget.auth.company!.companyLogo ??'',
            fullHeader: (state.selectedTab != 0)
                ? false
                : true,
            selectedTab: state.selectedTab, context: context,
          ) : null,
          body: (state is TabNavChangedState)
              ? _navPageBody(state.selectedTab,context)
              : const SizedBox(),
          bottomNavigationBar: NavigationBar(
            destinations: navUserCompanyItem,
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
          appBar:   buildAppBar(
            context: context,
            userOrCompany: 'Company',
            userName: state.selectedTab == 3 ? "profile_msg".tr()
                : state.selectedTab == 1 ? 'Jobs'.tr()
                : state.selectedTab == 2 ? "tenders_msg".tr()
                : widget.auth.company!.nameEn ?? '',
            img:  widget.auth.company!.companyLogo!,
            fullHeader: (state.selectedTab != 0)
                ? false
                : true,
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
                  destinations: navRailUserCompanyItem,
                  selectedIndex: state.selectedTab),
              Expanded(
                child: (state is TabNavChangedState)
                    ? _navPageBody(state.selectedTab,context)
                    : const SizedBox(),
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
        return CompanyMainHomePage(authId:  widget.auth.userAuth!.id);
      case 1:
        return CompanyJobPage();
      case 2:
        return const CompanyTendersPage();
      case 3:
            return CompanyProfilePage(auth: widget.auth,);
      default:
        return const SizedBox();
    }
  }
}
