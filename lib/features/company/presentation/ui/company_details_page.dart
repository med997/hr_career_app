import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/features/general/presentation/ui/add_job_body_page.dart';
import 'package:hr_career_platform/features/job/presentation/widgets/job_details_header.dart';
import 'package:hr_career_platform/features/profile/presentation/widgets/profile_card.dart';
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
import '../../../../core/widgets/map_icon_button.dart';
import '../../../../core/widgets/square_button_function.dart';
import '../../../../core/widgets/sub-title.dart';
import '../../../../core/widgets/toggle_btn_widget.dart';
import '../../../general/presentation/bloc/general_cubit.dart';
import '../../../job/domain/entities/job.dart';
import '../../../job/presentation/bloc/stepper_cubit.dart';

class CompanyDetailsPage extends StatelessWidget {
  final Job job;
  CompanyDetailsPage({super.key, required this.job});
  final reviewProfileFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Responsive(
            mobile: _buildMobileWidget(context),
            tablet: _buildTabletAndDesktopWidget(context),
            desktop: _buildTabletAndDesktopWidget(context)),
      ),
    );
  }

  _buildMobileWidget(BuildContext context) {
    bool isEditing = true;
    double width = MediaQuery.of(context).size.width;
    List<DynamicModel> reviewJobForm = [];
    reviewJobForm.addAll([
      DynamicModel('jobTitle', FormType.text,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          width: width,
          value: '',
          isRequired: true,
          disabled: isEditing),
      DynamicModel('deadlineDate', FormType.datePicker,
          value: job.deadlineDate.toString(),
          width: width,
          isRequired: true,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          disabled: isEditing),
      DynamicModel('otherApplyLinks', FormType.text,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          value: '',
          width: width,
          isRequired: true,
          disabled: isEditing),
      DynamicModel('jobDesc', FormType.multiline,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          value: '',
          width: width,
          isRequired: true,
          disabled: isEditing),
      DynamicModel('jobRequirements', FormType.multiline,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          value: '',
          width: width,
          isRequired: true,
          disabled: isEditing),
    ]);
    return Flex(
      mainAxisAlignment: MainAxisAlignment.start,
      direction: Axis.vertical,
      children: [
        JobDetailsHeader(
            job: job,
            profileFilledText: FilledButton(
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blueAccent)),
              onPressed: () {},
              child:  const Text(
                'Active',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            profileIcoButton: IconButton(
                iconSize: 18,
                color: Colors.white,
                onPressed: () {},
                icon: const Icon(Icons.visibility_off_outlined))),
        Center(
          child: ToggleBtnWidget(
            options: [tr("main_information_msg"), 'Appliance '],
          ),
        ),
        Flexible(
          child: BlocProvider(
            create: (context2) => DynamicFormCubit()..addAllFields([]),
            child: BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
              builder: (context, state) {
                switch (state.selectedTab) {
                  case 0:
                    return BlocBuilder<GeneralCubit, GeneralState>(
                      builder: (context, state) {
                        if (state is GeneralLoading) {
                          return Center(
                            child: LoadingWidget(),
                          );
                        } else if (state is GeneralFetchedState) {
                          reviewJobForm.addAll([
                            DynamicModel(
                              'address',
                              width: width,
                              FormType.text,
                              controller: TextEditingController(),
                              validators: [
                                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                              ],
                              disabled: isEditing,
                              action: ElevatedButton(
                                  onPressed: () async {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context2) => LocationWidget(),
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
                                      color: Colors.white)),
                            ),
                            DynamicModel('office', FormType.dropdown,
                                validators: [
                                  DynamicFormValidator(
                                      ValidatorType.notEmpty, 'isRequired')
                                ],
                                width: width,
                                value: '',
                                items: state.generals.officeType
                                    .map(
                                      (e) => ItemModel(key: e, value: e),
                                )
                                    .toList(),
                                isRequired: true,
                                disabled: isEditing),
                            DynamicModel('city', FormType.dropdown,
                                validators: [
                                  DynamicFormValidator(
                                      ValidatorType.notEmpty, 'isRequired')
                                ],
                                width: width,
                                value: '',
                                items: state.generals.cities
                                    .map(
                                      (e) => ItemModel(key: e, value: e),
                                )
                                    .toList(),
                                isRequired: true,
                                disabled: isEditing),
                            DynamicModel('qualifications', FormType.dropdown,
                                validators: [
                                  DynamicFormValidator(
                                      ValidatorType.notEmpty, 'isRequired')
                                ],
                                width: width,
                                value: '',
                                items: state.generals.qualifications
                                    .map(
                                      (e) => ItemModel(key: e, value: e),
                                )
                                    .toList(),
                                isRequired: true,
                                disabled: isEditing),
                            DynamicModel('nationalities', FormType.dropdown,
                                validators: [
                                  DynamicFormValidator(
                                      ValidatorType.notEmpty, 'isRequired')
                                ],
                                width: width,
                                value: '',
                                items: state.generals.nationality
                                    .map(
                                      (e) => ItemModel(key: e, value: e),
                                )
                                    .toList(),
                                isRequired: true,
                                disabled: isEditing),
                            DynamicModel('gender', FormType.dropdown,
                                validators: [
                                  DynamicFormValidator(
                                      ValidatorType.notEmpty, 'isRequired')
                                ],
                                width: width,
                                value: '',
                                items: state.generals.gender
                                    .map(
                                      (e) => ItemModel(key: e, value: e),
                                )
                                    .toList(),
                                isRequired: true,
                                disabled: isEditing),
                            DynamicModel('category', FormType.dropdown,
                                validators: [
                                  DynamicFormValidator(
                                      ValidatorType.notEmpty, 'isRequired')
                                ],
                                width: width,
                                value: '',
                                items: state.generals.jobCategory
                                    .map(
                                      (e) => ItemModel(key: e, value: e),
                                )
                                    .toList(),
                                isRequired: true,
                                disabled: isEditing),
                            DynamicModel('timeParts', FormType.dropdown,
                                validators: [
                                  DynamicFormValidator(
                                      ValidatorType.notEmpty, 'isRequired')
                                ],
                                width: width,
                                value: '',
                                items: state.generals.timeParts
                                    .map(
                                      (e) => ItemModel(key: e, value: e),
                                )
                                    .toList(),
                                isRequired: true,
                                disabled: isEditing),
                          ]);
                          context
                              .read<DynamicFormCubit>()
                              .replaceAll(reviewJobForm);
                          return ListView(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            shrinkWrap: true,
                            children: [
                              SubTitle(
                                title: tr("main_information_msg"),
                                titleType: SubTitleType.withIcon,
                                iconButton: IconButton(
                                    onPressed: () {
                                      isEditing = !isEditing;
                                      context.read<DynamicFormCubit>().setDisableFiled(isEditing);
                                    },
                                    icon: const Icon(
                                      Icons.edit_road,
                                      color: primaryColor,
                                    )),
                              ),
                              DynamicFormWidget(
                                dynamicFormsList: [],
                                formKey: reviewProfileFormKey,
                                useResponsiveUi: true,
                              ),
                              Flex(
                                mainAxisAlignment: MainAxisAlignment.end,
                                direction: Axis.horizontal,
                                children: [
                                  MaterialButton(
                                      color: Colors.yellow.shade700,
                                      minWidth: 12,
                                      height: 40,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      onPressed: () {},
                                      child: const Icon(
                                        Icons.save_outlined,
                                        color: Colors.white,
                                        size: 19,
                                      ))
                                ],
                              )
                            ],
                          );
                        } else
                          return const SizedBox();
                      },
                    );
                  case 1:
                    return ListView(
                      padding: const EdgeInsets.symmetric(
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
                                iconLabel: 'Export Excel',
                                onTap: () {}),
                          ],
                        ),
                        const RecentProfile(),
                        const RecentProfile(),
                        const RecentProfile(),
                        const RecentProfile()
                      ],
                    );
                  default:
                    return const SizedBox();
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  _buildTabletAndDesktopWidget(BuildContext context) {
    bool isEditing = true;
    double width = 400 /*MediaQuery.of(context).size.width*/;
    List<DynamicModel> reviewJobForm = [];
    reviewJobForm.addAll([
      DynamicModel('jobTitle', FormType.text,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          width: width,
          value: '',
          isRequired: true,
          disabled: isEditing),
      DynamicModel('deadlineDate', FormType.datePicker,
          value: '',
          width: width,
          isRequired: true,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          disabled: isEditing),
      DynamicModel('otherApplyLinks', FormType.text,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          value: '',
          width: width,
          isRequired: true,
          disabled: isEditing),
      DynamicModel('jobDesc', FormType.multiline,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          value: '',
          width: width,
          isRequired: true,
          disabled: isEditing),
      DynamicModel('jobRequirements', FormType.multiline,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          value: '',
          width: width,
          isRequired: true,
          disabled: isEditing),
    ]);
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
              child: JobDetailsHeader(
                  job: job,
                  profileFilledText: FilledButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.blueAccent)),
                    onPressed: () {},
                    child: const Text(
                      'Active',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  profileIcoButton: IconButton(
                      iconSize: 18,
                      color: Colors.white,
                      onPressed: () {},
                      icon: const Icon(Icons.visibility_off_outlined))),
            ),

            /*   ToggleBtnWidget(
              directions: Axis.vertical,
              options: const ['Main Information', 'Appliance '],
            ),*/
            Expanded(
              child: SizedBox(
                width: width,
                child: BlocProvider(
                    create: (context2) => DynamicFormCubit()..addAllFields([]),
                    child: BlocBuilder<GeneralCubit, GeneralState>(
                      builder: (context, state) {
                        if (state is GeneralLoading) {
                          return Center(
                            child: LoadingWidget(),
                          );
                        } else if (state is GeneralFetchedState) {
                          reviewJobForm.addAll([
                            DynamicModel(
                              'address',
                              width: width,
                              FormType.text,
                              controller: TextEditingController(),
                              validators: [
                                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                              ],
                              disabled: isEditing,
                              action: ElevatedButton(
                                  onPressed: () async {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context2) => LocationWidget(),
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
                                      color: Colors.white)),
                            ),
                            DynamicModel('office', FormType.dropdown,
                                validators: [
                                  DynamicFormValidator(
                                      ValidatorType.notEmpty, 'isRequired')
                                ],
                                width: width,
                                value: '',
                                items: state.generals.officeType
                                    .map(
                                      (e) => ItemModel(key: e, value: e),
                                )
                                    .toList(),
                                isRequired: true,
                                disabled: isEditing),
                            DynamicModel('city', FormType.dropdown,
                                validators: [
                                  DynamicFormValidator(
                                      ValidatorType.notEmpty, 'isRequired')
                                ],
                                width: width,
                                value: '',
                                items: state.generals.cities
                                    .map(
                                      (e) => ItemModel(key: e, value: e),
                                )
                                    .toList(),
                                isRequired: true,
                                disabled: isEditing),
                            DynamicModel('qualifications', FormType.dropdown,
                                validators: [
                                  DynamicFormValidator(
                                      ValidatorType.notEmpty, 'isRequired')
                                ],
                                width: width,
                                value: '',
                                items: state.generals.qualifications
                                    .map(
                                      (e) => ItemModel(key: e, value: e),
                                )
                                    .toList(),
                                isRequired: true,
                                disabled: isEditing),
                            DynamicModel('nationalities', FormType.dropdown,
                                validators: [
                                  DynamicFormValidator(
                                      ValidatorType.notEmpty, 'isRequired')
                                ],
                                width: width,
                                value: '',
                                items: state.generals.nationality
                                    .map(
                                      (e) => ItemModel(key: e, value: e),
                                )
                                    .toList(),
                                isRequired: true,
                                disabled: isEditing),
                            DynamicModel('gender', FormType.dropdown,
                                validators: [
                                  DynamicFormValidator(
                                      ValidatorType.notEmpty, 'isRequired')
                                ],
                                width: width,
                                value: '',
                                items: state.generals.gender
                                    .map(
                                      (e) => ItemModel(key: e, value: e),
                                )
                                    .toList(),
                                isRequired: true,
                                disabled: isEditing),
                            DynamicModel('category', FormType.dropdown,
                                validators: [
                                  DynamicFormValidator(
                                      ValidatorType.notEmpty, 'isRequired')
                                ],
                                width: width,
                                value: '',
                                items: state.generals.jobCategory
                                    .map(
                                      (e) => ItemModel(key: e, value: e),
                                )
                                    .toList(),
                                isRequired: true,
                                disabled: isEditing),
                            DynamicModel('timeParts', FormType.dropdown,
                                validators: [
                                  DynamicFormValidator(
                                      ValidatorType.notEmpty, 'isRequired')
                                ],
                                width: width,
                                value: '',
                                items: state.generals.timeParts
                                    .map(
                                      (e) => ItemModel(key: e, value: e),
                                )
                                    .toList(),
                                isRequired: true,
                                disabled: isEditing),
                          ]);
                          context
                              .read<DynamicFormCubit>()
                              .replaceAll(reviewJobForm);
                          return ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                              DynamicFormWidget(
                                dynamicFormsList: [],
                                formKey: reviewProfileFormKey,
                                useResponsiveUi: isEditing,
                              ),
                              Flex(
                                mainAxisAlignment: MainAxisAlignment.end,
                                direction: Axis.horizontal,
                                children: [
                                  MaterialButton(
                                      color: Colors.yellow.shade700,
                                      minWidth: 12,
                                      height: 40,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      onPressed: () {},
                                      child: const Icon(
                                        Icons.save_outlined,
                                        color: Colors.white,
                                        size: 19,
                                      ))
                                ],
                              )
                            ],
                          );
                        } else
                          return const SizedBox();
                      },
                    )),
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
                title: 'Appliances of job',
                titleType: SubTitleType.textOnly,


              ),
              const SizedBox(height: 20,),

              Wrap(
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  squareButton(
                      clr: Colors.green,
                      icn: Icons.file_upload_outlined,
                      iconLabel: 'Export Excel',
                      onTap: () {}),
                ],
              ),
              const SizedBox(height: 12,),
              const RecentProfile(),

            ],
          ),
        )
      ],
    );
  }
}
