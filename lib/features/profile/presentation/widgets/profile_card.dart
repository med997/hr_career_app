import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';

import '../../../../core/widgets/avatar_network.dart';
import '../../../../core/widgets/text_with_icon.dart';

class ProfileCard extends StatelessWidget {
  double? columnWidth;
  final String userTime;
  final String userName;
  final String userLocation;
  final String userNationality;
  final String userLogo;

  ProfileCard(
      {super.key,
      required this.userTime,
      required this.userName,
      required this.userLocation,
      required this.userNationality,
      required this.userLogo,
      this.columnWidth});

  @override
  Widget build(BuildContext context) {
    return profileCard();
  }
  Widget profileCard() {
    double width = columnWidth ?? 320;
    return Container(
      height: 70,
      width: width,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          border:
              Border.all(color: Colors.blueGrey.withOpacity(0.5), width: 0.5),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            leading: AvatarNetwork(
              imgUrl: userLogo ?? '',
              withBorder: true,
            ),
            title:  Text(
              userName,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
            subtitle:  Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 4,
              direction: Axis.horizontal,
              children: [
                TextWithIcon(
                    icon: Icon(
                      Icons.access_time_outlined,
                      size: 18,
                      color: primaryTransparent.withOpacity(0.7),
                    ),
                    text: userTime,
                    textColor: Colors.grey),
                TextWithIcon(
                    icon:  Icon(
                      Icons.location_on_outlined,
                      size: 18,
                      color: primaryTransparent.withOpacity(0.7),
                    ),
                    text: userLocation,
                    textColor: Colors.grey),
                TextWithIcon(
                    icon:  Icon(
                      Icons.people_alt_outlined,
                      size: 18,
                      color: primaryTransparent.withOpacity(0.7),
                    ),
                    text: userNationality,
                  textColor: Colors.grey,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
