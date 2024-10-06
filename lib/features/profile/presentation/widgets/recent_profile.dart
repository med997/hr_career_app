import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:hr_career_platform/features/profile/presentation/bloc/appliance_cubit.dart';
import 'package:hr_career_platform/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:hr_career_platform/features/profile/presentation/widgets/profile_card.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../../home/presentation/bloc/home_cubit.dart';

class RecentProfile extends StatelessWidget {
  const RecentProfile({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplianceCubit, ApplianceState>(
      builder: (context, state) {
        if (state is ApplianceLoading) {
          return LoadingWidget();
        } else if (state is ApplianceFetchedState) {
          return Responsive(
              mobile: _buildMobileLayout(state.profile),
              tablet: _buildTabletDesktopLayout(2, context, state.profile),
              desktop: _buildTabletDesktopLayout(3, context, state.profile));
        } else
          return const SizedBox();
      },
    );
  }

  Widget _buildMobileLayout(List<Profile> profile) {
    return ListView.builder(
        shrinkWrap: true,
        physics: PageScrollPhysics(),
        itemCount: profile.length,
        itemBuilder: (context, i) {
          return ProfileCard(
            profile: profile[i],
          );
        });
  }

  Widget _buildTabletDesktopLayout(
      int columnCount, BuildContext context, List<Profile> profile) {
    double itemWidth = MediaQuery.of(context).size.width / columnCount - 50;
    if (Responsive.isDesktop(context)) itemWidth = 300;
    return Wrap(children: [
     ...profile.map((profile) => ProfileCard(
       columnWidth: itemWidth,
       profile: profile,
     ))
    ]);
  }
}
