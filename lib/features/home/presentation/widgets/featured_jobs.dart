import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/core/widgets/avatar_network.dart';
import 'package:hr_career_platform/core/widgets/custom_chips.dart';
import 'package:hr_career_platform/core/widgets/image_holder.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/core/widgets/text_with_icon.dart';
import 'package:hr_career_platform/features/home/presentation/bloc/home_cubit.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/job_cubit.dart';

import '../../../job/domain/entities/job.dart';

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
                child: featuredJobCard(i));
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
            child: featuredJobCard(featuredJobs[index])),
      ),
    );
  }

  Widget featuredJobCard(Job job) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
            title: Text(
              job.jobTitle,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14),
            ),
            subtitle: Text(
              job.company!.nameEn,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            leading: AvatarNetwork(imgUrl: job.company!.companyLogo??'',withBorder: true,)
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: CustomChips(
              chipsTitles: [
                job.category,
                job.office,
                job.timeParts,
                job.nationalities ?? ''
              ],
              txtSize: 11,
              bgColor: Colors.white10,
            ),
          ),
          SizedBox(height: 5,),
          Wrap(
            direction: Axis.horizontal,
            spacing: 4,

            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.spaceBetween,
            children: [
              TextWithIcon(
                icon: const Icon(
                  Icons.date_range,
                  size: 16,
                  color: Colors.white,
                ),
                text:
                    '${job.deadlineDate!.day}/${job.deadlineDate!.month}/${job.deadlineDate!.year}',
                textColor: Colors.white,
              ),
              TextWithIcon(
                icon: const Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: Colors.white,
                ),
                text: '${job.city},${job.address}',
                textColor: Colors.white,
              ),
            ],
          )
        ],
      ),
    );
  }
}
