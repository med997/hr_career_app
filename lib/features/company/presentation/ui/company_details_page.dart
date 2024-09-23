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
      DynamicModel('Job Title', FormType.text,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          width: width,
          value: job.jobTitle,
          isRequired: true,
          disabled: isEditing),
      DynamicModel('Deadline', FormType.datePicker,
          value: '',
          width: width,
          isRequired: true,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          disabled: isEditing),
      DynamicModel('Time parts', FormType.dropdown,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          width: width,
          value: job.timeParts,
          isRequired: true,
          disabled: isEditing),
      DynamicModel('Other apply links', FormType.text,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          value: job.otherApplyLinks,
          width: width,
          isRequired: true,
          disabled: isEditing),
      DynamicModel('Job Description', FormType.multiline,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          value: job.jobDesc,
          width: width,
          isRequired: true,
          disabled: isEditing),
      DynamicModel('Job requirement', FormType.multiline,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          value: job.jobRequirements,
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
              child: Text(
                tr("active_msg"),
                style: const TextStyle(
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
            options: [tr("main_information_msg"), tr("appliance_msg")],
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
                              'Address',
                              FormType.text,
                              width: width,
                              controller: TextEditingController(),
                              validators: [
                                DynamicFormValidator(
                                    ValidatorType.notEmpty, 'isRequired')
                              ],
                              value: context
                                  .read<DynamicFormCubit>()
                                  .getCurrentValue()['Address'],
                              isRequired: true,
                              disabled: isEditing,
                              action: ElevatedButton(
                                  onPressed: () async {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => LocationWidget(),
                                    ))
                                        .then(
                                      (value) {
                                        context
                                            .read<DynamicFormCubit>()
                                            .updateValueOnly(
                                                'Address', value[0].toString());
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
                            DynamicModel('Office Type', FormType.dropdown,
                                validators: [
                                  DynamicFormValidator(
                                      ValidatorType.notEmpty, 'isRequired')
                                ],
                                value: job.office,
                                width: width,
                                items: state.generals.officeType
                                    .map(
                                      (e) => ItemModel(key: e, value: e),
                                    )
                                    .toList(),
                                isRequired: true,
                                disabled: isEditing),
                            DynamicModel('Qualifications', FormType.dropdown,
                                validators: [
                                  DynamicFormValidator(
                                      ValidatorType.notEmpty, 'isRequired')
                                ],
                                value: job.qualifications,
                                width: width,
                                items: state.generals.qualifications
                                    .map(
                                      (e) => ItemModel(key: e, value: e),
                                    )
                                    .toList(),
                                isRequired: true,
                                disabled: isEditing),
                            DynamicModel(
                              'Nationality',
                              FormType.dropdown,
                              validators: [
                                DynamicFormValidator(
                                    ValidatorType.notEmpty, 'isRequired')
                              ],
                              value: job.nationalities,
                              width: width,
                              items: state.generals.nationality
                                  .map(
                                    (e) => ItemModel(key: e, value: e),
                                  )
                                  .toList(),
                              isRequired: true,
                              disabled: isEditing,
                            ),
                            DynamicModel(
                              'Gender',
                              FormType.dropdown,
                              validators: [
                                DynamicFormValidator(
                                    ValidatorType.notEmpty, 'isRequired')
                              ],
                              value: job.gender,
                              width: width,
                              items: state.generals.gender
                                  .map(
                                    (e) => ItemModel(key: e, value: e),
                                  )
                                  .toList(),
                              isRequired: true,
                              disabled: isEditing,
                            ),
                          ]);
                          context
                              .read<DynamicFormCubit>()
                              .replaceAll(reviewJobForm);
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
                        RecentProfile(),
                        RecentProfile(),
                        RecentProfile(),
                        RecentProfile()
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
      DynamicModel('Job Title', FormType.text,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          width: width,
          value: job.jobTitle,
          isRequired: true,
          disabled: isEditing),
      DynamicModel('Deadline', FormType.datePicker,
          value: job.deadlineDate.toString(),
          width: width,
          isRequired: true,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          disabled: isEditing),
      DynamicModel('Time parts', FormType.dropdown,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          width: width,
          value: job.timeParts,
          isRequired: true,
          disabled: isEditing),
      DynamicModel('Other apply links', FormType.text,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          value: job.otherApplyLinks,
          width: width,
          isRequired: true,
          disabled: isEditing),
      DynamicModel('Job Description', FormType.multiline,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          value: job.jobDesc,
          width: width,
          isRequired: true,
          disabled: isEditing),
      DynamicModel('Job requirement', FormType.multiline,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          value: job.jobRequirements,
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
                    child: Text(
                      tr("active_msg"),
                      style: const TextStyle(
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
                              'Address',
                              FormType.text,
                              width: width,
                              controller: TextEditingController(),
                              validators: [
                                DynamicFormValidator(
                                    ValidatorType.notEmpty, 'isRequired')
                              ],
                              value: context
                                  .read<DynamicFormCubit>()
                                  .getCurrentValue()['Address'],
                              isRequired: true,
                              disabled: isEditing,
                              action: ElevatedButton(
                                  onPressed: () async {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => LocationWidget(),
                                    ))
                                        .then(
                                      (value) {
                                        context
                                            .read<DynamicFormCubit>()
                                            .updateValueOnly(
                                                'Address', value[0].toString());
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
                            DynamicModel('Office Type', FormType.dropdown,
                                validators: [
                                  DynamicFormValidator(
                                      ValidatorType.notEmpty, 'isRequired')
                                ],
                                value: job.office,
                                width: width,
                                items: state.generals.officeType
                                    .map(
                                      (e) => ItemModel(key: e, value: e),
                                    )
                                    .toList(),
                                isRequired: true,
                                disabled: isEditing),
                            DynamicModel('Qualifications', FormType.dropdown,
                                validators: [
                                  DynamicFormValidator(
                                      ValidatorType.notEmpty, 'isRequired')
                                ],
                                value: job.qualifications,
                                width: width,
                                items: state.generals.qualifications
                                    .map(
                                      (e) => ItemModel(key: e, value: e),
                                    )
                                    .toList(),
                                isRequired: true,
                                disabled: isEditing),
                            DynamicModel(
                              'Nationality',
                              FormType.dropdown,
                              validators: [
                                DynamicFormValidator(
                                    ValidatorType.notEmpty, 'isRequired')
                              ],
                              value: job.nationalities,
                              width: width,
                              items: state.generals.nationality
                                  .map(
                                    (e) => ItemModel(key: e, value: e),
                                  )
                                  .toList(),
                              isRequired: true,
                              disabled: isEditing,
                            ),
                            DynamicModel(
                              'Gender',
                              FormType.dropdown,
                              validators: [
                                DynamicFormValidator(
                                    ValidatorType.notEmpty, 'isRequired')
                              ],
                              value: job.gender,
                              width: width,
                              items: state.generals.gender
                                  .map(
                                    (e) => ItemModel(key: e, value: e),
                                  )
                                  .toList(),
                              isRequired: true,
                              disabled: isEditing,
                            ),
                          ]);
                          context
                              .read<DynamicFormCubit>()
                              .replaceAll(reviewJobForm);
                          return ListView(
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
                              DynamicFormWidget(
                                dynamicFormsList: [],
                                formKey: reviewProfileFormKey,
                                useResponsiveUi: false,
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
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            children: [
              SubTitle(
                title: tr("appliance_of_job_msg"),
                titleType: SubTitleType.textOnly,
              ),
              SizedBox(
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
              SizedBox(
                height: 12,
              ),
              RecentProfile(),
            ],
          ),
        )
      ],
    );
  }
}
