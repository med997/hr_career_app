import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/features/general/presentation/ui/add_job_body_page.dart';
import 'package:hr_career_platform/features/job/presentation/widgets/job_details_header.dart';
import 'package:hr_career_platform/features/profile/presentation/widgets/profile_card.dart';
import 'package:hr_career_platform/features/profile/presentation/widgets/recent_profile.dart';

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
    bool isEditing = true;
    double width = MediaQuery.of(context).size.width;
    List<DynamicModel> reviewJobForm = [];
    reviewJobForm.addAll([
      DynamicModel('Job Title', FormType.text,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          width: Responsive.isMobile(context) ? width : 300,
          value: '',
          isRequired: true,
          disabled: isEditing),
      DynamicModel('Deadline', FormType.datePicker,
          value: '',
          width: Responsive.isMobile(context) ? width : 300,
          isRequired: true,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          disabled: isEditing),
      DynamicModel('Time parts', FormType.dropdown,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          width: Responsive.isMobile(context) ? width : 300,
          value: '',
          isRequired: true,
          disabled: isEditing),
      DynamicModel('Other apply links', FormType.text,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          value: '',
          width: Responsive.isMobile(context) ? width : 300,
          isRequired: true,
          disabled: isEditing),
      DynamicModel('Job Description', FormType.multiline,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          value: '',
          width: Responsive.isMobile(context) ? width : 300,
          isRequired: true,
          disabled: isEditing),
      DynamicModel('Job requirement', FormType.multiline,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          value: '',
          width: Responsive.isMobile(context) ? width : 300,
          isRequired: true,
          disabled: isEditing),
    ]);
    return Scaffold(
      body: Flex(
        mainAxisAlignment: MainAxisAlignment.start,
        direction: Axis.vertical,
        children: [
          Responsive.isMobile(context)
              ? JobDetailsHeader(
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
                      icon: const Icon(Icons.visibility_off_outlined)))
              : SizedBox(
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
          Center(
            child: ToggleBtnWidget(
              options: const ['Main Information', 'Appliance '],
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
                                width:
                                    Responsive.isMobile(context) ? width : 300,
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
                                              .updateValueOnly('Address',
                                                  value[0].toString());
                                          print(value[0]);
                                          print(value[1]);
                                        },
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      backgroundColor: primaryColor,
                                    ),
                                    child: const Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.white)),
                              ),
                              DynamicModel('Office Type', FormType.dropdown,
                                  validators: [
                                    DynamicFormValidator(
                                        ValidatorType.notEmpty, 'isRequired')
                                  ],
                                  value: '',
                                  width: Responsive.isMobile(context)
                                      ? width
                                      : 300,
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
                                  value: '',
                                  width: Responsive.isMobile(context)
                                      ? width
                                      : 300,
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
                                value: '',
                                width:
                                    Responsive.isMobile(context) ? width : 300,
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
                                value: '',
                                width:
                                    Responsive.isMobile(context) ? width : 300,
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
                                  title: 'Main Information',
                                  titleType: SubTitleType.withIcon,
                                  iconButton: IconButton(
                                      onPressed: () {
                                        isEditing = !isEditing;
                                        context.read<DynamicFormCubit>()
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
                                           borderRadius: BorderRadius.circular(16)),
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
                        padding: EdgeInsets.symmetric(horizontal: 16,),
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
      ),
    );
  }
}
