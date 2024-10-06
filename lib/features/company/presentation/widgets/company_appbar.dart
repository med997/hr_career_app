import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_localizations.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/splash_page.dart';
import 'package:hr_career_platform/core/widgets/avatar_network.dart';
import 'package:hr_career_platform/core/widgets/image_holder.dart';
import 'package:hr_career_platform/core/widgets/language_button_widget.dart';
import 'package:hr_career_platform/features/auth/presentation/bloc/login_cubit.dart';
import 'package:hr_career_platform/features/auth/presentation/ui/login_page.dart';
import 'package:hr_career_platform/features/company/domain/entities/company.dart';
import '../../../../core/util/nav_to_sevices.dart';
import '../../../../core/widgets/text_with_icon.dart';

dynamic jobsAppBarFunction(
    {required Company company,
    String type = 'APPBAR',
    bool appbarCompanyDetail = false}) {
  return type == 'APPBAR'
      ? AppBar(
          automaticallyImplyLeading: false,
          excludeHeaderSemantics: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              appbarCompanyDetail == true
                  ? const BackButton(
                      color: Colors.white,
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            tr("profile_msg"),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              BlocConsumer<LoginCubit, LoginState>(
                                listener: (context, state) {
                                  if (state is LoginSignOutState) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SplashPage(),
                                        ),
                                        (route) => false);
                                  }
                                },
                                builder: (context, state) {
                                  return ElevatedButton(
                                      onPressed: () {
                                        context.read<LoginCubit>().signOut();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder(),
                                        backgroundColor: Colors.redAccent,
                                      ),
                                      child: const Icon(
                                        Icons.power_settings_new_outlined,
                                        color: Colors.white,
                                        size: 14,
                                      ));
                                },
                              ),
                              const LanguageButton(
                                clr: Colors.white,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
              ListTile(
                leading: AvatarNetwork(
                  imgUrl: company.companyLogo ?? '',
                  withBorder: false,
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
              appbarCompanyDetail == true
                  ? Wrap(
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
                        CircularIconButton(
                          icon: Icons.send_outlined,
                          onPressed: () {
                            MapUtils.navToMap(-3.823216, -38.481700);
                          },
                        ),
                        CircularIconButton(
                          icon: Icons.more_horiz_rounded,
                          onPressed: () {},
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                color: Colors.black87,
                image: DecorationImage(
                  opacity: 0.5,
                  image: AssetImage('assets/imgs/imgCmpProfile.png'),
                  fit: BoxFit.cover, // Adjust fit as needed
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
          ),
          toolbarHeight: 250,
          centerTitle: true,
        )
      : Container(
          height: 250,
          decoration: BoxDecoration(
              color: Colors.black87,
              image: const DecorationImage(
                opacity: 0.5,
                image: AssetImage('assets/imgs/imgCmpProfile.png'),
                fit: BoxFit.cover, // Adjust fit as needed
              ),
              borderRadius: BorderRadius.circular(32)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              appbarCompanyDetail == true
                  ? const BackButton(
                      color: Colors.white,
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 26),
                      decoration: BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            tr("profile_msg"),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    backgroundColor: Colors.redAccent,
                                  ),
                                  child: const Icon(
                                    Icons.power_settings_new_outlined,
                                    color: Colors.white,
                                    size: 14,
                                  )),
                              const LanguageButton(
                                clr: Colors.white,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
              ListTile(
                leading: AvatarNetwork(
                  imgUrl: company.companyLogo ?? '',
                  withBorder: false,
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
              appbarCompanyDetail == true
                  ? Wrap(
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
                        CircularIconButton(
                          icon: Icons.send_outlined,
                          onPressed: () {
                            MapUtils.navToMap(-3.823216, -38.481700);
                          },
                        ),
                        CircularIconButton(
                          icon: Icons.more_horiz_rounded,
                          onPressed: () {},
                        ),
                      ],
                    )
                  : SizedBox(),
            ],
          ),
        );
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
