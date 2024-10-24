import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/widgets/avatar_network.dart';
import 'package:hr_career_platform/core/widgets/custom_chips.dart';
import 'package:hr_career_platform/core/widgets/text_with_icon.dart';
import 'package:hr_career_platform/features/job/domain/entities/job.dart';

import '../../features/company/presentation/ui/company_job_details_page.dart';
import '../../features/job/presentation/ui/job_details_page.dart';
import '../app_localizations.dart';
import '../util/const_val.dart';

class JobCard extends StatelessWidget {
  final JobCardType jobCardType;
  final Color? chipBgColor;
  final String? chipText;
  final Job job;
  double? columnWidth;

  JobCard({
    this.jobCardType = JobCardType.user,
    required this.job,
    this.chipBgColor,
    this.chipText,
    this.columnWidth,
  });

  @override
  Widget build(BuildContext context) {
    if (jobCardType == JobCardType.user) {
      return InkWell(
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => JobDetailsPage(job: job)),
              ),
          child: _jobCardUser());
    } else if (jobCardType == JobCardType.company) {
      return InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CompanyJobDetailsPage(job: job),)),
          child: _jobCardCompany());
    }  else return const SizedBox();
  }

  Widget _jobCardUser() {
    double width = columnWidth ?? 320;
    return Container(
      width: width,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          border:
              Border.all(color: Colors.blueGrey.withOpacity(0.5), width: 0.5),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Text(
                  job.jobTitle,
                  style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 14),
                ),
            ),

          ListTile(
            minTileHeight: 38,
            contentPadding:
            const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            leading: AvatarNetwork(
              imgUrl: job.company!.companyLogo != null
                  ? '$BaseStorageUrl${job.company!.companyLogo}'
                  : '',
              withBorder: true,
            ),
            title: Text(
              job.company!.nameEn ?? '',
              style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ),
            subtitle: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 4,
              direction: Axis.horizontal,
              children: [
                TextWithIcon(
                  icon: Icon(
                    Icons.timelapse_outlined,
                    size: 18,
                    color: primaryColor.withOpacity(0.5),
                  ),
                  text: '${job.deadlineDate!.day}/${job.deadlineDate!.month}/${job.deadlineDate!.year}',
                  textColor: primaryTransparent.withOpacity(0.5),
                ),
                TextWithIcon(
                    icon: Icon(
                      Icons.location_on_outlined,
                      size: 18,
                      color: primaryColor.withOpacity(0.5),
                    ),
                    textColor: primaryTransparent.withOpacity(0.5),
                    text: job.city),
                TextWithIcon(
                    icon: Icon(
                      Icons.people_alt_outlined,
                      size: 18,
                      color: primaryColor.withOpacity(0.6),
                    ),
                    textColor: primaryTransparent.withOpacity(0.5),
                    text: job.nationalities ?? 'All'),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _jobCardCompany() {
    double width = columnWidth ?? 320;
    return Container(
      width: width,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          border:
          Border.all(color: Colors.blueGrey.withOpacity(0.5), width: 0.5),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Text(
                   job.jobTitle,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(

                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 14),
                  ),
                ),
              ),

              CustomChips(
                chipsTitles: [job.status??''],
                bgColor: primaryColor,
              ),
            ],
          ),
          ListTile(
            minTileHeight: 38,
            contentPadding:
            const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            leading: AvatarNetwork(
              imgUrl: job.company!.companyLogo != null
                  ? '$BaseStorageUrl${job.company!.companyLogo}'
                  : '',
              withBorder: true,
            ),
            title: Text(
              job.company!.nameEn,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
            subtitle: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 4,
              direction: Axis.horizontal,
              children: [
                TextWithIcon(
                    icon: const Icon(
                      Icons.timelapse_outlined,
                      size: 18,
                      color: Colors.orangeAccent,
                    ),
                    text: '${job.deadlineDate!.day}/${job.deadlineDate!.month}/${job.deadlineDate!.year}'),             // text: '${job.deadlineDate!.hour}h ago'),
                TextWithIcon(
                    icon: const Icon(
                      Icons.location_on_outlined,
                      size: 18,
                      color: Colors.orangeAccent,
                    ),
                    text: job.city),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
