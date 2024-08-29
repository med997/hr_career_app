import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/features/company/presentation/bloc/selecte_button_cubit.dart';
import 'package:hr_career_platform/features/company/presentation/widgets/company_button.dart';
import 'package:hr_career_platform/features/company/presentation/widgets/company_feilds.dart';
import '../widgets/company_appbar.dart';

class CompanyProfilePage extends StatelessWidget {
  CompanyProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: jobsAppBarFunction(
          backgroundCompanyImg: '',
          companyEmail: '',
          companyLocation: '',
          companyLogo: '',
          companyMajor: '',
          companyName: '',
          companyNumber: '',
          companyWebsite: ''),
      body: BlocBuilder<SelectButtonCubit, SelectButtonState>(
        builder: (context, state) {
          switch (state.selectIndex) {
            case 0:
              return ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  CompanyButton(),
                  const SizedBox(
                    height: 14,
                  ),
                  CompanyFeilds(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {},
                          style: const ButtonStyle(),
                          icon: const Icon(
                            Icons.save_alt,
                            color: primaryColor,
                          )),
                    ],
                  ),
                ],
              );
            case 1:
              return ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  CompanyButton(),
                ],
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
