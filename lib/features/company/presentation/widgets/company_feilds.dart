import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/features/company/presentation/bloc/company_profile_cubit.dart';

import '../../../../core/model/dynamic_model.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/widgets/dyn_form_widget.dart';
import '../../domain/entities/company.dart';

class CompanyFeilds extends StatelessWidget {
  late Company companyProfile = Company(
    city: '',
    email: '',
    major: '',
    phone: '',
    address: '',
    nameAr: '',
    nameEn: '',
    headOffice: '',
    nationality: '',
    aboutUs: '',
    website: '',
  );
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CompanyProfileCubit, CompanyProfileState>(
      builder: (context, state) {
        return DynamicFormWidget(
          formKey: _formKey,
          dynamicFormsList: [
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
                'Head Office',
                controller: context
                    .read<CompanyProfileCubit>()
                    .companyHeadOfficeProfileProController,
                FormType.text,
                value: companyProfile.headOffice),
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
            // DynamicModel(
            //     disabled: true,
            //     'size',
            //     controller: context
            //         .read<CompanyProfileCubit>()
            //         .companyNationalityProfileController,
            //     FormType.dropdown,
            //     items: [
            //       ItemModel(key: '', value: '0-10'),
            //       ItemModel(key: '', value: '10-20'),
            //       ItemModel(key: '', value: '20-30')
            //     ],
            //     value: ''),
            DynamicModel(
                disabled: true,
                'Phone Number',
                FormType.phone,
                controller: context
                    .read<CompanyProfileCubit>()
                    .companyPhoneNumberProfileProController,
                value: ''),
            DynamicModel(
                disabled: true, 'Start Date', FormType.number, value: ''),
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
          ],
          submitBtnLabel: "edit",
          useResponsiveUi: true,
        );
      },
    );
  }
}
