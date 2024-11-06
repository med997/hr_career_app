import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:fleather/fleather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/core/widgets/custom_chips.dart';
import 'package:hr_career_platform/features/profile/presentation/bloc/appliance_cubit.dart';
import 'package:hr_career_platform/features/profile/presentation/widgets/recent_profile.dart';

import '../../../../core/app_localizations.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/cubit/toggle_btn_cubit.dart';
import '../../../../core/model/dynamic_model.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/util/responsive.dart';
import '../../../../core/util/validator.dart';
import '../../../../core/widgets/dyn_form_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/square_button_function.dart';
import '../../../../core/widgets/sub-title.dart';
import '../../../../core/widgets/toggle_btn_widget.dart';
import '../../../auth/presentation/bloc/login_cubit.dart';
import '../../../general/domain/entities/general.dart';
import '../../../general/presentation/bloc/general_cubit.dart';
import '../../domain/entities/tender.dart';
import '../bloc/curd_tender_cubit.dart';
import '../widgets/tender_details_header.dart';

class CompanyTenderDetailsPage extends StatelessWidget {
  final Tender tender;

  CompanyTenderDetailsPage({super.key, required this.tender});

  final updateTenderFormKey = GlobalKey<FormState>();

  bool isEditing = true;

  @override
  Widget build(BuildContext context) {
    context.read<ApplianceCubit>().getAppliance(tender.id.toString());

    return Scaffold(
        body: SafeArea(
      child: Responsive(
        mobile: _buildMobileWidget(
          context,
          isEditing,
        ),
        tablet: _buildTabletAndDesktopWidget(
          context,
          isEditing,
        ),
        desktop: _buildTabletAndDesktopWidget(
          context,
          isEditing,
        ),
      ),
    ));
  }

  Widget _getMainInfUpdateTenderForm(double width, BuildContext context) {
    final ParchmentDocument? documentDesc = tender.tenderDescFormated != null
        ? ParchmentDocument.fromJson(
            jsonDecode(jsonEncode(tender.tenderDescFormated)))
        : null;
    General? generals = context.read<GeneralCubit>().general;
    List<ItemModel> nationalityItems = [];
    List<ItemModel> categoryItems = [];
    List<ItemModel> cityItems = [];
    if (generals != null) {
      nationalityItems =
          generals.nationality.map((e) => ItemModel(key: e, value: e)).toList();

      cityItems =
          generals.cities.map((e) => ItemModel(key: e, value: e)).toList();
      categoryItems =
          generals.jobCategory.map((e) => ItemModel(key: e, value: e)).toList();
    }
    List<DynamicModel> updateTenderForm = [
      DynamicModel(
        'tenderTitle',
        FormType.text,
        key: 'tenderTitle',
        disabled: isEditing,
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        width: width,
        controller: TextEditingController(text: tender.tenderTitle),
        isRequired: true,
      ),
      DynamicModel(
        'otherApplyLinks',
        FormType.text,
        key: 'otherApplyLinks',
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        disabled: isEditing,
        controller: TextEditingController(text: tender.otherApplyLinks),
        width: width,
        isRequired: true,
      ),
      DynamicModel(
        'tenderDesc',
        FormType.multiline,
        key: 'tenderDesc',
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        disabled: isEditing,
        controller: TextEditingController(text: documentDesc!.toPlainText()??''),
        controllerFlt: FleatherController(document: documentDesc),
        width: width,
        isRequired: true,
      ),
      DynamicModel(
        'city',
        FormType.dropdown,
        key: 'city',
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        controller: TextEditingController(text: tender.city),
        width: width,
        disabled: isEditing,
        items: cityItems,
        isRequired: true,
      ),
      DynamicModel(
        'nationalities',
        FormType.dropdown,
        key: 'nationalities',
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        controller: TextEditingController(text: tender.nationalities),
        width: width,
        disabled: isEditing,
        items: nationalityItems,
        isRequired: true,
      ),
      DynamicModel(
        'category',
        FormType.dropdown,
        key: 'category',
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        controller: TextEditingController(text: tender.category),
        width: width,
        disabled: isEditing,
        items: categoryItems,
      ),
    ];

    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DynamicFormWidget(
          key: const Key('addTenderDynForm'),
          dynamicFormsList: updateTenderForm,
          formKey: updateTenderFormKey,
          useResponsiveUi: true,
        ),
      ],
    );
  }

  _buildMobileWidget(
    BuildContext context,
    isEditing,
  ) {
    return Flex(
      mainAxisAlignment: MainAxisAlignment.start,
      direction: Axis.vertical,
      children: [
        TenderDetailsHeader(
            tender: tender,
            profileFilledText: CustomChips(chipsTitles: [tender.status??''],bgColor: secondaryColor,),

            profileIcoButton: IconButton(
                iconSize: 18,
                color: Colors.white,
                onPressed: () {},
                icon: const Icon(Icons.visibility_off_outlined))),
        Center(
          child: ToggleBtnWidget(
            options: ["main_information_msg".tr(), "appliance_msg".tr()],
          ),
        ),
        Flexible(
          child: BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
            builder: (context, state) {
              switch (state.selectedTab) {
                case 0:
                  return ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    shrinkWrap: true,
                    children: [
                      SubTitle(
                        title: tr("main_information_msg"),
                        titleType: SubTitleType.withIcon,
                        iconButton: IconButton(
                            onPressed: () {
                              isEditing = !isEditing;
                              context
                                  .read<DynamicFormCubit>()
                                  .setDisableFiled(isEditing);
                              context
                                  .read<DisableButtonCubit>()
                                  .disableButton(isEditing);
                            },
                            icon: const Icon(
                              Icons.edit_road,
                              color: primaryColor,
                            )),
                      ),
                      _getMainInfUpdateTenderForm(
                          MediaQuery.of(context).size.width, context),
                      Flex(
                        mainAxisAlignment: MainAxisAlignment.end,
                        direction: Axis.horizontal,
                        children: [
                          BlocBuilder<DisableButtonCubit, bool>(
                            builder: (context, isEditing) {
                              if (isEditing) {
                                context
                                    .read<DisableButtonCubit>()
                                    .resetButtonState(isEditing);
                                return MaterialButton(
                                    color: Colors.yellow.shade700,
                                    // disabledColor: Colors.grey,
                                    minWidth: 40,
                                    height: 40,
                                    shape: const CircleBorder(),
                                    onPressed: isEditing
                                        ? () {
                                            var value = context
                                                .read<DynamicFormCubit>()
                                                .getCurrentValue();
                                            final companyId = context
                                                .read<LoginCubit>()
                                                .authenticatedUser!
                                                .userAuth!
                                                .id;
                                            print(
                                                'company_id: $companyId ===> $value');
                                            context
                                                .read<CurdTenderCubit>()
                                                .updateTender(
                                                    value, tender);
                                          }
                                        : null,
                                    child: BlocBuilder<CurdTenderCubit,
                                        CurdTenderState>(
                                      builder: (context, state) {
                                        if (state is LoadingCurdTenderState) {
                                          return LoadingWidget(
                                            progressColor: Colors.white,
                                            width: 2,
                                          );
                                        } else {
                                          return const Icon(
                                            Icons.save_outlined,
                                            color: Colors.white,
                                            size: 19,
                                          );
                                        }
                                      },
                                    ));
                              }
                              return SizedBox();
                            },
                          ),
                        ],
                      )
                    ],
                  );

                case 1:
                  return ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    children: [
                      Wrap(
                        alignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          squareButton(
                              clr: Colors.green,
                              icn: Icons.file_upload_outlined,
                              iconLabel: tr("export_excel_msg"),
                              onTap: () {}),
                        ],
                      ),
                      const RecentProfile(),
                    ],
                  );
                default:
                  return const SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }
  _buildTabletAndDesktopWidget(
      BuildContext context,
      isEditing,
      ) {
    double width = 400 /*MediaQuery.of(context).size.width*/;
    return Flex(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      direction: Axis.horizontal,
      children: [
        Flex(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          direction: Axis.vertical,
          children: [
            SizedBox(
              width: 400,
              child: TenderDetailsHeader(
                  tender: tender,
                  profileFilledText: CustomChips(chipsTitles: [tender.status??''],bgColor: secondaryColor,),

                  profileIcoButton: IconButton(
                      iconSize: 18,
                      color: Colors.white,
                      onPressed: () {},
                      icon: const Icon(Icons.visibility_off_outlined))),
            ),
            Expanded(
              child: SizedBox(
                width: width,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  children: [
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
                          )),
                    ),
                    _getMainInfUpdateTenderForm(400, context),

                  ],
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            children: [
              SubTitle(
                title: "Appliance of Tender",
                titleType: SubTitleType.textOnly,
              ),
              const SizedBox(
                height: 20,
              ),
              Wrap(
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  squareButton(
                      clr: Colors.green,
                      icn: Icons.file_upload_outlined,
                      iconLabel: tr("export_excel_msg"),
                      onTap: () {}),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              const RecentProfile(),
            ],
          ),
        )
      ],
    );
  }

}
