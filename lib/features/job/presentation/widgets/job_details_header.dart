import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/widgets/custom_chips.dart';
import 'package:hr_career_platform/core/widgets/image_holder.dart';
import 'package:hr_career_platform/core/widgets/text_with_icon.dart';
import 'package:hr_career_platform/features/job/domain/entities/job.dart';

class JobDetailsHeader extends StatelessWidget {
  final Job job;

  const JobDetailsHeader({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('imgs/jobDtlHdr.png'),
          fit: BoxFit.fill, // Adjust fit as needed
        ),
      ),
      child: jobDetailsCard(job,context),
    );
  }

  Widget jobDetailsCard(Job job, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0 , vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white24,),
            margin: EdgeInsets.symmetric(vertical: 12),
            child: ListTile(
              title: Text(
                job.company!.nameAr,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
              ),
              trailing: Wrap(
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => {},
                    icon: Icon(Icons.bookmark_added_outlined, size: 18),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.orangeAccent.shade400,
                    hoverColor: Colors.orangeAccent,
                    iconSize: 18,
                    splashRadius: 12,
                  ),
                  FilledButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.black12)),
                    onPressed: () {},
                    child: Text(
                      'profile',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),

                ],
              ),
              leading: Wrap(

                crossAxisAlignment: WrapCrossAlignment.start,
                direction: Axis.horizontal,
                children: [
                  BackButton(
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                  ),
                  CircleAvatar(
                    child: ClipOval(
                      child: ImageHolder(
                        url: job.company!.companyLogo ?? '',
                      ),
                    ),
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
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
            padding: const EdgeInsets.symmetric( horizontal: 12.0 ,vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWithIcon(
                  icon: const Icon(
                    Icons.date_range,
                    size: 16,
                    color: Colors.orangeAccent,
                  ),
                  text:
                      '${job.deadlineDate.day}/${job.deadlineDate.month}/${job.deadlineDate.year}',
                  textColor: Colors.white,
                ),
                TextWithIcon(
                  icon: const Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: Colors.white,
                  ),
                  text: '${job.city},${job.address}',
                  textColor: Colors.orangeAccent,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
