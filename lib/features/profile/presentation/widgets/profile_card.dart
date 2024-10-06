import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';

import '../../../../core/widgets/avatar_network.dart';
import '../../../../core/widgets/text_with_icon.dart';

class ProfileCard extends StatelessWidget {
  double? columnWidth;
  final Profile profile;

  ProfileCard(
      {super.key,
      this.columnWidth, required this.profile});

  @override
  Widget build(BuildContext context) {
    return profileCard();
  }
  Widget profileCard() {
    double width = columnWidth ?? 320;
    return Container(
     height: 60,
      padding: EdgeInsets.symmetric(vertical: 7),
      width: width,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey.withOpacity(0.5), width: 0.5),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: ListTile(
        minTileHeight: 55,
            leading: AvatarNetwork(
              imgUrl: profile.avatarUrl ?? '',
              withBorder: true,
            ),
            title: Text(
              profile.fullName ??'',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            subtitle: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 4,
              direction: Axis.horizontal,
              children: [
                TextWithIcon(
                  icon: Icon(
                    Icons.access_time_outlined,
                    size: 18,
                    color: primaryTransparent.withOpacity(0.7),
                  ),
                  text: profile.dob.toString(),
                  textColor: Colors.grey,
                ),
                TextWithIcon(
                  icon: Icon(
                    Icons.location_on_outlined,
                    size: 18,
                    color: primaryTransparent.withOpacity(0.7),
                  ),
                  text: profile.address ?? '',
                  textColor: Colors.grey,
                ),
                TextWithIcon(
                  icon: Icon(
                    Icons.people_alt_outlined,
                    size: 18,
                    color: primaryTransparent.withOpacity(0.7),
                  ),
                  text: profile.nationality ?? '',
                  textColor: Colors.grey,
                ),
              ],
            ),
          ),

      );
  }
  }
