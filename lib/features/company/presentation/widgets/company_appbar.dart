import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/widgets/image_holder.dart';
import '../../../../core/util/nav_to_sevices.dart';
import '../../../../core/widgets/text_with_icon.dart';

AppBar jobsAppBarFunction(
  String companyName,
  String companyMajor,
  String companyLocation,
  String companyLogo,
  String backgroundCompanyImg,
  String companyNumber,
  String companyEmail,
  String companyWebsite,
) {
  return AppBar(
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BackButton(
          color: Colors.white,
        ),
        ListTile(
          leading: CircleAvatar(
              child: ClipOval(
            child: ImageHolder(url: companyLogo),
          )),
          title: Text(
            companyName,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16),
          ),
          subtitle: Wrap(
            spacing: 10,
            children: [
              Text(
                companyMajor,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              TextWithIcon(
                icon: const Icon(
                  Icons.place_outlined,
                  color: primaryColor,
                ),
                text: companyLocation,
                textColor: Colors.grey,
              )
            ],
          ),
        ),
        Wrap(
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
        ),
      ],
    ),
    flexibleSpace: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.5,
            image: AssetImage(backgroundCompanyImg),
            fit: BoxFit.fitWidth, // Adjust fit as needed
          ),
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
    ),
    toolbarHeight: 200,
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
          backgroundColor: primaryColor.withOpacity(0.5),
          hoverColor: primaryTransparent,
        ));
  }
}
