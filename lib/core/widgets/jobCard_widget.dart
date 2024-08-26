import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/widgets/avatar_network.dart';
import 'package:hr_career_platform/core/widgets/bloc/image_loader_cubit.dart';
import 'package:hr_career_platform/core/widgets/image_holder.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/core/widgets/text_with_icon.dart';
import 'package:hr_career_platform/injection_container.dart' as di;

class JobCard extends StatelessWidget {
  final String jobTitle;
  final String companyName;
  final String jobLocation;
  final String jobDeadLine;
  final String jobNationality;
  final String companyLogo;
   double?  columnWidth;

    JobCard({
    required this.jobTitle,
    required this.companyName,
    required this.jobLocation,
    required this.companyLogo,
    required this.jobDeadLine,
    required this.jobNationality,
     this.columnWidth,
  });

  @override
  Widget build(BuildContext context) {
    double width= columnWidth ?? 320;
    return Container(

      width: width,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
          border:
              Border.all(color: Colors.blueGrey.withOpacity(0.5), width: 0.5),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4,),
            child: Text(
              jobTitle,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          ListTile(

            leading:  AvatarNetwork(imgUrl: companyLogo??'', withBorder: true,),
            title: Text(
              companyName,
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
                    text: jobDeadLine),
                TextWithIcon(
                    icon: const Icon(
                      Icons.location_on_outlined,
                      size: 18,
                      color: Colors.orangeAccent,
                    ),
                    text: jobLocation),
                TextWithIcon(
                    icon: const Icon(
                      Icons.people_alt_outlined,
                      size: 18,
                      color: Colors.orangeAccent,
                    ),
                    text: jobNationality),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
