import 'dart:convert';

import 'package:fleather/fleather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/features/job/presentation/ui/add_job_body_page.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/job_cubit.dart';
import 'package:hr_career_platform/features/job/presentation/widgets/job_details_header.dart';
import 'package:hr_career_platform/features/profile/presentation/bloc/appliance_cubit.dart';
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
import '../../../auth/presentation/bloc/login_cubit.dart';
import '../../../general/presentation/bloc/general_cubit.dart';
import '../../../job/domain/entities/job.dart';
import '../../../job/presentation/bloc/curd_job_cubit.dart';
import '../../../job/presentation/bloc/stepper_cubit.dart';

class CompanyJobDetailsPage extends StatelessWidget {
  final Job job;

  CompanyJobDetailsPage({super.key, required this.job});

  final reviewProfileFormKey = GlobalKey<FormState>();

  bool isEditing = true;

  @override
  Widget build(BuildContext context) {
    context.read<ApplianceCubit>().getAppliance(job.id.toString());

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<JobCubit, JobState>(
          builder: (context, state) {
            if (state is JobLoadingState) {
              return LoadingWidget();
            } else if (state is JobFetchedState) {
              return Responsive(
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
                  ));
            } else
              return SizedBox();
          },
        ),
      ),
    );
  }

  Widget _getDynFormWidget(GeneralFetchedState gnState, BuildContext context, double width) {

    final ParchmentDocument? documentReq = job.jobReqFormated != null
        ? ParchmentDocument.fromJson(jsonDecode(jsonEncode(job.jobReqFormated)))
        : null;
    final ParchmentDocument? documentDesc = job.jobDescFormated != null
        ? ParchmentDocument.fromJson(
            jsonDecode(jsonEncode(job.jobDescFormated)))
        : null;

    final List<DynamicModel> reviewJobForm = [
      DynamicModel('jobTitle', FormType.text,
          key: 'jobTitle',
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          width: width,
          controller: TextEditingController(text: job.jobTitle),
          isRequired: true,
          disabled: isEditing),
      DynamicModel('otherApplyLinks', FormType.text,
          key: 'otherApplyLinks',
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controller: TextEditingController(text: job.otherApplyLinks),
          width: width,
          isRequired: true,
          disabled: isEditing),
      DynamicModel('jobDesc', FormType.multiline,
          key: 'jobDesc',
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controllerFlt: FleatherController(document: documentDesc),
          width: width,
          isRequired: true,
          disabled: isEditing),
      DynamicModel('jobRequirements', FormType.multiline,
          key: 'jobRequirements',
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controllerFlt: FleatherController(document: documentReq),
          width: width,
          isRequired: true,
          disabled: isEditing),
      DynamicModel(
        'address',
        width: width,
        key: 'address',
        FormType.text,
        controller: TextEditingController(text: job.address),
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        isRequired: true,
        disabled: isEditing,
        action: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: MaterialButton(
              disabledColor: Colors.grey.shade600,
              padding: EdgeInsets.all(4),
              onPressed: isEditing == isEditing ? null : () {},
              shape: const CircleBorder(),
              color: primaryColor,
              child: const Icon(
                Icons.location_on_outlined,
                color: Colors.white,
                size: 18,
              )),
        ),
      ),
      DynamicModel('office', FormType.dropdown,
          key: 'office',
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controller: TextEditingController(text: job.office),
          width: width,
          items: [],
          isRequired: true,
          disabled: isEditing),
      DynamicModel('city', FormType.dropdown,
          key: 'city',
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controller: TextEditingController(text: job.city),
          width: width,
          items: [],
          isRequired: true,
          disabled: isEditing),
      DynamicModel('qualifications', FormType.dropdown,
          key: 'qualifications',
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controller: TextEditingController(text: job.qualifications),
          width: width,
          items: [],
          isRequired: true,
          disabled: isEditing),
      DynamicModel('nationalities', FormType.dropdown,
          key: 'nationalities',
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controller: TextEditingController(text: job.nationalities),
          width: width,
          items: [],
          isRequired: true,
          disabled: isEditing),
      DynamicModel('gender', FormType.dropdown,
          key: 'gender',
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controller: TextEditingController(text: job.gender),
          width: width,
          items: [],
          isRequired: true,
          disabled: isEditing),
      DynamicModel('category', FormType.dropdown,
          key: 'category',
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controller: TextEditingController(text: job.category),
          width: width,
          items: [],
          disabled: isEditing),
      DynamicModel('timeParts', FormType.dropdown,
          key: 'timeParts',
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          width: width,
          items: [],
          controller: TextEditingController(text: job.timeParts),
          isRequired: true,
          disabled: isEditing),
    ];
    List<ItemModel> nationalityItems = gnState.generals.nationality
        .map((e) => ItemModel(key: e, value: e))
        .toList();
    List<ItemModel> qualificationsItems = gnState.generals.qualifications
        .map((e) => ItemModel(key: e, value: e))
        .toList();
    List<ItemModel> genderItems = gnState.generals.gender
        .map((e) => ItemModel(key: e, value: e))
        .toList();
    List<ItemModel> officeItems = gnState.generals.officeType
        .map((e) => ItemModel(key: e, value: e))
        .toList();
    List<ItemModel> cityItems = gnState.generals.cities
        .map((e) => ItemModel(key: e, value: e))
        .toList();
    List<ItemModel> categoryItems = gnState.generals.jobCategory
        .map((e) => ItemModel(key: e, value: e))
        .toList();
    List<ItemModel> timePartsItems = gnState.generals.timeParts
        .map((e) => ItemModel(key: e, value: e))
        .toList();
    context.read<DynamicFormCubit>().addMenuItems(
        reviewJobForm.where((element) => element.key == 'nationalities').first,
        nationalityItems,
        job.nationalities!);
    context.read<DynamicFormCubit>().addMenuItems(
        reviewJobForm.where((element) => element.key == 'category').first,
        categoryItems,
        job.category);
    context.read<DynamicFormCubit>().addMenuItems(
        reviewJobForm.where((element) => element.key == 'city').first,
        cityItems,
        job.city);
    context.read<DynamicFormCubit>().addMenuItems(
        reviewJobForm.where((element) => element.key == 'qualifications').first,
        qualificationsItems,
        job.qualifications!);
    context.read<DynamicFormCubit>().addMenuItems(
        reviewJobForm.where((element) => element.key == 'gender').first,
        genderItems,
        job.gender!);
    context.read<DynamicFormCubit>().addMenuItems(
        reviewJobForm.where((element) => element.key == 'timeParts').first,
        timePartsItems,
        job.timeParts);
    context.read<DynamicFormCubit>().addMenuItems(
        reviewJobForm.where((element) => element.key == 'office').first,
        officeItems,
        job.office);

    return DynamicFormWidget(
      key: const Key('jobEditingInf'),
      dynamicFormsList: reviewJobForm,
      formKey: reviewProfileFormKey,
      useResponsiveUi: true,
      submitBtn: MaterialButton(
          color: Colors.yellow.shade700,
          // disabledColor: Colors.grey,
          minWidth: 40,
          height: 40,
          shape: const CircleBorder(),
          onPressed: (){
            final value = context
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
                .read<CurdJobCubit>()
                .updateJob(value, job);
          },
          child:
          BlocBuilder<CurdJobCubit, CurdJobState>(
            builder: (context, state) {
              if (state is LoadingCurdJobState) {
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
          )),
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
        JobDetailsHeader(
            job: job,
            profileFilledText: FilledButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                job.status == 'hidden'
                    ? Colors.grey
                    : job.status == 'completed'
                        ? primaryTransparent
                        : primaryColor,
              )),
              onPressed: () {},
              child: Text(
                job.status.toString(),
                style: const TextStyle(
                  fontSize: 10,
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
                      BlocBuilder<GeneralCubit, GeneralState>(
                          builder: (context, gnState) {
                        if (gnState is GeneralFetchedState) {
                          print('GeneralFetchedState');
                          return _getDynFormWidget(gnState, context, MediaQuery.of(context).size.width);
                        }
                        return const SizedBox();
                      }),
                      Flex(
                        mainAxisAlignment: MainAxisAlignment.end,
                        direction: Axis.horizontal,
                        children: [
                          BlocBuilder<DisableButtonCubit, bool>(
                            builder: (context, isEditing) {
                              if (isEditing == true) {
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
                                                .read<CurdJobCubit>()
                                                .updateJob(value, job);
                                          }
                                        : null,
                                    child:
                                        BlocBuilder<CurdJobCubit, CurdJobState>(
                                      builder: (context, state) {
                                        if (state is LoadingCurdJobState) {
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
                    BlocBuilder<GeneralCubit, GeneralState>(
                      builder: (context, gnState) {

                        if (gnState is GeneralFetchedState) {
                          print('GeneralFetchedState');
                        return _getDynFormWidget(gnState, context, 400);
                        }
                        return const SizedBox();
                      },
                    ),
                  /*  Flex(
                      mainAxisAlignment: MainAxisAlignment.end,
                      direction: Axis.horizontal,
                      children: [
                        BlocBuilder<DisableButtonCubit, bool>(
                          builder: (context, isEditing) {
                            if (isEditing == true) {

                              return
                            }
                            return SizedBox();
                          },
                        ),
                      ],
                    )*/
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
                title: tr("appliance_of_job_msg"),
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
