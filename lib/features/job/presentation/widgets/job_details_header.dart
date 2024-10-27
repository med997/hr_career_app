
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/widgets/avatar_network.dart';
import 'package:hr_career_platform/core/widgets/custom_chips.dart';
import 'package:hr_career_platform/core/widgets/image_holder.dart';
import 'package:hr_career_platform/core/widgets/text_with_icon.dart';
import 'package:hr_career_platform/features/job/domain/entities/job.dart';


import '../../../../core/util/const_val.dart';

class JobDetailsHeader extends StatelessWidget {
  final Job job;
  final Widget profileFilledText;
  final Widget profileIcoButton;

  const JobDetailsHeader(
      {super.key,
      required this.job,
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
      child: jobDetailsCard(job, context),
    );
  }

  Widget jobDetailsCard(Job job, BuildContext context) {
    String imageUrl = job.company!.companyLogo!.isNotEmpty
        ? '$BaseStorageUrl${job.company!.companyLogo!}'
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
                job.company!.nameAr ?? '',
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
              job.jobTitle,
              style: const TextStyle(
                  fontSize: 14
                  ,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomChips(
              chipsTitles: [
                job.category,
                job.office,
                job.timeParts,
                job.nationalities ?? ''
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
                      '${job.deadlineDate!.day}/${job.deadlineDate!.month}/${job.deadlineDate!.year}',
                  textColor: Colors.white,
                ),
                TextWithIcon(
                  icon: const Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: Colors.orangeAccent,
                  ),
                  text: '${job.city},${job.address}',
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
