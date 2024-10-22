import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/widgets/tender_card_widget.dart';
import 'package:hr_career_platform/features/tender/data/models/tender_model.dart';
import 'package:hr_career_platform/features/tender/presentation/ui/company_tender_details_page.dart';
import '../../../../core/util/responsive.dart';
import '../../../../core/widgets/jobCard_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../job/domain/entities/job.dart';

import '../../../tender/domain/entities/tender.dart';
import '../../../tender/presentation/ui/tender_detail_page.dart';
import '../bloc/home_cubit.dart';

class RecentTenders extends StatelessWidget {
  const RecentTenders({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return LoadingWidget();
        } else if (state is HomeFetchedState) {
          return Responsive(
              mobile: _buildMobileLayout(state.homes.recentTender),
              tablet:
              _buildTabletDesktopLayout(state.homes.recentJobs, 2, context),
              desktop: _buildTabletDesktopLayout(
                  state.homes.recentJobs, 3, context));
        }
        return const Placeholder();
      },
    );
  }}

Widget _buildMobileLayout(List<Tender>? tender,) {
  return ListView.builder(
      shrinkWrap: true,
      physics: const PageScrollPhysics(),
      itemCount: tender!.length ?? 0,
      itemBuilder: (context, i) => InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) {
               // if( j == JobCardType.companyTender){
                 return TenderDetailsPage(tender: tender[i]);

               // }else {
               //   return TenderDetailsPage(tender: tender[i]);
               //
               // }
              }),
        ),
        child: TenderCard(
          tender: tender[i],),
      ));
}
Widget _buildTabletDesktopLayout(
    List<Job>? jobs, int columnCount, BuildContext context) {
  double itemWidth = MediaQuery.of(context).size.width / columnCount -50 ;
  if(Responsive.isDesktop(context))
    itemWidth = MediaQuery.of(context).size.width / columnCount -100 ;
  return Wrap(
      children: [
        ...jobs!.map(
              (job) => SizedBox(
            width: itemWidth,
            child: JobCard(
              job: job,
              jobCardType: JobCardType.userTender,
              columnWidth: itemWidth,),
          ),
        )
      ]);
}