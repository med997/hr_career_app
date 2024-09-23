import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_localizations.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/core/cubit/toggle_btn_cubit.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/features/company/domain/entities/company.dart';
import 'package:hr_career_platform/features/company/presentation/bloc/company_profile_cubit.dart';
import 'package:hr_career_platform/features/company/presentation/widgets/company_gallery.dart';
import 'package:hr_career_platform/features/profile/presentation/bloc/profile_cubit.dart';
import '../../../../core/model/dynamic_model.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/util/responsive.dart';
import '../../../../core/util/validator.dart';
import '../../../../core/widgets/dyn_form_widget.dart';
import '../../../../core/widgets/sub-title.dart';
import '../../../../core/widgets/toggle_btn_widget.dart';
import '../bloc/curd_company_cubit.dart';
import '../widgets/company_appbar.dart';

class CompanyProfilePage extends StatelessWidget {
  CompanyProfilePage({
    super.key,
  });
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    bool isEditing = true;
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<CompanyProfileCubit, CompanyProfileState>(
  builder: (context, state) {
    if(state is CompanyLoading) {
      return LoadingWidget();
    }
    else if(state is CompanyFetchedState) {
      List<DynamicModel> companyProfile=
         [
          DynamicModel(
              width: Responsive.isMobile(context) ? width : 300,
              'nameAr',
              FormType.text,
              value: '${state.company.nameAr}',
              disabled: isEditing,
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ]),
          DynamicModel('nameEn', FormType.text,
              value: state.company.nameEn,
              width: Responsive.isMobile(context) ? width : 300,
              disabled: isEditing,
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ]),
          DynamicModel('headOffice', FormType.text,
              value: state.company.headOffice,
              width: Responsive.isMobile(context) ? width : 300,
              disabled: isEditing,
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ]),
          DynamicModel('major', FormType.text,
              value: state.company.major,
              width: Responsive.isMobile(context) ? width : 300,
              disabled: isEditing,
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ]),
          DynamicModel('nationality', FormType.dropdown,
              value: state.company.nationality,
              width: Responsive.isMobile(context) ? width : 300,
              disabled: isEditing,
              items: [
                ItemModel(key: state.company.nationality   ?? '', value: state.company.nationality ?? ''),
                ItemModel(key: 'Soudis', value: 'Soudis'),
                ItemModel(key: 'egyptian', value: 'egyptian'),
              ],
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ]),
          DynamicModel('size', FormType.dropdown,
              value: '',
              width: Responsive.isMobile(context) ? width : 300,
              disabled: isEditing,
              items: [
                ItemModel(key: '', value: '0-10'),
                ItemModel(key: '', value: '10-20'),
              ],
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ]),
          DynamicModel('phone', FormType.phone,
              value: state.company.phone,
              width: Responsive.isMobile(context) ? width : 300,
              disabled: isEditing,
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ]),
          DynamicModel('createdAt', FormType.text,
              value: state.company.createdAt,
              width: Responsive.isMobile(context) ? width : 300,
              disabled: isEditing,
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ]),
          DynamicModel('email', FormType.email,
              value: state.company.email,
              width: Responsive.isMobile(context) ? width : 300,
              disabled: isEditing,
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ]),
          DynamicModel('website', FormType.text,
              value: state.company.website,
              width: Responsive.isMobile(context) ? width : 300,
              disabled: isEditing,
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ]),
          DynamicModel('address', FormType.text,
              value: state.company.address,
              width: Responsive.isMobile(context) ? width : 300,
              disabled: isEditing,
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ]),
          DynamicModel('aboutUs', FormType.text,
              value: state.company.aboutUs,
              width: Responsive.isMobile(context) ? width : 300,
              disabled: isEditing,
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ]),
        ];

      return   Responsive(mobile: _buildMobileWidget(context,companyProfile,isEditing,state.company),
            tablet: _buildDesktopWidget(context,companyProfile,isEditing,state.company),
          desktop: _buildDesktopWidget(context,companyProfile,isEditing,state.company), )
        ;
    } else return SizedBox();

  },
);
  }

  _buildMobileWidget(BuildContext context, List<DynamicModel> companyProfile, bool isEditing, Company company) {
    return Scaffold(
        appBar:  jobsAppBarFunction(
        company: company),
    body: BlocProvider(
      create: (context) => DynamicFormCubit()
        ..addAllFields(companyProfile),
      child: BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
        builder: (context, state) {
          switch (state.selectedTab) {
            case 0:
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shrinkWrap: true,
                  children: [
                    Center(
                      child: ToggleBtnWidget(
                        options:  [tr("main_information_msg"),tr("gallery_msg")],
                      ),
                    ),
                    SubTitle(
                      title: tr("main_information_msg"),
                      titleType: SubTitleType.withIcon,
                      iconButton: IconButton(
                        onPressed: () {
                          isEditing = !isEditing;
                          context
                              .read<DynamicFormCubit>()
                              .setDisableFiled(isEditing);
                        },
                        icon: const Icon(
                          Icons.edit_road,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
                        builder: (context, state) {
                          if (state.selectedTab == 0) {
                            context.read<ToggleBtnCubit>().changeTab(0);

                            return DynamicFormWidget(
                              // key: const Key('companyProfile'),
                              dynamicFormsList: companyProfile ,
                              formKey: _formKey,
                              useResponsiveUi: true,
                            );
                          } else
                            context.read<ToggleBtnCubit>().changeTab(1);
                          return SizedBox();
                        }),
                    Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                              color: Colors.yellow.shade700,
                              minWidth: 12,
                              height: 40,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              onPressed: () async {
                                var updateValue = context
                                    .read<DynamicFormCubit>()
                                    .getCurrentValue();
                                await context
                                    .read<CurdCompanyCubit>()
                                    .updateCompany(updateValue);
                                print(updateValue.toString());
                              },
                              child: const Icon(
                                Icons.save_outlined,
                                color: Colors.white,
                                size: 19,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            case 1:
              return ListView(
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                children: [
                  Center(
                    child: ToggleBtnWidget(
                      options:  [tr("main_information_msg"), tr("gallery_msg")],
                    ),
                  ),
                  CompanyGallery(company)
                ],
              );
            default:
              return const SizedBox();
          }
        },
      ),
    )
    );

  }
  _buildDesktopWidget(BuildContext context, List<DynamicModel> companyProfile, bool isEditing,Company company) {
    return  BlocProvider(
      create: (context) => DynamicFormCubit()
        ..addAllFields(companyProfile),
      child: BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
        builder: (context, state) {
          switch (state.selectedTab) {
            case 0:
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 42,vertical: 4),
                    child:   jobsAppBarFunction(
                        type: 'widget',
                        company: company),
                        ),
                    Center(
                      child: ToggleBtnWidget(
                        options: [tr("main_information_msg"), tr("gallery_msg")],
                      ),
                    ),
                    SubTitle(
                      title: tr("main_information_msg"),
                      titleType: SubTitleType.withIcon,
                      iconButton: IconButton(
                        onPressed: () {

                          isEditing = !isEditing;
                          context
                              .read<DynamicFormCubit>()
                            .setDisableFiled(isEditing);
                        },
                        icon: const Icon(
                          Icons.edit_road,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
                        builder: (context, state) {
                          if (state.selectedTab == 0) {
                            context.read<ToggleBtnCubit>().changeTab(0);

                            return Center(
                              child: DynamicFormWidget(
                                // key: const Key('companyProfile'),
                                dynamicFormsList: companyProfile ,
                                formKey: _formKey,
                                useResponsiveUi: true,
                              ),
                            );
                          } else
                            context.read<ToggleBtnCubit>().changeTab(1);
                          return SizedBox();
                        }),
                    Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                              color: Colors.yellow.shade700,
                              minWidth: 12,
                              height: 40,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              onPressed: () async {
                                var updateValue = context
                                    .read<DynamicFormCubit>()
                                    .getCurrentValue();
                                await context
                                    .read<CurdCompanyCubit>()
                                    .updateCompany(updateValue);
                                print(updateValue.toString());
                              },
                              child: const Icon(
                                Icons.save_outlined,
                                color: Colors.white,
                                size: 19,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            case 1:
              return ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  Center(
                    child: ToggleBtnWidget(
                      options:  [tr("main_information_msg"), tr("gallery_msg")],
                    ),
                  ),
                  CompanyGallery(company)
                ],
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );

  }
}
