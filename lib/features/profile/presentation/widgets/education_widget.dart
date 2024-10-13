import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/widgets/text_with_icon.dart';

Widget educationWidget(
    {required String dateText,
    required String locationText,
    required String infoText,
      required String qualifications}) {
  return Wrap(
    spacing: 8.0,
    runSpacing: 4.0,
    alignment: WrapAlignment.start,
    children: [
      TextWithIcon(
        icon: const Icon(
          Icons.date_range_outlined,
          color: primaryColor,
          size: 16,
        ),
        text: dateText,
        textColor: primaryTransparent.withOpacity(0.6),
      ),
      TextWithIcon(
          icon: const Icon(
            Icons.location_on_outlined,
            color: primaryColor,
            size: 16,
          ),
          text: locationText,
          textColor: primaryTransparent.withOpacity(0.6)),
      TextWithIcon(
          icon: const Icon(
            Icons.info_outline_rounded,
            color: primaryColor,
            size: 16,
          ),
          text: infoText,
          textColor: primaryTransparent.withOpacity(0.6)),
      TextWithIcon(
          icon: const Icon(
            Icons.grade,
            size: 16,
            color: primaryColor,
          ),
          text:qualifications,
          textColor: primaryTransparent.withOpacity(0.6)),
      Divider(
        color: Colors.transparent.withOpacity(0.1),
        thickness: 0.8,
        indent: 30,
        endIndent: 30,
      ),
    ],
  );
}
