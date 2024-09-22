import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/cubit/toggle_btn_cubit.dart';
import 'package:hr_career_platform/features/company/domain/entities/company.dart';

import '../../../../core/app_localizations.dart';
import '../../../../core/widgets/toggle_btn_widget.dart';
import '../widgets/company_appbar.dart';

class CompanyProfileDetailPage extends StatelessWidget {
  final Company company;
  CompanyProfileDetailPage({
    super.key, required this.company,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: jobsAppBarFunction(
         company: company,
            appbarCompanyDetail: true),
        body: Flex(
          crossAxisAlignment: CrossAxisAlignment.start,
          direction: Axis.vertical,
          children: [
            Center(
              child: ToggleBtnWidget(
                options: [tr("about_us_msg"), tr("jobs_msg"),tr("tenders_msg"), tr("gallery_msg"),],
              ),
            ),
            BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
            builder: (context, state) {
              switch (state.selectedTab) {
                case 0:
                  return SizedBox();
                case 1:
                  return SizedBox();
                case 2:
                  return SizedBox();
                default:
                  return const SizedBox();
              }
            },
          ),]
        ),
      ),
    );
  }
}
