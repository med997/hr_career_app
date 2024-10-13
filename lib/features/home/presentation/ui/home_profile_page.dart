import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_localizations.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/util/validator.dart';
import 'package:hr_career_platform/core/widgets/dyn_form_widget.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/core/widgets/sub-title.dart';
import 'package:hr_career_platform/features/auth/domain/entities/auth.dart';
import 'package:hr_career_platform/features/general/presentation/bloc/general_cubit.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:hr_career_platform/features/profile/presentation/bloc/curd_profile_cubit.dart';
import 'package:hr_career_platform/features/profile/presentation/bloc/profile_cubit.dart';

import '../../../../core/util/responsive.dart';
import '../../../profile/presentation/widgets/education_widget.dart';
import '../../../profile/presentation/widgets/experience_widget.dart';
import '../../../profile/presentation/widgets/header_profile.dart';

class HomeProfilePage extends StatefulWidget {
  final Auth auth;
  final subFieldSpace = 1.0;

  const HomeProfilePage({super.key, required this.auth});

  @override
  State<HomeProfilePage> createState() => _HomeProfilePageState();
}

class _HomeProfilePageState extends State<HomeProfilePage> {
  final mainInfoFormKey = GlobalKey<FormState>();
  final expFormKey = GlobalKey<FormState>();
  double defaultWidth = 300;

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getUserByUuid(widget.auth.userAuth!.id);
  }

  @override
  Widget build(BuildContext context) {
    var isEditing = false;
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<ProfileCubit, ProfileState>(listener: (context, state) {
      if (state is ProfileFetchedState) {
        context.read<GeneralCubit>().getGeneral();
      }
    }, builder: (context, state) {
      if (state is ProfileLoading) {
        return LoadingWidget();
      } else if (state is ProfileFetchedState) {
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          children: [
            HeaderProfileWidget(
              desc: state.profile.currentJob! ?? '',
              withBox: true,
              editingAvatar: true,
              uuid: state.profile.id,
              avatar: state.profile.avatarUrl ?? '',
              fullName: state.profile.fullName ?? '',
            ),
            SubTitle(
              title: tr("main_information_msg"),
              titleType: SubTitleType.withIcon,
              iconButton: IconButton(
                  onPressed: () {
                    isEditing = !isEditing;
                    context
                        .read<DynamicFormCubit>()
                        .setDisableFiled(isEditing, context);
                  },
                  icon: const Icon(
                    Icons.edit_road,
                    color: primaryColor,
                  )),
            ),
            _getMainInfProfileForm(state.profile, width, context),
            BlocBuilder<GeneralCubit, GeneralState>(
              builder: (context, gnState) {
                if (gnState is GeneralFetchedState) {
                  final List<ItemModel> nationalityItems = gnState
                      .generals.nationality
                      .map((e) => ItemModel(key: e, value: e))
                      .toList();
                  List<ItemModel> qualificationsItems = gnState
                      .generals.qualifications
                      .map((e) => ItemModel(key: e, value: e))
                      .toList();
                  final List<ItemModel> genderItems = gnState.generals.gender
                      .map((e) => ItemModel(key: e, value: e))
                      .toList();
                  context.read<DynamicFormCubit>().addMenuItems2(
                      'gender', genderItems, state.profile.gender!);
                  context.read<DynamicFormCubit>().addMenuItems2('nationality',
                      nationalityItems, state.profile.nationality!);
                  context.read<DynamicFormCubit>().addSubFormMenuItems(
                      'education', 'qualifications', qualificationsItems);
                }
                return const SizedBox();
              },
            ),
          ],
        );
      } else {
        return const SizedBox();
      }
    });
  }

  Widget _getMainInfProfileForm(
      Profile profile, double width, BuildContext context) {
    final List<DynamicModel> profileExp = [
      DynamicModel('from_date', FormType.date,
          icons: Icon(
            Icons.date_range_outlined,
            color: primaryColor.withOpacity(0.7),
            size: 18,
          ),
          padding: widget.subFieldSpace,
          controller: TextEditingController(),
          width:
              Responsive.isMobile(context) ? (width / 2 * 0.8) : defaultWidth,
          // disabled: !state.isDisabled,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          key: 'fromExp'),
      DynamicModel('to_date', FormType.date,
          controller: TextEditingController(),
          padding: widget.subFieldSpace,
          width:
              Responsive.isMobile(context) ? (width / 2 * 0.8) : defaultWidth,
          icons: Icon(
            Icons.date_range_outlined,
            color: primaryColor.withOpacity(0.7),
            size: 18,
          ),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          key: 'toExp'),
      DynamicModel('where', FormType.text,
          padding: widget.subFieldSpace,
          icons: Icon(
            Icons.location_on_outlined,
            color: primaryColor.withOpacity(0.7),
            size: 18,
          ),
          width:
              Responsive.isMobile(context) ? (width / 2 * 0.8) : defaultWidth,
          controller: TextEditingController(),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          key: 'whereExp'),
      DynamicModel('title', FormType.text,
          padding: widget.subFieldSpace,
          icons: Icon(
            Icons.info_outline_rounded,
            color: primaryColor.withOpacity(0.7),
            size: 18,
          ),
          width:
              Responsive.isMobile(context) ? (width / 2 * 0.8) : defaultWidth,
          controller: TextEditingController(),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          key: 'jobTitleExp'),
    ];
    final List<DynamicModel> profileEdc = [
      DynamicModel('from_date', FormType.date,
          icons: Icon(
            Icons.date_range_outlined,
            color: primaryColor.withOpacity(0.7),
            size: 18,
          ),
          width:
              Responsive.isMobile(context) ? (width / 2 * 0.8) : defaultWidth,
          controller: TextEditingController(),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          key: 'from'),
      DynamicModel('to_date', FormType.date,
          icons: Icon(
            Icons.date_range_outlined,
            color: primaryColor.withOpacity(0.7),
            size: 18,
          ),
          width:
              Responsive.isMobile(context) ? (width / 2 * 0.8) : defaultWidth,
          controller: TextEditingController(),
          // disabled: !state.isDisabled,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          key: 'to'),
      DynamicModel('studyGrade', FormType.text,
          controller: TextEditingController(),
          icons: Icon(
            Icons.info_outline_rounded,
            color: primaryColor.withOpacity(0.7),
            size: 18,
          ),
          width:
              Responsive.isMobile(context) ? (width / 2 * 0.8) : defaultWidth,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          key: 'studyGrade'),
      DynamicModel('qualifications', FormType.dropdown,
          controller: TextEditingController(),
          items: [],
          // disabled: !state.isDisabled,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          width:
              Responsive.isMobile(context) ? (width / 2 * 0.8) : defaultWidth,
          key: 'qualifications'),
      DynamicModel('where', FormType.text,
          controller: TextEditingController(),
          icons: Icon(
            Icons.location_on_outlined,
            color: primaryColor.withOpacity(0.7),
            size: 18,
          ),
          width: Responsive.isMobile(context) ? width * 0.91 : defaultWidth,

          // disabled: !state.isDisabled,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          key: 'where'),
    ];
    final List<DynamicModel> profileUpl = [
      DynamicModel('pdfName', FormType.text,
          disabled: true,
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
          disabled: true,
          controller: TextEditingController(text: profile.fullName),
          width: Responsive.isMobile(context) ? width : defaultWidth,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          key: 'fullName'),
      DynamicModel('full_name_ar', FormType.text,
          key: 'fullNameAr',
          disabled: true,
          controller: TextEditingController(text: profile.fullNameAr),
          width: Responsive.isMobile(context) ? width : defaultWidth,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('dob', FormType.date,
          key: 'dob',
          disabled: true,
          controller: TextEditingController(text: profile.dob.toString()),
          width: Responsive.isMobile(context) ? width : defaultWidth,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('nationality', FormType.dropdown,
          items: [],
          disabled: true,
          key: 'nationality',
          controller: TextEditingController(),
          width: Responsive.isMobile(context) ? width : defaultWidth,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('status', FormType.dropdown,
          key: 'status',
          disabled: true,
          controller: TextEditingController(),
          width: Responsive.isMobile(context) ? width : defaultWidth,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('phone', FormType.phone,
          key: 'phone',
          disabled: true,
          controller: TextEditingController(text: profile.phone),
          width: Responsive.isMobile(context) ? width : defaultWidth,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('secondary_phone', FormType.phone,
          disabled: true,
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
          disabled: true,
          controller: TextEditingController(text: profile.address),
          width: Responsive.isMobile(context) ? width : defaultWidth,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('gender', FormType.dropdown,
          key: 'gender',
          items: [],
          disabled: true,
          controller: TextEditingController(),
          width: Responsive.isMobile(context) ? width : defaultWidth,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('current_job', FormType.text,
          disabled: true,
          action: Padding(
            padding: const EdgeInsets.symmetric(horizontal:4),
            child: MaterialButton(
                color: Colors.yellow.shade700,
                key: Key('btnMainInf'),
                // disabledColor: Colors.grey,
                minWidth: 40,
                padding: EdgeInsets.all(4),
                height: 40,
                shape: const CircleBorder(),
                onPressed: () async {
                  final updateValue = context
                      .read<DynamicFormCubit>()
                      .getCurrentValue();
                  final infoValue = Map.from(updateValue.map((key, value) {
                    return MapEntry(key, value);

                  },));
                  print(infoValue);
                  /*
                  await context
                      .read<CurdProfileCubit>()
                      .updateProfile(infoValue, profile.id!);*/
                },
                child: BlocBuilder<CurdProfileCubit, CurdProfileState>(
                  builder: (context, state) {
                    if (state is LoadingCurdProfileState) {
                      return const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
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
          ),
          key: 'currentJob',
          controller: TextEditingController(text: profile.currentJob),
          width: Responsive.isMobile(context) ? width : defaultWidth,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('experience', FormType.subDynForm,
          key: 'experience',
          subDynamicModel: profileExp,
          width: width,
          subFormFooter: MaterialButton(
              color: Colors.yellow.shade700,
              key: Key('btnExp'),
              // disabledColor: Colors.grey,
              minWidth: 40,
              padding: EdgeInsets.all(4),
              height: 40,
              shape: const CircleBorder(),
              onPressed: () async {
                final updateValue = context
                    .read<DynamicFormCubit>()
                    .getCurrentValue()['experience'];

                final expValue = {
                  'experience': [...profile.experience, updateValue]
                };
                await context
                    .read<CurdProfileCubit>()
                    .updateProfileExp(expValue, profile.id!);
              },
              child: BlocBuilder<CurdProfileCubit, CurdProfileState>(
                builder: (context, state) {
                  if (state is LoadingCurdProfileState) {
                    return const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
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
          subFormHeader: Flex(
            direction: Axis.vertical,
            children: [
              SubTitle(
                title: tr("experience_msg"),
                titleType: SubTitleType.textOnly,
              ),
              ...profile.experience.map(
                (e) => experienceWidget(
                    dateText: '${e['from_date']}-${e['to_date']}',
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
          subFormHeader: Flex(
            direction: Axis.vertical,
            children: [
              SubTitle(
                title: tr("education_msg"),
                titleType: SubTitleType.textOnly,
              ),
              ...profile.education.map(
                (e) => BlocBuilder<CurdProfileCubit, CurdProfileState>(
                  builder: (context, state) {
                    return educationWidget(
                        dateText: '${e['from_date']}-${e['to_date']}',
                        locationText: e['where'].toString(),
                        infoText: e['studyGrade'].toString(),
                        qualifications: e['qualifications'].toString());
                  },
                ),
              ),
            ],
          ),
          subFormFooter: MaterialButton(
              color: Colors.yellow.shade700,
              // disabledColor: Colors.grey,
              minWidth: 40,
              height: 40,
              shape: const CircleBorder(),
              onPressed: () async {
                final updateValue = context
                    .read<DynamicFormCubit>()
                    .getCurrentValue()['education'];

                final edcValue = {
                  'education': [...profile.education, updateValue]
                };
                await context
                    .read<CurdProfileCubit>()
                    .updateProfileExp(edcValue, profile.id!);
              },
              child: BlocBuilder<CurdProfileCubit, CurdProfileState>(
                builder: (context, state) {
                  if (state is LoadingCurdProfileState) {
                    return const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
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
          subDynamicModel: profileEdc,
          width: Responsive.isMobile(context) ? width : width,
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
      key: const Key('profileInf'),
      dynamicFormsList: profileInfo,
      formKey: mainInfoFormKey,
      useResponsiveUi: true,
    );
  }
}
