


import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/text_with_icon.dart';

class ExperienceWidget extends StatelessWidget {
  const ExperienceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          alignment: WrapAlignment.start,
          children: [
            TextWithIcon(
              icon: const Icon(
                Icons.date_range_outlined,
                color: primaryColor,
              ),
              text: ' 22/11/2021-02/11/2023',
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
                textColor: primaryTransparent.withOpacity(0.6))
          ],
        ),
      ],
    );
  }
}
