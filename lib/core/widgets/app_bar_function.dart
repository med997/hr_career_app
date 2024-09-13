import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/locale_cubit.dart';
import 'package:hr_career_platform/core/widgets/avatar_network.dart';
import 'package:hr_career_platform/core/widgets/image_holder.dart';
import 'package:hr_career_platform/core/widgets/language_button_widget.dart';

AppBar buildAppBar({
  required String userName,
  required String img,
  bool fullHeader = false,
  int? selectedTab,
}) {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fullHeader ? 'Welcome Back!' : ' ',
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            Text(
              fullHeader ? "$userName 👋🏻" : userName,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            if (selectedTab == 3) const LanguageButton(),
            if (fullHeader == true)
              Center(
                  child: AvatarNetwork(
                imgUrl: '',
                withBorder: false,
              ))
          ],
        )
      ],
    ),
  );
}
