import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_localizations.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/locale_cubit.dart';
import 'package:hr_career_platform/core/widgets/avatar_network.dart';
import 'package:hr_career_platform/core/widgets/image_holder.dart';
import 'package:hr_career_platform/core/widgets/language_button_widget.dart';
import 'package:hr_career_platform/features/tender/presentation/ui/add_tender_page.dart';
import 'package:hr_career_platform/main.dart';

import '../../features/auth/presentation/bloc/login_cubit.dart';
import '../../features/job/presentation/ui/add_job_page.dart';
import '../splash_page.dart';
import '../util/const_val.dart';

AppBar buildAppBar(
    {required String userName,
    required String img,
    bool fullHeader = false,
    bool withBackBtn = false,
    required String userOrCompany,
    int? selectedTab,
    required BuildContext context}) {
  String imageUrl = img.isNotEmpty ? '$BaseStorageUrl$img' : '';
  return AppBar(
    iconTheme: const IconThemeData(color: primaryColor),
    centerTitle: true,
    titleSpacing: 8,
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
                fullHeader ? ("welcome-back_msg".tr()) : ' ',
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            Text(
              fullHeader ? "$userName 👋🏻" : userName,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Wrap(
          alignment: WrapAlignment.center,
          direction: Axis.horizontal,
          children: [
            if (selectedTab == 2 && userOrCompany == 'Company')
              appBarButton(Colors.yellow.shade700, () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddTenderPage(),
                  ),
                );
              })
            else if (selectedTab == 1 && userOrCompany == 'Company')
              appBarButton(primaryColor, () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddJobPage(),
                  ),
                );
              })
            else if (selectedTab == 3 && userOrCompany == 'User')
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  direction: Axis.horizontal,
                  spacing: 6,
                  children: [
                    LanguageButton(clr: primaryColor),
                    BlocConsumer<LoginCubit, LoginState>(
                      listener: (context, state) {
                        if (state is LoginSignOutState) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  SplashPage(),
                              ),
                              (route) => false);
                        }
                      },
                      builder: (context, state) {
                        return MaterialButton(
                            onPressed: () async{
                              String? fcmToken;
                              if(!kIsWeb){
                                fcmToken = await FirebaseMessaging.instance.getToken();
                              }
                              context.read<LoginCubit>().signOut(fcmToken??'');
                            },
                            shape: CircleBorder(),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            clipBehavior: Clip.hardEdge,
                            padding:
                                EdgeInsets.all(userOrCompany == 'User' ? 4 : 2),
                            color: userOrCompany == 'User' ? null : Colors.red,
                            minWidth: 16,
                            child: Icon(
                              Icons.power_settings_new_outlined,
                              color: userOrCompany == 'User'
                                  ? Colors.red
                                  : Colors.white,
                              size: userOrCompany == 'User' ? 22 : 18,
                            ));
                      },
                    ),
                  ],
                ),
              ),
            if (fullHeader == true)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: AvatarNetwork(
                  imgUrl: imageUrl,
                  withBorder: false,
                ),
              )
          ],
        )
      ],
    ),
  );
}

ElevatedButton appBarButton(Color clr, Function() onTap) {
  return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: clr,
      ),
      child: Icon(Icons.add, color: Colors.white));
}
