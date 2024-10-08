import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/cubit/avatar_cubit.dart';

import '../../../../core/app_localizations.dart';
import '../../../../core/util/responsive.dart';
import '../../../../core/widgets/avatar_network.dart';
import '../bloc/profile_cubit.dart';

class HeaderProfileWidget extends StatelessWidget {
  HeaderProfileWidget({
    required this.withBox,
    super.key,
    required this.avatar,
    this.avatarUnit,
    required this.fullName,
  });

  var avatar;
  Uint8List? avatarUnit;
  final String fullName;
  final bool withBox;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<AvatarCubit, Uint8List?>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                context.read<AvatarCubit>().pickImage();
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child:  state != null
                    ? AvatarNetwork(imgMemory: state,imgUrl: '', withBorder: false)
                    : AvatarNetwork(
                  withBorder: false,
                  imgUrl: avatar,
                ),
              )
              //
            );
          },
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          fullName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          tr("description_msg"),
          style: const TextStyle(color: Colors.grey),
        ),
        if (withBox == true)
          Container(
            height: 60,
            margin: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: Responsive.isMobile(context) ? 32 : 65),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.blueGrey.withOpacity(0.5), width: 0.5),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white),
            child: const Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '27',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('applied')
                    ],
                  ),
                ),
                VerticalDivider(),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '19',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('viewed')
                    ],
                  ),
                ),
                VerticalDivider(),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '14',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('interview')
                    ],
                  ),
                ),
              ],
            ),
          )
        else
          const SizedBox(),
      ],
    );
  }
}
