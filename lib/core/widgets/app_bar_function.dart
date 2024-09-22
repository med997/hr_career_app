import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_localizations.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/locale_cubit.dart';
import 'package:hr_career_platform/core/widgets/avatar_network.dart';
import 'package:hr_career_platform/core/widgets/image_holder.dart';
import 'package:hr_career_platform/core/widgets/language_button_widget.dart';

AppBar buildAppBar({
  required String userName,
  required String img,
  bool fullHeader = false,
  bool withBackBtn = false,
  required String userOrCompany,
  int? selectedTab,

}) {
  return AppBar(

    iconTheme: IconThemeData(color: primaryColor),
    centerTitle: true,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flex(
          crossAxisAlignment: CrossAxisAlignment.start,
          direction: Axis.vertical,
          children: [
            if (fullHeader == true)
              Text(
                fullHeader ? tr("welcome-back_msg") : ' ',
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
          direction: Axis.horizontal,
          children: [
            if (selectedTab == 2 && userOrCompany == 'Company')
              appBarButton(
                Colors.yellow.shade700,
              )
            else if (selectedTab == 1 && userOrCompany == 'Company')
              appBarButton(primaryColor)
            else if (selectedTab == 3)
               const LanguageButton(clr: primaryColor),
            if (fullHeader == true)
              AvatarNetwork(
                imgUrl: '',
                withBorder: false,
              )
          ],
        )
      ],
    ),
  );
}

ElevatedButton appBarButton(Color clr) {
  return ElevatedButton(
      onPressed: () async {},
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: clr,
      ),
      child: Icon(Icons.add, color: Colors.white));
}
