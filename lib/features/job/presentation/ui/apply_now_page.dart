import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/widgets/app_bar_function.dart';
import 'package:hr_career_platform/core/widgets/avatar_network.dart';
import 'package:hr_career_platform/core/widgets/documents_widget.dart';
import 'package:hr_career_platform/core/widgets/success_dialog.dart';
import 'package:hr_career_platform/features/auth/presentation/bloc/login_cubit.dart';
import 'package:hr_career_platform/features/company/presentation/bloc/company_profile_cubit.dart';
import 'package:hr_career_platform/features/home/presentation/ui/home_page.dart';
import 'package:hr_career_platform/features/profile/presentation/bloc/appliance_cubit.dart';

import '../../../../core/app_localizations.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/cubit/dynamic_form_cubit.dart';
import '../../../../core/model/dynamic_model.dart';
import '../../../../core/util/const_val.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/util/responsive.dart';
import '../../../../core/util/validator.dart';
import '../../../../core/widgets/dyn_form_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/sub-title.dart';
import '../../../auth/domain/entities/auth.dart';
import '../../../general/presentation/bloc/general_cubit.dart';
import '../../../profile/domain/entities/profile.dart';
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
    double width = MediaQuery.of(context).size.width;
    return Scaffold(body: SafeArea(
      child: BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
        if (state is ProfileLoading) {
          return LoadingWidget();
        } else if (state is ProfileFetchedState) {
          context.read<CurdApplianceJobCubit>().resetState();
          String imgUrl = state.profile.avatarUrl != null
              ? '$BaseStorageUrl${state.profile.avatarUrl}'
              : '';

          return Flex(
            direction: Axis.vertical,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: ListTile(
                    trailing: IconButton(onPressed: () {
                      Navigator.pop(context);
                    }, icon: const Icon(Icons.clear)),
                    minLeadingWidth: 48,
                    leading:
                    AvatarNetwork(imgUrl: imgUrl, withBorder: false),
                    title: Text(
                      state.profile.fullName ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                    horizontalTitleGap: 2,
                    minTileHeight: 2,
                    subtitle: Text(
                      state.profile.currentJob ?? '',
                      style: const TextStyle(fontSize: 14),
                    ),
                  )),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                  children: [

                    _getMainInfProfileForm(state.profile, width, context)
                  ],
                ),
              ),
              _confirmBtn()
            ],
          );
        } else {
          return const SizedBox();
        }
      }),
    ));
  }

  Widget _getMainInfProfileForm(
      Profile profile, double width, BuildContext context) {
    bool isDisable = true;
    final List<DynamicModel> profileUpl = [
      DynamicModel('pdfName', FormType.text,
          disabled: isDisable,
          key: 'pdfName',
          controller: TextEditingController(),
          width: Responsive.isMobile(context) ? width : defaultWidth,
          action: ElevatedButton(
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();
                if (result != null && result.files.isNotEmpty) {
                  String fileName = result.files.first.name;
                  // context.read<ProfileCubit>().uploadFile(fileName);
                }
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: EdgeInsets.all(4),
                backgroundColor: primaryColor,
              ),
              child: const Icon(Icons.cloud_upload_outlined,
                  size: 18, color: Colors.white)),
          inputBorder: InputBorder.none,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ])
    ];
    final List<DynamicModel> profileInfo = [
      DynamicModel('full_name', FormType.text,
          disabled: isDisable,
          controller: TextEditingController(text: profile.fullName),
          width: Responsive.isMobile(context) ? width : defaultWidth,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          key: 'fullName'),
      DynamicModel('full_name_ar', FormType.text,
          key: 'fullNameAr',
          disabled: isDisable,
          controller: TextEditingController(text: profile.fullNameAr),
          width: Responsive.isMobile(context) ? width : defaultWidth,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('dob', FormType.date,
          key: 'dob',
          disabled: isDisable,
          controller: TextEditingController(text: profile.dob.toString()),
          width: Responsive.isMobile(context) ? width : defaultWidth,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('nationality', FormType.text,
          disabled: isDisable,
          key: 'nationality',
          controller: TextEditingController(text: profile.nationality ?? ''),
          width: Responsive.isMobile(context) ? width : defaultWidth,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('phone', FormType.phone,
          key: 'phone',
          disabled: isDisable,
          controller: TextEditingController(text: profile.phone),
          width: Responsive.isMobile(context) ? width : defaultWidth,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('secondary_phone', FormType.phone,
          disabled: isDisable,
          controller: TextEditingController(text: profile.secondaryPhone),
          width: Responsive.isMobile(context) ? width : defaultWidth,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          key: 'secondaryPhone'),
      DynamicModel('email', FormType.email,
          key: 'email',
          disabled: true,
          controller: TextEditingController(text: profile.email),
          width: Responsive.isMobile(context) ? width : defaultWidth,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('address', FormType.text,
          key: 'address',
          disabled: isDisable,
          controller: TextEditingController(text: profile.address),
          width: Responsive.isMobile(context) ? width : defaultWidth,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('gender', FormType.text,
          key: 'gender',
          disabled: isDisable,
          controller: TextEditingController(text: profile.gender ?? ''),
          width: Responsive.isMobile(context) ? width : defaultWidth,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('current_job', FormType.txtWithWidget,
          disabled: isDisable,
          padding: 0,
          key: 'currentJob',
          controller: TextEditingController(text: profile.currentJob),
          width: Responsive.isMobile(context) ? width : defaultWidth,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('experience', FormType.subDynForm,
          key: 'experience',
          subDynamicModel: [],
          width: width,
          subFormFooter: const SizedBox(),
          subFormHeader: Flex(
            direction: Axis.vertical,
            children: [
              SubTitle(
                title: "experience_msg".tr(),
                txtSize: 16,
                titleType: SubTitleType.textOnly,
              ),
              ...profile.experience.map(
                (e) => experienceWidget(
                    fromDateText: e['from_date'].toString(),
                    toDateText: e['to_date'].toString(),
                    locationText: e['where'].toString(),
                    infoText: e['title'].toString()),
              ),
            ],
          ),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('education', FormType.subDynForm,
          key: 'education',
          subFormFooter: const SizedBox(),
          subFormHeader: Flex(
            direction: Axis.vertical,
            children: [
              SubTitle(
                title: tr("education_msg"),
                txtSize: 16,
                titleType: SubTitleType.textOnly,
              ),
              ...profile.education.map((e) => educationWidget(
                    fromDateText: e['from_date'].toString(),
                    toDateText: e['to_date'].toString(),
                    locationText: e['where'].toString(),
                    infoText: e['studyGrade'].toString(),
                    qualifications: e['qualifications'].toString(),
                  )),
            ],
          ),
          subDynamicModel: [],
          width: width,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('pdfName', FormType.subDynForm,
          key: 'pdfName',
          subFormHeader: Flex(
            direction: Axis.vertical,
            children: [
              SubTitle(
                title: tr("resume_msg"),
                titleType: SubTitleType.textOnly,
              ),
            ],
          ),
          subFormFooter: const SizedBox(),
          controller: TextEditingController(),
          subDynamicModel: profileUpl,
          width: Responsive.isMobile(context) ? width : width,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
    ];

    return DynamicFormWidget(
      key: const Key('profileInfConf'),
      dynamicFormsList: profileInfo,
      formKey: reviewMainInfoFormKey,
      useResponsiveUi: true,
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
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                        Text(
                          tr("confirm_msg"),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        if (state is LoadingCurdApplianceJobState)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
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
                  state.message.contains('Conflict')
                      ? "you are applied for this job before"
                      : state.message,
                  style: const TextStyle(
                      color: Colors.redAccent, fontWeight: FontWeight.w500),
                )
            ],
          ),
        );
      },
    );
  }
}
