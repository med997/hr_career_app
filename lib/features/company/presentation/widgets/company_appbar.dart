import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_localizations.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/splash_page.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/core/widgets/avatar_network.dart';
import 'package:hr_career_platform/core/widgets/image_holder.dart';
import 'package:hr_career_platform/core/widgets/language_button_widget.dart';
import 'package:hr_career_platform/features/auth/presentation/bloc/login_cubit.dart';
import 'package:hr_career_platform/features/auth/presentation/ui/login_page.dart';
import 'package:hr_career_platform/features/company/domain/entities/company.dart';
import 'package:hr_career_platform/features/company/presentation/bloc/curd_company_cubit.dart';
import '../../../../core/util/const_val.dart';
import '../../../../core/util/nav_to_sevices.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/text_with_icon.dart';
import '../../../profile/presentation/bloc/curd_profile_cubit.dart';

class CompanyAppBarWidget extends StatelessWidget {
  final Company company;
  final String type;
  final bool withEditing;
  final bool withBackBtn;
  final bool withContactsBtn;

  final bool appbarCompanyDetail;

  const CompanyAppBarWidget(
      {super.key,
      required this.company,
      this.type = 'APPBAR',
      this.appbarCompanyDetail = false,
      this.withContactsBtn = false,
      this.withBackBtn = false,
      this.withEditing = false});

  void pickImage(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );
    if (result != null) {
      context
          .read<CurdCompanyCubit>()
          .uploadImageCompany(result.files.first.path!, company.id!);
    } else {
      print("No file selected");
    }
  }

  @override
  Widget build(BuildContext context) {

      return Container(
        padding: const EdgeInsets.only(top: 12,bottom: 12,right: 12,left: 12),
        decoration:  const BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              opacity: 0.4,
              image: AssetImage('assets/imgs/imgCmpProfile.png'),
              fit: BoxFit.cover, // Adjust fit as needed
            ),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))


        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (appbarCompanyDetail == true)
                Container(
               margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Text(
                      "profile_msg".tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 6,
                      children: [
                        const LanguageButton(
                          clr: Colors.white,
                        ),
                        BlocConsumer<LoginCubit, LoginState>(
                          listener: (context, state) {
                            if (state is LoginSignOutState) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SplashPage(),
                                  ),
                                  (route) => false);
                            }
                          },
                          builder: (context, state) {
                            return MaterialButton(
                                onPressed: () {
                                  context.read<LoginCubit>().signOut();
                                },
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(2),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                clipBehavior: Clip.hardEdge,
                                color: Colors.red,
                                minWidth: 16,
                                child: const Icon(
                                  Icons.power_settings_new_outlined,
                                  color: Colors.white,
                                  size: 18,
                                )
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),

              ListTile(

                trailing: withBackBtn?const BackButton(color: Colors.white):null,
                leading: BlocBuilder<CurdCompanyCubit, CurdCompanyState>(
                  builder: (context, state) {
                    if (state is LoadingCurdCompanyState) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          color: secondaryColor,
                          strokeWidth: 2,

                        ),
                      );
                    } else if (state is MessageCurdCompanyState) {
                      String imageUrl = state.company.companyLogo != null
                          ? '$BaseStorageUrl${state.company.companyLogo}'
                          : '';
                      return AvatarNetwork(
                        imgUrl: imageUrl,
                        withBorder: false,
                        withEditBtn: true,
                        bgColor: Colors.white,
                        editClicked: () =>
                            withEditing ? pickImage(context) : null,
                      );
                    }
                    String imageUrl = company.companyLogo!.isNotEmpty
                        ? '$BaseStorageUrl${company.companyLogo!}'
                        : '';
                    return AvatarNetwork(
                        imgUrl: imageUrl,
                        editClicked: () =>
                            withEditing ? pickImage(context) : null,
                        bgColor: Colors.white,
                        withEditBtn: withEditing,
                        withBorder: false);
                  },
                ),
                title: Text(
                  company.nameEn,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16),
                ),
                subtitle: Wrap(
                  spacing: 2,
                  children: [
                    Text(
                      company.major ?? '',
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    TextWithIcon(
                      icon: const Icon(
                        Icons.place_outlined,
                        color: primaryColor,
                        size: 18,
                      ),
                      text: company.city ?? '',
                      textColor: Colors.grey,
                    )
                  ],
                ),
              ),
            if(withContactsBtn)
                  Wrap(
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      spacing: 15,
                      runSpacing: 10,
                      children: [
                        CircularIconButton(
                          icon: Icons.call_outlined,
                          onPressed: () {
                            navToCall(company.phone);
                          },
                        ),
                        CircularIconButton(
                          icon: Icons.mail_outlined,
                          onPressed: () {
                            navToEmail(company.email);
                          },
                        ),
                        CircularIconButton(
                          icon: Icons.language_outlined,
                          onPressed: () {
                            navToWebsite(company.website ?? '');
                          },
                        ),
                      (company.locations!=null&&company.locations!.length==2)?
                      CircularIconButton(
                          icon: Icons.send_outlined,
                          onPressed: () {
                            MapUtils.navToMap(company.locations![0], company.locations![1]);
                          },
                        ):const SizedBox(),
                        CircularIconButton(
                          icon: Icons.more_horiz_rounded,
                          onPressed: () {},
                        ),
                      ],
                    )

            ],
          ),
        ),
      );

  }
}

class CircularIconButton extends StatelessWidget {
  const CircularIconButton(
      {super.key, required this.icon, required this.onPressed});

  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
        iconSize: 20,

        onPressed: onPressed,
        icon: Icon(
          icon,

          color: Colors.white,
        ),
        style: IconButton.styleFrom(
          backgroundColor: primaryColor.withOpacity(0.9),
          hoverColor: primaryTransparent,
        ));
  }
}
