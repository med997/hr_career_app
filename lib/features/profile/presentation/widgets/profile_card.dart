import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/curd_appliance_job_cubit.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';

import '../../../../core/util/enums.dart';
import '../../../../core/widgets/avatar_network.dart';
import '../../../../core/widgets/text_with_icon.dart';

class ProfileCard extends StatelessWidget {
  double? columnWidth;
  final Profile profile;

  ProfileCard({super.key, this.columnWidth, required this.profile});

  @override
  Widget build(BuildContext context) {
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
          profile.fullName ?? '',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        trailing: popOptionMenuApplianceState(context),
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


  popOptionMenuApplianceState(BuildContext context) {
    return PopupMenuButton<ApplianceStateItem>(

      onSelected: (ApplianceStateItem item) {
        context.read<CurdApplianceJobCubit>().updateApplianceJob(profile.applianceId!, item.name);
      },
      itemBuilder: (BuildContext context) =>
          <PopupMenuEntry<ApplianceStateItem>>[
        const PopupMenuItem<ApplianceStateItem>(
          value: ApplianceStateItem.approved,
          child: TextWithIcon(
            text: 'approved',
            icon: Icon(
              Icons.check,
              size: 14,
              color: Colors.teal,
            ),
          ),
        ),
        const PopupMenuItem<ApplianceStateItem>(
          value: ApplianceStateItem.toShortList,
          child: TextWithIcon(
            text: 'toShortList',
            icon: Icon(
              Icons.library_add_check_sharp,
              size: 14,
              color: primaryColor,
            ),
          ),
        ),
        const PopupMenuItem<ApplianceStateItem>(
          value: ApplianceStateItem.ignored,
          child: TextWithIcon(
            text: 'ignored',
            icon: Icon(
              Icons.check,
              size: 14,
              color: Colors.redAccent,
            ),
          ),
        ),
      ],
    );
  }
}
