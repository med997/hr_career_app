import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/widgets/dyn_form_widget.dart';
import 'package:hr_career_platform/features/company/domain/entities/company.dart';
import 'package:hr_career_platform/features/company/presentation/bloc/company_profile_cubit.dart';
import '../widgets/company_appbar.dart';

class CompanyProfilePage extends StatelessWidget {
  var reasonValidation = true;

  CompanyProfilePage({super.key});

  late Company companyProfile = Company(
      city: '',
      email: '',
      major: '',
      phone: [],
      address: '',
      nameAr: '',
      nameEn: '');

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
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(
                    horizontal: 45,
                  )),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ))),
              child: const Text('Main Information')),
          const SizedBox(
            width: 10,
          ),
          OutlinedButton(
              onPressed: () {},
              style: ButtonStyle(
                  padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(
                    horizontal: 55,
                  )),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ))),
              child: const Text('Gallery')),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<CompanyProfileCubit, CompanyProfileState>(
            builder: (context, state) {
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: const Text(
                    "Main Information",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ));
              return IconButton(
                  onPressed: () {},
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  icon: const Icon(
                    Icons.edit_road,
                    color: primaryColor,
                  ));
            },
          ),
          const SizedBox(
            height: 10,
          ),
          DynamicFormWidget(dynamicFormsList: [
            DynamicModel(
                disabled: true,
                'nameEn',
                controller: context
                    .read<CompanyProfileCubit>()
                    .companyNameEnProfileController,
                FormType.text,
                value: companyProfile.nameEn),
            DynamicModel(
                disabled: true,
                'nameAr',
                controller: context
                    .read<CompanyProfileCubit>()
                    .companyNameArProfileController,
                FormType.text,
                value: companyProfile.nameAr),
            DynamicModel(
                disabled: true,
                'Major',
                controller: context
                    .read<CompanyProfileCubit>()
                    .companyMajorProfileController,
                FormType.text,
                value: companyProfile.major),
            DynamicModel(
                disabled: true,
                'Head Office',
                controller: context
                    .read<CompanyProfileCubit>()
                    .companyHeadOfficeProfileProController,
                FormType.text,
                value: companyProfile.headOffice),
            DynamicModel(
                disabled: true,
                'nationality',
                controller: context
                    .read<CompanyProfileCubit>()
                    .companyNationalityProfileController,
                FormType.dropdown,
                items: [
                  ItemModel(key: 'saudi', value: 'saoudi'),
                  ItemModel(key: 'yemeni', value: 'yemeni'),
                  ItemModel(key: 'egyption', value: 'egyption')
                ],
                value: companyProfile.nationality),
            DynamicModel(
                disabled: true,
                'Email',
                FormType.text,
                controller: context
                    .read<CompanyProfileCubit>()
                    .companyEmailProfileProController,
                value: companyProfile.email),
            DynamicModel(
                disabled: true,
                'Website',
                FormType.text,
                controller: context
                    .read<CompanyProfileCubit>()
                    .companyWebsiteProfileProController,
                value: companyProfile.website),
            DynamicModel(
                disabled: true,
                'Address',
                FormType.text,
                controller: context
                    .read<CompanyProfileCubit>()
                    .companyAddressProfileProController,
                value: companyProfile.address),
            DynamicModel(
                disabled: true,
                'About Us',
                FormType.text,
                controller: context
                    .read<CompanyProfileCubit>()
                    .companyAboutUsProfileProController,
                value: companyProfile.aboutUs),
          ], submitBtnLabel: "edit"),
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
      ),
    );
  }
}
