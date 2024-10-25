import 'dart:convert';

import 'package:fleather/fleather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_localizations.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/core/cubit/toggle_btn_cubit.dart';
import 'package:hr_career_platform/core/util/pick_image_function.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/features/company/domain/entities/company.dart';
import 'package:hr_career_platform/features/company/presentation/bloc/company_profile_cubit.dart';
import 'package:hr_career_platform/features/company/presentation/widgets/company_gallery.dart';
import 'package:hr_career_platform/features/profile/presentation/bloc/profile_cubit.dart';
import '../../../../core/model/dynamic_model.dart';
import '../../../../core/util/const_val.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/util/responsive.dart';
import '../../../../core/util/validator.dart';
import '../../../../core/widgets/avatar_network.dart';
import '../../../../core/widgets/dyn_form_widget.dart';
import '../../../../core/widgets/map_icon_button.dart';
import '../../../../core/widgets/sub-title.dart';
import '../../../../core/widgets/toggle_btn_widget.dart';
import '../../../auth/domain/entities/auth.dart';
import '../../../general/domain/entities/general.dart';
import '../../../general/presentation/bloc/general_cubit.dart';
import '../../../profile/presentation/bloc/curd_profile_cubit.dart';
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
   List<String> latLong=[];
  @override
  void initState() {
    super.initState();
    context
        .read<CompanyProfileCubit>()
        .getCompanyByUuid(widget.auth.userAuth!.id);
  }

  var isDisable = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyProfileCubit, CompanyProfileState>(
        builder: (context, state) {
      if (state is CompanyLoading) {
        return LoadingWidget();
      } else if (state is CompanyFetchedState) {
        return Responsive(
          mobile: _buildMobileWidget(context, isDisable, state.company),
          tablet: _buildDesktopWidget(context, isDisable, state.company),
          desktop: _buildDesktopWidget(context, isDisable, state.company),
        );
      } else
        return SizedBox();
    });
  }

  _buildMobileWidget(BuildContext context, isDisable, Company company) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CompanyAppBarWidget(
            company: company,
            appbarCompanyDetail: true,
            withEditing: true,
          ),
          Center(
            child: ToggleBtnWidget(
              options: [
                tr("main_information_msg"),
                tr("gallery_msg"),
              ],
            ),
          ),
          Flexible(
            child: BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
              builder: (context, state) {
                switch (state.selectedTab) {
                  case 0:
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        shrinkWrap: true,
                        children: [
                          SubTitle(
                            title: tr("main_information_msg"),
                            titleType: SubTitleType.withIcon,
                            iconButton: IconButton(
                              onPressed: () {
                                isDisable = !isDisable;
                                context
                                    .read<DynamicFormCubit>()
                                    .setDisableFiled(isDisable,keysNotEdit: ['email', 'govRegNo']);
                              },
                              icon: const Icon(
                                Icons.edit_road,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          _getMainInfCompanyProfileForm(
                              company, width, context),
                        ],
                      ),
                    );
                  case 1:
                    return ListView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      children: [
                        CompanyGallery(company),
                      ],
                    );
                  default:
                    return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getMainInfCompanyProfileForm(
      Company company, double width, BuildContext context) {
    final ParchmentDocument? documentAboutUs = company.aboutUsFormated != null
        ? ParchmentDocument.fromJson(
        jsonDecode(jsonEncode(company.aboutUsFormated)))
        : ParchmentDocument();
    General? generals = context.read<GeneralCubit>().general;
    List<ItemModel> nationalityItems = [];
    List<ItemModel> sizeItems = [];
    if (generals != null) {
      nationalityItems =
          generals.nationality.map((e) => ItemModel(key: e, value: e)).toList();
    }
    final List<DynamicModel> companyProfile = [
      DynamicModel(
          width: Responsive.isMobile(context) ? width : 300,
          'nameAr',
          key: 'nameAr',
          controller: TextEditingController(text: company.nameAr),
          FormType.text,
          disabled: isDisable,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('nameEn', FormType.text,
          key: 'nameEr',
          controller: TextEditingController(text: company.nameEn),
          width: Responsive.isMobile(context) ? width : 300,
          disabled: isDisable,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('headOffice', FormType.text,
          key: 'headOffice',
          width: Responsive.isMobile(context) ? width : 300,
          controller: TextEditingController(text: company.headOffice),
          disabled: isDisable,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('major', FormType.text,
          key: 'major',
          controller: TextEditingController(text: company.major),
          width: Responsive.isMobile(context) ? width : 300,
          disabled: isDisable,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('nationality', FormType.dropdown,
          key: 'nationality',
          width: Responsive.isMobile(context) ? width : 300,
          disabled: isDisable,
          items: nationalityItems,
          controller: TextEditingController(text: company.nationality ?? ''),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('size', FormType.dropdown,
          key: 'size',
          width: Responsive.isMobile(context) ? width : 300,
          disabled: isDisable,
          controller: TextEditingController(text: ''),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('phone', FormType.phone,
          key: 'phone',
          width: Responsive.isMobile(context) ? width : 300,
          disabled: isDisable,
          controller: TextEditingController(text: company.phone),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('email', FormType.email,
          key: 'email',
          width: Responsive.isMobile(context) ? width : 300,
          disabled: true,
          controller: TextEditingController(text: company.email),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('govRegNo', FormType.number,
          key: 'govRegNo',
          width: Responsive.isMobile(context) ? width : 300,
          disabled: true,
          controller: TextEditingController(text: company.govRegNo),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('website', FormType.text,
          key: 'website',
          width: Responsive.isMobile(context) ? width : 300,
          disabled: isDisable,
          controller: TextEditingController(text: company.website),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel(
        'address',
        FormType.text,
        controller: TextEditingController(text: company.address),
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        key: "address",
        disabled: isDisable,
        width: Responsive.isMobile(context) ? width : 300,
        action: _addressActionBtn(context),
      ),
      DynamicModel('aboutUs', FormType.multiline,
          key: 'aboutUs',
          controllerFlt: FleatherController(document: documentAboutUs),
          controller: TextEditingController(text: documentAboutUs!.toPlainText()??''),

          width: Responsive.isMobile(context) ? width : 300,
          disabled: isDisable,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
    ];

    return DynamicFormWidget(
      key: const Key('companyProfile'),
      dynamicFormsList: companyProfile,
      formKey: _formKey,
      useResponsiveUi: true,
      submitBtn: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MaterialButton(
            color: Colors.yellow.shade700,
            minWidth: 40,
            height: 40,
            shape: const CircleBorder(),
            onPressed: () async {
              var updateValue =
                  context.read<DynamicFormCubit>().getCurrentValue();
              updateValue['id']=widget.auth.userAuth!.id;
              updateValue['locations']=latLong;
              updateValue['companyLogo']=company.companyLogo;
              await context.read<CurdCompanyCubit>().updateCompany(updateValue);
              print(updateValue.toString());
            },
            child: const Icon(
              Icons.save_outlined,
              color: Colors.white,
              size: 19,
            ),
          ),
        ],
      ),
    );
  }

  _addressActionBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: MaterialButton(
          disabledColor: Colors.grey.shade600,
          padding: const EdgeInsets.all(4),
          onPressed: ()async {
            Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (context) => LocationWidget(),
            ))
                .then((value) {
              context
                  .read<DynamicFormCubit>()
                  .updateValueOnly('address', value[0].toString());
              // print(value[0]);
              // print(value[1]);
              latLong = value[1].split(",");
              // print(latLong);
            });
          },
          shape: const CircleBorder(),
          color: primaryColor,
          child: const Icon(
            Icons.location_on_outlined,
            color: Colors.white,
            size: 18,
          )),
    );
  }

  _buildDesktopWidget(BuildContext context, bool isDisable, Company company) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            SubTitle(
              title: tr("main_information_msg"),
              titleType: SubTitleType.withIcon,
              iconButton: IconButton(
                onPressed: () {
                  isDisable = !isDisable;
                  context.read<DynamicFormCubit>().setDisableFiled(isDisable);
                },
                icon: const Icon(
                  Icons.edit_road,
                  color: primaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: BlocBuilder<CurdCompanyCubit, CurdCompanyState>(
                builder: (context, state) {
                  if (state is LoadingCurdCompanyState) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LoadingWidget(
                        width: 2,
                        progressColor: primaryColor,
                      ),
                    );
                  } else if (state is MessageCurdCompanyState) {
                    String imageUrl = state.company.companyLogo != null
                        ? '$BaseStorageUrl${state.company.companyLogo}'
                        : '';
                    return AvatarNetwork(
                      imgUrl: imageUrl,
                      withBorder: false,
                      withEditBtn: true,
                      bgColor: Colors.white,
                      size: 56,
                      editClicked: () async {
                        dynamic path = await pickImage(context);
                        if (path != null) {
                          context
                              .read<CurdCompanyCubit>()
                              .uploadImageCompany(path, company.id!);
                        }
                      },
                    );
                  }
                  String imageUrl = company.companyLogo!.isNotEmpty
                      ? '$BaseStorageUrl${company.companyLogo!}'
                      : '';
                  return AvatarNetwork(
                    imgUrl: imageUrl,
                    withBorder: false,
                    withEditBtn: true,
                    bgColor: Colors.white,
                    size: 56,
                    editClicked: () async {
                      dynamic path = await pickImage(context);
                      if (path != null) {
                        context
                            .read<CurdCompanyCubit>()
                            .uploadImageCompany(path, company.id!);
                      }
                    },
                  );
                },
              ),
            ),
            // BlocBuilder<GeneralCubit, GeneralState>(
            //   builder: (context, gnState) {
            //     if (gnState is GeneralFetchedState) {
            //       print('GeneralFetchedState');
            //       List<ItemModel> nationalityItems = gnState
            //           .generals.nationality
            //           .map((e) => ItemModel(key: e, value: e))
            //           .toList();
            //       context.read<DynamicFormCubit>().addMenuItems(
            //           companyProfile
            //               .where(
            //                   (element) => element.key == 'nationality')
            //               .first,
            //           nationalityItems,
            //           company.nationality!);
            //     }
            //     return DynamicFormWidget(
            //       key: const Key('companyProfile'),
            //       dynamicFormsList: companyProfile,
            //       formKey: _formKey,
            //       useResponsiveUi: true,
            //       submitBtn:  Wrap(
            //         direction: Axis.horizontal,
            //         alignment: WrapAlignment.end,
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //             child: MaterialButton(
            //                 color: Colors.yellow.shade700,
            //                 minWidth: 40,
            //                 height: 40,
            //                 shape: const CircleBorder(),
            //                 onPressed: () async {
            //                   var updateValue = context
            //                       .read<DynamicFormCubit>()
            //                       .getCurrentValue();
            //                   await context
            //                       .read<CurdCompanyCubit>()
            //                       .updateCompany(updateValue);
            //                   print(updateValue.toString());
            //                 },
            //                 child: const Icon(
            //                   Icons.save_outlined,
            //                   color: Colors.white,
            //                   size: 19,
            //                 )),
            //           ),
            //         ],
            //       ),
            //     );
            //   },
            // ),

            /*   SubTitle(
              title: tr("Gallery"),
              titleType: SubTitleType.textOnly,
            ),*/
            CompanyGallery(company)
          ],
        ),
      ),
    );
  }
}
