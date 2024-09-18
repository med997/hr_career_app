import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/widgets/avatar_network.dart';
import 'package:hr_career_platform/core/widgets/image_holder.dart';
import 'package:hr_career_platform/core/widgets/language_button_widget.dart';
import 'package:hr_career_platform/features/auth/presentation/ui/login_page.dart';
import '../../../../core/util/nav_to_sevices.dart';
import '../../../../core/widgets/text_with_icon.dart';

AppBar jobsAppBarFunction(
    {required String companyName,
    required String companyMajor,
    required String companyLocation,
    required String companyLogo,
    required String backgroundCompanyImg,
    required String companyNumber,
    required String companyEmail,
    required String companyWebsite,
    bool appbarCompanyDetail = false}) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appbarCompanyDetail == true
            ? const BackButton(
                color: Colors.white,
              )
            : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Profile',
                    style: TextStyle(
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
                          child: const Icon(Icons.power_settings_new_outlined, color: Colors.white, size: 14,)),
                      const LanguageButton(clr: Colors.white,)
                    ],
                  )
                ],
              ),
        ListTile(
          leading: AvatarNetwork(
            imgUrl: companyLogo,
            withBorder: false,
          ),
          title: Text(
            companyName,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
          ),
          subtitle: Wrap(
            spacing: 2,
            children: [
              Text(
                companyMajor,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              TextWithIcon(
                icon: const Icon(
                  Icons.place_outlined,
                  color: primaryColor,
                  size: 18,
                ),
                text: companyLocation,
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
                navToCall(companyNumber);
              },
            ),
            CircularIconButton(
              icon: Icons.mail_outlined,
              onPressed: () {
                navToEmail(companyEmail);
              },
            ),
            CircularIconButton(
              icon: Icons.language_outlined,
              onPressed: () {
                navToWebsite(companyWebsite);
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
        ) : SizedBox(),
      ],
    ),
    flexibleSpace: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.8,
            image: AssetImage(backgroundCompanyImg),
            fit: BoxFit.fitWidth, // Adjust fit as needed
          ),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
    ),
    toolbarHeight: 180,
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
