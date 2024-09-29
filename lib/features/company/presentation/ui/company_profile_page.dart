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
import '../../../../core/widgets/map_icon_button.dart';
import '../../../../core/widgets/sub-title.dart';
import '../../../../core/widgets/toggle_btn_widget.dart';
import '../../../auth/domain/entities/auth.dart';
import '../../../general/presentation/bloc/general_cubit.dart';
import '../bloc/curd_company_cubit.dart';
import '../widgets/company_appbar.dart';

class CompanyProfilePage extends StatefulWidget {
  final Auth auth;

  CompanyProfilePage({
    super.key,
    required this.auth,
  });

  @override
  State<CompanyProfilePage> createState() => _CompanyProfilePageState();
}

class _CompanyProfilePageState extends State<CompanyProfilePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context
        .read<CompanyProfileCubit>()
        .getCompanyByUuid(widget.auth.userAuth!.id);
  }

  @override
  Widget build(BuildContext context) {
    bool isEditing = true;
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<CompanyProfileCubit, CompanyProfileState>(
        listener: (context, state) {
      if (state is CompanyFetchedState) {
        context.read<GeneralCubit>().getGeneral();
      }
    }, builder: (context, state) {
      BlocListener<GeneralCubit, GeneralState>(listener: (context, gnState) {});
      if (state is CompanyLoading) {
        return LoadingWidget();
      } else if (state is CompanyFetchedState) {
        List<DynamicModel> companyProfile = [
          DynamicModel(
              width: Responsive.isMobile(context) ? width : 300,
              'nameAr',
              key: 'nameAr',
              controller: TextEditingController(text: state.company.nameAr),
              FormType.text,
              disabled: isEditing,
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ]),
          DynamicModel('nameEn', FormType.text,
              key: 'nameEr',
              controller: TextEditingController(text: state.company.nameEn),
              width: Responsive.isMobile(context) ? width : 300,
              disabled: isEditing,
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ]),
          DynamicModel('headOffice', FormType.text,
              key: 'headOffice',
              width: Responsive.isMobile(context) ? width : 300,
              controller: TextEditingController(text: state.company.headOffice),
              disabled: isEditing,
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ]),
          DynamicModel('major', FormType.text,
              key: 'major',
              controller: TextEditingController(text: state.company.major),
              width: Responsive.isMobile(context) ? width : 300,
              disabled: isEditing,
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ]),
          DynamicModel('nationality', FormType.dropdown,
              key: 'nationality',
              width: Responsive.isMobile(context) ? width : 300,
              disabled: isEditing,
              items: [],
              controller: TextEditingController(),
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ]),
          DynamicModel('size', FormType.dropdown,
              key: 'size',
              width: Responsive.isMobile(context) ? width : 300,
              disabled: isEditing,
              controller: TextEditingController(text: ''),
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ]),
          DynamicModel('phone', FormType.phone,
              key: 'phone',
              width: Responsive.isMobile(context) ? width : 300,
              disabled: isEditing,
              controller: TextEditingController(text: state.company.phone),
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ]),
          DynamicModel('createdAt', FormType.text,
              key: 'createdAt',
              width: Responsive.isMobile(context) ? width : 300,
              disabled: isEditing,
              controller: TextEditingController(text: state.company.createdAt),
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ]),
          DynamicModel('email', FormType.email,
              key: 'email',
              width: Responsive.isMobile(context) ? width : 300,
              disabled: isEditing,
              controller: TextEditingController(text: state.company.email),
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ]),
          DynamicModel('website', FormType.text,
              key: 'website',
              width: Responsive.isMobile(context) ? width : 300,
              disabled: isEditing,
              controller: TextEditingController(text: state.company.website),
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ]),
          DynamicModel(
            'address',
            FormType.text,
            controller: TextEditingController(text: state.company.address),
            validators: [
              DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
            ],
            disabled: true,
            width: Responsive.isMobile(context) ? width : 300,
            action: ElevatedButton(
                onPressed: () async   {
                  Navigator.of(context)
                      .push( MaterialPageRoute(
                    builder: (context2) =>  LocationWidget(),
                  ))
                      .then(
                        (value) {
                      context.read<DynamicFormCubit>().updateValueOnly(
                          'address', value[0].toString());
                      print(value[0]);
                      print(value[1]);
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: primaryColor,
                ),
                child: const Icon(Icons.location_on_outlined,
                    color: Colors.white))
          ),
          DynamicModel('aboutUs', FormType.text,
              key: 'aboutUs',
              controller: TextEditingController(text: state.company.aboutUs),
              width: Responsive.isMobile(context) ? width : 300,
              disabled: isEditing,
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ]),
        ];

        return Responsive(
          mobile: _buildMobileWidget(
              context, companyProfile, isEditing, state.company),
          tablet: _buildDesktopWidget(
              context, companyProfile, isEditing, state.company),
          desktop: _buildDesktopWidget(
              context, companyProfile, isEditing, state.company),
        );
      } else
        return SizedBox();
    });
  }

  _buildMobileWidget(BuildContext context, List<DynamicModel> companyProfile,
      bool isEditing, Company company) {
    return Scaffold(
      appBar: jobsAppBarFunction(company: company),
      body: BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
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
                        options: [
                          tr("main_information_msg"),
                          tr("gallery_msg"),
                        ],
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
                    BlocBuilder<GeneralCubit, GeneralState>(
                      builder: (context, gnState) {
                        if (gnState is GeneralFetchedState) {
                          print('GeneralFetchedState');
                          List<ItemModel> nationalityItems = gnState
                              .generals.nationality
                              .map((e) => ItemModel(key: e, value: e))
                              .toList();
                          context.read<DynamicFormCubit>().addMenuItems(
                              companyProfile
                                  .where(
                                      (element) => element.key == 'nationality')
                                  .first,
                              nationalityItems,
                              company.nationality!);
                        }
                        return DynamicFormWidget(
                          key: const Key('companyProfile'),
                          dynamicFormsList: companyProfile,
                          formKey: _formKey,
                          useResponsiveUi: true,
                        );
                      },
                    ),
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
                              borderRadius: BorderRadius.circular(16),
                            ),
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
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            case 1:
              return ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                children: [
                  Center(
                    child: ToggleBtnWidget(
                      options: [
                        tr("main_information_msg"),
                        tr("gallery_msg"),
                      ],
                    ),
                  ),
                  CompanyGallery(company),
                ],
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  _buildDesktopWidget(BuildContext context, List<DynamicModel> companyProfile,
      bool isEditing, Company company) {
    return Scaffold(
      appBar: jobsAppBarFunction(company: company),
      body: BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
        builder: (context, state) {
          switch (state.selectedTab) {
            case 0:
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Center(
                      child: ToggleBtnWidget(
                        options: [
                          tr("main_information_msg"),
                          tr("gallery_msg")
                        ],
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
                    Center(
                      child: BlocBuilder<GeneralCubit, GeneralState>(
                        builder: (context, gnState) {
                          if (gnState is GeneralFetchedState) {
                            print('GeneralFetchedState');
                            List<ItemModel> nationalityItems = gnState
                                .generals.nationality
                                .map((e) => ItemModel(key: e, value: e))
                                .toList();
                            context.read<DynamicFormCubit>().addMenuItems(
                                companyProfile
                                    .where(
                                        (element) => element.key == 'nationality')
                                    .first,
                                nationalityItems,
                                company.nationality!);
                          }
                          return DynamicFormWidget(
                            key: const Key('companyProfile'),
                            dynamicFormsList: companyProfile,
                            formKey: _formKey,
                            useResponsiveUi: true,
                          );
                        },
                      ),
                    ),
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
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [

                    Center(
                      child: ToggleBtnWidget(
                        options: [tr("main_information_msg"), tr("gallery_msg")],
                      ),
                    ),
                    CompanyGallery(company)
                  ],
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
