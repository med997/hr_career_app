import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:hr_career_platform/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:hr_career_platform/features/profile/presentation/widgets/profile_card.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../../home/presentation/bloc/home_cubit.dart';

class RecentProfile extends StatelessWidget {
  const RecentProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return LoadingWidget();
        } else
          return Responsive(
              mobile: _buildMobileLayout(),
              tablet:
              _buildTabletDesktopLayout( 2, context),
              desktop: _buildTabletDesktopLayout(
                   3, context));
      },
    );
  }

  Widget _buildMobileLayout() {
    return ListView.builder(
        shrinkWrap: true,
        physics: PageScrollPhysics(),
         itemCount: 1,
        itemBuilder: (context, i) {
              return ProfileCard(
                    userTime: '2 Hour Ago',
                    userName:  'Ibrahim Murad ',
                    userLocation:  'Sanaa',
                    userNationality:  'Yemeni',
                    userLogo:  'No avatarUrl ');
            });
  }
 Widget _buildTabletDesktopLayout ( int columnCount, BuildContext context) {
   double itemWidth = MediaQuery.of(context).size.width / columnCount -50 ;
   if(Responsive.isDesktop(context))
     itemWidth = 300 ;
   return Wrap(
       children: [
       ProfileCard(
       userTime: '2 Hour Ago',
       userName:  'Ibrahim Murad ',
       userLocation:  'Sanaa',
       userNationality:  'Yemeni',
       userLogo:  'No avatarUrl ',
       columnWidth: itemWidth,),
       ProfileCard(
       userTime: '2 Hour Ago',
       userName:  'Ibrahim Murad ',
       userLocation:  'Sanaa',
       userNationality:  'Yemeni',
       userLogo:  'No avatarUrl ',
       columnWidth: itemWidth,),
       ProfileCard(
       userTime: '2 Hour Ago',
       userName:  'Ibrahim Murad ',
       userLocation:  'Sanaa',
       userNationality:  'Yemeni',
       userLogo:  'No avatarUrl ',
       columnWidth: itemWidth,),
       ProfileCard(
       userTime: '2 Hour Ago',
       userName:  'Ibrahim Murad ',
       userLocation:  'Sanaa',
       userNationality:  'Yemeni',
       userLogo:  'No avatarUrl ',
       columnWidth: itemWidth,),
       ProfileCard(
       userTime: '2 Hour Ago',
       userName:  'Ibrahim Murad ',
       userLocation:  'Sanaa',
       userNationality:  'Yemeni',
       userLogo:  'No avatarUrl ',
       columnWidth: itemWidth,),
           ]);
 }

}
