import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/widgets/avatar_network.dart';
import 'package:hr_career_platform/core/widgets/image_holder.dart';
import '../../../../core/util/nav_to_sevices.dart';
import '../../../../core/widgets/text_with_icon.dart';

AppBar jobsAppBarFunction({
  required String companyName,
  required String companyMajor,
  required String companyLocation,
  required String companyLogo,
  required String backgroundCompanyImg,
  required String companyNumber,
  required String companyEmail,
  required String companyWebsite,
  bool withBackBtn =false
}) {
  return AppBar(
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        withBackBtn == true ? const BackButton(
              color: Colors.white,
            ) : const SizedBox()
        ,
        ListTile(
          leading: AvatarNetwork(
            imgUrl: companyLogo, withBorder: false,
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
          backgroundColor: primaryColor.withOpacity(0.5),
          hoverColor: primaryTransparent,
        ));
  }
}
