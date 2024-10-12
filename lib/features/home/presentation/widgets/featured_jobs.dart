import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/core/widgets/avatar_network.dart';
import 'package:hr_career_platform/core/widgets/custom_chips.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/core/widgets/text_with_icon.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/home_cubit.dart';

import '../../../job/domain/entities/job.dart';
import '../../../job/presentation/ui/job_details_page.dart';

class FeaturedJobs extends StatelessWidget {
  FeaturedJobs();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return  LoadingWidget();
        } else if (state is HomeFetchedState) {
          return Responsive(
              mobile: _mobileFeaturedJob(state.homes.featuredJobs),
              tablet: _desktopFeaturedJob(state.homes.featuredJobs,context),
              desktop: _desktopFeaturedJob(state.homes.featuredJobs, context));
        } else if (state is HomeErrorState) {
          Text(state.msg);
        }
        return const SizedBox();
      },
    );
  }

  Widget _mobileFeaturedJob(List<Job>? featuredJobs) {
    return CarouselSlider(
      options: CarouselOptions(height: 180.0),
      items: featuredJobs!.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,

                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                    image: const DecorationImage(
                      opacity: 0.5,
                      image: AssetImage('assets/imgs/image10.png'),
                      fit: BoxFit.fitWidth, // Adjust fit as needed
                    ),
                    color: primaryColor,
                    border: Border.all(
                      color: primaryColor,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(12)),
                child: featuredJobCard(i,context));
          },
        );
      }).toList(),
    );
  }

  Widget _desktopFeaturedJob(List<Job>? featuredJobs,BuildContext context) {
    return SizedBox(
      height: 160,
      width: MediaQuery.of(context).size.width,
      child:  ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        primary: true,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shrinkWrap: true,
        itemCount: featuredJobs!.length??0,
        itemBuilder: (context, index) =>  Container(
            width: 400,
            height: 140,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
                image: const DecorationImage(
                  opacity: 0.5,
                  image: AssetImage('assets/imgs/image10.png'),
                  fit: BoxFit.fitWidth, // Adjust fit as needed
                ),
                color: primaryColor,
                border: Border.all(
                  color: primaryColor,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(12)),
            child: featuredJobCard(featuredJobs[index],context)),
      ),
    );
  }

  Widget featuredJobCard(Job job,BuildContext context) {
    return InkWell(
      onTap:  () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => JobDetailsPage(job: job) ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
              title: Text(
                job.jobTitle,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
              ),
              subtitle: Text(
                job.company!.nameEn,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              leading: AvatarNetwork(imgUrl: job.company!.companyLogo??'',withBorder: true,)
            ),
            CustomChips(
              chipsTitles: [
                job.category,
                job.office,
                job.timeParts,
                job.nationalities ?? ''
              ],
              txtSize: 12,
              bgColor: Colors.white10,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: TextWithIcon(
                      icon: const Icon(
                        Icons.date_range,
                        size: 16,
                        color: Colors.white,
                      ),
                      text: '${job.deadlineDate!.day}/${job.deadlineDate!.month}/${job.deadlineDate!.year}',
                      textColor: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextWithIcon(
                    icon: const Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: Colors.white,
                    ),
                    text: '${job.city},${job.address}',
                    textColor: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
