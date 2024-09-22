import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/core/cubit/toggle_btn_cubit.dart';
import '../../../../core/model/dynamic_model.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/util/responsive.dart';
import '../../../../core/util/validator.dart';
import '../../../../core/widgets/dyn_form_widget.dart';
import '../../../../core/widgets/sub-title.dart';
import '../../../../core/widgets/toggle_btn_widget.dart';
import '../widgets/company_appbar.dart';

class CompanyProfileDetailPage extends StatelessWidget {
  CompanyProfileDetailPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: jobsAppBarFunction(
          backgroundCompanyImg: 'assets/imgs/google_background.png',
          companyEmail: '',
          companyLocation: 'US, California',
          companyLogo: 'assets/imgs/google_logo.png',
          companyMajor: 'Software Engineering',
          companyName: 'Google',
          companyNumber: '',
          companyWebsite: '',
          appbarCompanyDetail: true),
      body: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.vertical,
        children: [
          Center(
            child: ToggleBtnWidget(
              options: const ['About us', 'Jobs','Tender', 'Gallery',],
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
    );
  }
}
