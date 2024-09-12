import 'package:flutter/material.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/widgets/text_with_icon.dart';

  Widget experienceWidget ({required String dateText, required String locationText,required String infoText}){
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      alignment: WrapAlignment.start,
      children: [
        TextWithIcon(
          icon: const Icon(
            Icons.date_range_outlined,
            color: primaryColor,
          ),
          text: dateText,
          textColor: primaryTransparent.withOpacity(0.6),
        ),
        TextWithIcon(
            icon: const Icon(
              Icons.location_on_outlined,
              color: primaryColor,
            ),
            text: ' Riyadh Bank -KSA,Jeddah',
            textColor: primaryTransparent.withOpacity(0.6)),
        TextWithIcon(
            icon: const Icon(
              Icons.info_outline_rounded,
              color: primaryColor,
            ),
            text: ' Senior Android Developer',
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
