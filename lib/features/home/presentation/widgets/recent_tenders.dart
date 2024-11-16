import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/widgets/tender_card_widget.dart';
import 'package:hr_career_platform/features/tender/data/models/tender_model.dart';
import 'package:hr_career_platform/features/tender/presentation/ui/company_tender_details_page.dart';
import '../../../../core/strings/failures.dart';
import '../../../../core/util/responsive.dart';
import '../../../../core/widgets/err_widget.dart';
import '../../../../core/widgets/jobCard_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../job/domain/entities/job.dart';

import '../../../tender/domain/entities/tender.dart';
import '../../../tender/presentation/ui/tender_detail_page.dart';
import '../bloc/home_cubit.dart';

class RecentTenders extends StatelessWidget {
  final JobCardType jobCardType;
  const RecentTenders({super.key, required this.jobCardType,});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (_, state) {
        if (state is HomeLoading) {
          return LoadingWidget();
        } else if (state is HomeFetchedState) {
          return Responsive(
              mobile: _buildMobileLayout(state.homes.recentTender,jobCardType),
              tablet:
              _buildTabletDesktopLayout(state.homes.recentTender, 2, context),
              desktop: _buildTabletDesktopLayout(
                  state.homes.recentTender, 3, context));
        }else if (state is HomeErrorState) {
          String imgUrl = state.msg == OFFLINE_FAILURE_MESSAGE
              ? 'assets/imgs/conectErr.png'
              : 'assets/imgs/ServerErr.png';
          return ErrWidget(
              imgUrl: imgUrl,
              errorText: state.msg,
              clickedReload: () {
                context.read<HomeCubit>().getHomeUserTender();
              });
        }
        return const SizedBox();
      },
    );
  }

Widget _buildMobileLayout(List<Tender>? tender,JobCardType jobCardType) {
  return ListView.builder(
      shrinkWrap: true,
      physics: const PageScrollPhysics(),
      itemCount: tender!.length ?? 0,
      itemBuilder: (context, i) => InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) {
                if( jobCardType == JobCardType.company){
                 return CompanyTenderDetailsPage(tender: tender[i]);

               }else {
                 return TenderDetailsPage(tender: tender[i]);

               }
              }),
        ),
        child: TenderCard(
          tender: tender[i],),
      ));
}
Widget _buildTabletDesktopLayout(
    List<Tender>? tenders, int columnCount, BuildContext context) {
  double itemWidth = MediaQuery.of(context).size.width / columnCount -50 ;
  if(Responsive.isDesktop(context))
    itemWidth = MediaQuery.of(context).size.width / columnCount -100 ;
  return Wrap(
      children: [
        ...tenders!.map(
              (tender) => SizedBox(
            width: itemWidth,
            child: InkWell(
              onTap:  () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) {
                      if( jobCardType == JobCardType.company){
                        return CompanyTenderDetailsPage(tender: tender);

                      }else {
                        return TenderDetailsPage(tender: tender);

                      }
                    })),
              child: TenderCard(
                tender: tender,),
            ),
          ),
        )
      ]);
}}