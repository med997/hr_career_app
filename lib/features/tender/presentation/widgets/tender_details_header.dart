
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/widgets/avatar_network.dart';
import 'package:hr_career_platform/core/widgets/custom_chips.dart';
import 'package:hr_career_platform/core/widgets/text_with_icon.dart';


import '../../../../core/util/const_val.dart';
import '../../domain/entities/Tender.dart';

class TenderDetailsHeader extends StatelessWidget {
  final Tender tender;
  final Widget profileFilledText;
  final Widget profileIcoButton;

  const TenderDetailsHeader(
      {super.key,
        required this.tender,
        required this.profileFilledText,
        required this.profileIcoButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/imgs/jobDtlHdr.png'),
          fit: BoxFit.fill, // Adjust fit as needed
        ),
      ),
      child: TenderDetailsCard(tender, context),
    );
  }

  Widget TenderDetailsCard(Tender tender, BuildContext context) {
    String imageUrl = tender.company!.companyLogo!.isNotEmpty
        ? '$BaseStorageUrl${tender.company!.companyLogo!}'
        : '';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white24,
            ),
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 2),

              title: Text(
                tender.company!.nameAr ?? '',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14),
              ),

              trailing: Wrap(
                direction: Axis.horizontal,
                spacing: 2,
                alignment: WrapAlignment.center,
                children: [profileIcoButton, profileFilledText],
              ),
              leading: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.horizontal,
                children: [
                  BackButton(
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                  ),
                  AvatarNetwork(
                    imgUrl: imageUrl,
                    withBorder:false,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              textAlign: TextAlign.center,
              tender.tenderTitle,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomChips(
              chipsTitles: [
                tender.category,
                tender.nationalities ?? ''
              ],
              bgColor: Colors.white10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              direction: Axis.horizontal,
              spacing: 4,
              runSpacing: 4,
              children: [
                TextWithIcon(
                  icon: const Icon(
                    Icons.date_range,
                    size: 16,
                    color: Colors.orangeAccent,
                  ),
                  text:
                  '${tender.deadlineDate!.day}/${tender.deadlineDate!.month}/${tender.deadlineDate!.year}',
                  textColor: Colors.white,
                ),
                TextWithIcon(
                  icon: const Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: Colors.orangeAccent,
                  ),
                  text: '${tender.city}',
                  textColor: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
