import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/widgets/app_bar_function.dart';
import 'package:hr_career_platform/core/widgets/documents_widget.dart';
import 'package:hr_career_platform/core/widgets/success_dialog.dart';
import 'package:hr_career_platform/features/auth/presentation/bloc/login_cubit.dart';
import 'package:hr_career_platform/features/home/presentation/ui/home_page.dart';

import '../../../../core/app_localizations.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/cubit/dynamic_form_cubit.dart';
import '../../../../core/model/dynamic_model.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/util/responsive.dart';
import '../../../../core/util/validator.dart';
import '../../../../core/widgets/dyn_form_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/sub-title.dart';
import '../../../auth/domain/entities/auth.dart';
import '../../../general/presentation/bloc/general_cubit.dart';
import '../../../profile/presentation/bloc/profile_cubit.dart';
import '../../../profile/presentation/widgets/education_widget.dart';
import '../../../profile/presentation/widgets/experience_widget.dart';
import '../../../profile/presentation/widgets/header_profile.dart';
import '../../domain/entities/job.dart';
import '../bloc/curd_appliance_job_cubit.dart';

class ApplyNowPage extends StatefulWidget {
  final Job job;

  const ApplyNowPage({
    super.key,
    required this.job,
  });

  @override
  State<ApplyNowPage> createState() => _ApplyNowPageState();
}

class _ApplyNowPageState extends State<ApplyNowPage> {
  final reviewMainInfoFormKey = GlobalKey<FormState>();
  double defaultWidth = 300;

  @override
  void initState() {
    super.initState();

    context.read<ProfileCubit>().getUserByUuid(
        context.read<LoginCubit>().authenticatedUser!.userAuth!.id);
  }

  @override
  Widget build(BuildContext context) {
    bool isEditing = true;
    double width = MediaQuery.of(context).size.width;

    List<DynamicModel> reviewDynFinalForm = [];
    return SafeArea(
      child: Scaffold(
          body: BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
        if (state is ProfileFetchedState) {
          context.read<GeneralCubit>().getGeneral();
        }
      }, builder: (context, state) {
        BlocListener<GeneralCubit, GeneralState>(
          listener: (context, gnState) {},
        );
        if (state is ProfileLoading) {
          return LoadingWidget();
        } else if (state is ProfileFetchedState) {
          print('ProfileFetchedState');
          reviewDynFinalForm = [
            DynamicModel('fullName', FormType.text,
                disabled: isEditing,
                controller: TextEditingController(text: state.profile.fullName),
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ],
                key: 'fullName'),
            DynamicModel('fullNameAr', FormType.text,
                key: 'fullNameAr',
                disabled: isEditing,
                controller:
                    TextEditingController(text: state.profile.fullNameAr),
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('currentJob', FormType.text,
                disabled: isEditing,
                key: 'currentJob',
                controller:
                    TextEditingController(text: state.profile.currentJob),
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('dob', FormType.text,
                key: 'dob',
                disabled: isEditing,
                controller:
                    TextEditingController(text: state.profile.dob.toString()),
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('nationality', FormType.dropdown,
                items: [],
                disabled: isEditing,
                key: 'nationality',
                controller:
                    TextEditingController(text: state.profile.nationality),
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('status', FormType.dropdown,
                key: 'status',
                disabled: isEditing,
                controller: TextEditingController(),
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('phone', FormType.phone,
                key: 'phone',
                disabled: isEditing,
                controller: TextEditingController(text: state.profile.phone),
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('secondaryPhone', FormType.phone,
                disabled: isEditing,
                controller:
                    TextEditingController(text: state.profile.secondaryPhone),
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ],
                key: 'secondaryPhone'),
            DynamicModel('email', FormType.email,
                key: 'email',
                disabled: isEditing,
                controller: TextEditingController(text: state.profile.email),
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('address', FormType.text,
                key: 'address',
                disabled: isEditing,
                controller: TextEditingController(text: state.profile.address),
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('gender', FormType.dropdown,
                key: 'gender',
                items: [],
                disabled: isEditing,
                controller: TextEditingController(text: state.profile.gender),
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('experience', FormType.subDynForm,
                key: 'experience',
                disabled: isEditing,
                subDynamicModel: [],
                width: Responsive.isMobile(context) ? width : width,
                subFormHeader: Flex(
                  direction: Axis.vertical,
                  children: [
                    SubTitle(
                      title: tr("experience_msg"),
                      titleType: SubTitleType.textOnly,
                    ),
                    ...state.profile.experience.map(
                      (e) => experienceWidget(
                          dateText: '${e['from_date']}-${e['to_date']}',
                          locationText: e['where'].toString(),
                          infoText: e['title'].toString()),
                    ),
                  ],
                ),
                subFormFooter: const SizedBox(
                  height: 10,
                ),
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('education', FormType.subDynForm,
                key: 'education',
                disabled: isEditing,
                subFormHeader: Flex(
                  direction: Axis.vertical,
                  children: [
                    SubTitle(
                      title: tr("education_msg"),
                      titleType: SubTitleType.textOnly,
                    ),
                    ...state.profile.education.map(
                      (e) => educationWidget(
                          dateText: '${e['from_date']}-${e['to_date']}',
                          locationText: e['where'].toString(),
                          infoText: e['title'].toString()),
                    ), //*
                  ],
                ),
                subFormFooter: const SizedBox(
                  height: 5,
                ),
                subDynamicModel: [],
                width: Responsive.isMobile(context) ? width : width,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
          ];
          return Column(
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Wrap(
                        spacing: 90,
                        direction: Axis.horizontal,
                        children: [
                          const BackButton(
                            color: primaryColor,
                          ),
                          HeaderProfileWidget(
                            withBox: false,
                            desc: state.profile.currentJob??'',
                            avatar: state.profile.avatarUrl ?? '',
                            fullName: state.profile.fullName ?? '',
                          ),
                        ],
                      ),
                    ),
                    DynamicFormWidget(
                      key: const Key('profileInf'),
                      dynamicFormsList: reviewDynFinalForm,
                      formKey: reviewMainInfoFormKey,
                      useResponsiveUi: true,
                    )
                  ],
                ),
              ),
              _confirmBtn()
            ],
          );
        } else {
          return const SizedBox();
        }
      })),
    );
  }

  _confirmBtn() {
    return BlocConsumer<CurdApplianceJobCubit, CurdApplianceJobState>(
      listener: (context, state) {
        if (state is MessageCurdApplianceJobState) {
          showDialog<Color>(
              context: context,
              builder: (BuildContext contextDialog) {
                return SuccessDialog(
                    message: 'completed Done',
                    onDonePressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(
                                  auth: context
                                      .read<LoginCubit>()
                                      .authenticatedUser!)));
                    });
              });
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: 350,
                height: 35,
                child: MaterialButton(
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: () {
                    final profileId = context
                        .read<LoginCubit>()
                        .authenticatedUser!
                        .userAuth!
                        .id;
                    context
                        .read<CurdApplianceJobCubit>()
                        .addApplianceJob(widget.job.id!, profileId);

                    print(profileId);
                    print(widget.job.id);
                  },
                  enableFeedback: false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Confirm',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      if (state is LoadingCurdApplianceJobState)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: FittedBox(
                              child: LoadingWidget(
                            progressColor: Colors.white,
                          )),
                        )
                    ],
                  ),
                ),
              ),
            ),
            if (state is ErrorCurdApplianceJobState)
              Text(
                state.message,
                style: const TextStyle(
                    color: Colors.redAccent, fontWeight: FontWeight.w500),
              )
          ],
        );
      },
    );
  }
}
