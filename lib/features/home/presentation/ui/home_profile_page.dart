import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
import '../../../../core/widgets/location_widget.dart';
import '../../../general/domain/entities/general.dart';
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

  var isDisable = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
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
              title: "main_information_msg".tr(),
              titleType: SubTitleType.withIcon,
              iconButton: IconButton(
                  onPressed: () {
                    isDisable = !isDisable;
                    context.read<DynamicFormCubit>().setDisableFiled(isDisable);
                  },
                  icon: const Icon(
                    Icons.edit_road,
                    color: primaryColor,
                  )),
            ),
            _getMainInfProfileForm(state.profile, width, context),
          ],
        );
      } else {
        return const SizedBox();
      }
    });
  }

  Widget _getMainInfProfileForm(
      Profile profile, double width, BuildContext context) {
    General? generals = context.read<GeneralCubit>().general;
    List<ItemModel> nationalityItems = [];
    List<ItemModel> qualificationsItems = [];
    List<ItemModel> genderItems = [];
    if (generals != null) {
      nationalityItems =
          generals.nationality.map((e) => ItemModel(key: e, value: e)).toList();
      qualificationsItems = generals.qualifications
          .map((e) => ItemModel(key: e, value: e))
          .toList();
      genderItems =
          generals.gender.map((e) => ItemModel(key: e, value: e)).toList();
    }
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
          padding: 1,
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
          action: _addExpBtn(context, profile),
          icons: Icon(
            Icons.info_outline_rounded,
            color: primaryColor.withOpacity(0.7),
            size: 18,
          ),
          width:
              Responsive.isMobile(context) ? (width / 2 * 0.98) : defaultWidth,
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
          padding: 0,
          width:
              Responsive.isMobile(context) ? (width / 2 * 0.8) : defaultWidth,
          controller: TextEditingController(),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          key: 'from'),
      DynamicModel('to_date', FormType.date,
          padding: 0,
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
          padding: 0,
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
          padding: 0,
          controller: TextEditingController(),
          items: qualificationsItems,
          // disabled: !state.isDisabled,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          width:
              Responsive.isMobile(context) ? (width / 2 * 0.8) : defaultWidth,
          key: 'qualifications'),
      DynamicModel('where', FormType.text,
          padding: 0,
          controller: TextEditingController(),
          icons: Icon(
            Icons.location_on_outlined,
            color: primaryColor.withOpacity(0.7),
            size: 18,
          ),
          action: _addEduBtn(context, profile),
          width: Responsive.isMobile(context) ? width * 0.91 : defaultWidth,

          // disabled: !state.isDisabled,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          key: 'where'),
    ];
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
      DynamicModel('nationality', FormType.dropdown,
          items: nationalityItems,
          disabled: isDisable,
          key: 'nationality',
          controller: TextEditingController(text: profile.nationality ?? ''),
          width: Responsive.isMobile(context) ? width : defaultWidth,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      /*  DynamicModel('status', FormType.dropdown,
          key: 'status',
          disabled: true,
          controller: TextEditingController(),
          width: Responsive.isMobile(context) ? width : defaultWidth,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),*/
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
          action: _addressActionBtn(context),
          width: Responsive.isMobile(context) ? width : defaultWidth,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('gender', FormType.dropdown,
          key: 'gender',
          items: genderItems,
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
          subFormFooter: _updateMainInfBtn(context, profile),
          controller: TextEditingController(text: profile.currentJob),
          width: Responsive.isMobile(context) ? width : defaultWidth,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ]),
      DynamicModel('experience', FormType.subDynForm,
          key: 'experience',
          subDynamicModel: profileExp,
          width: width,
          subFormFooter: const SizedBox(),
          subFormHeader: Flex(
            direction: Axis.vertical,
            children: [
              SubTitle(
                title: tr("experience_msg"),
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
              ...profile.education.map(
                (e) => BlocBuilder<CurdProfileCubit, CurdProfileState>(
                  builder: (context, state) {
                    if (state is MessageCurdProfileState) {
                      final education = state.profile!.education;
                      education.map((e) => educationWidget(
                          fromDateText:e['from_date'].toString() ,
                          toDateText: e['to_date'].toString(),
                          locationText: e['where'].toString(),
                          infoText: e['studyGrade'].toString(),
                          qualifications: e['qualifications'].toString()));
                    }
                    return educationWidget(
                        fromDateText:e['from_date'].toString() ,
                        toDateText: e['to_date'].toString(),
                        locationText: e['where'].toString(),
                        infoText: e['studyGrade'].toString(),
                        qualifications: e['qualifications'].toString());
                  },
                ),
              ),
            ],
          ),
          subDynamicModel: profileEdc,
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
      key: const Key('profileInf'),
      dynamicFormsList: profileInfo,
      formKey: mainInfoFormKey,
      useResponsiveUi: true,
    );
  }

  _addressActionBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: MaterialButton(
          disabledColor: Colors.grey.shade600,
          padding: const EdgeInsets.all(4),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (context) => LocationWidget(),
            ))
                .then((value) {
              context
                  .read<DynamicFormCubit>()
                  .updateValueOnly('address', value[0].toString());

              print(value[0]);
              print(value[1]);
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

  _updateMainInfBtn(BuildContext context, Profile profile) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
      child: MaterialButton(
        color: primaryColor,
        key: const Key('btnMainInf'),
        // disabledColor: Colors.grey,
        minWidth: 300,
        height: 35,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () async {
          final updateValue =
              context.read<DynamicFormCubit>().getCurrentValue();
          final infoValue = Map<String, dynamic>.from(updateValue)
            ..removeWhere((key, value) =>
                key == 'experience' ||
                key == 'email' ||
                key == 'education' ||
                key == 'pdfName');
          if (kDebugMode) {
            print('mainInformation : ${infoValue}');
          }
          await context
              .read<CurdProfileCubit>()
              .updateProfile(infoValue, profile.id!);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'UpdateMainInf',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            BlocBuilder<CurdProfileCubit, CurdProfileState>(
              builder: (context, state) {
                if (state is LoadingCurdProfileState) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: FittedBox(
                        child: LoadingWidget(
                      progressColor: Colors.white,
                    )),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  _addExpBtn(BuildContext context, Profile profile) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: MaterialButton(
          color: Colors.yellow.shade700,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          key: const Key('btnExp'),
          minWidth: 30,
          padding: const EdgeInsets.symmetric(horizontal: 2),
          height: 26,
          shape: const CircleBorder(),
          onPressed: () {
            final updateValue = context
                .read<DynamicFormCubit>()
                .getCurrentValue()['experience'];

            final expValue = {
              'experience': [...profile.experience, updateValue]
            };
            context
                .read<CurdProfileCubit>()
                .updateProfileExp(expValue, profile.id!);
            context.read<DynamicFormCubit>().resetDynModelByKey('experience');
          },
          child: Center(
            child: BlocBuilder<CurdProfileCubit, CurdProfileState>(
              builder: (context, state) {
                if (state is LoadingExpProfileState) {
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
                    Icons.add,
                    color: Colors.white,
                    size: 16,
                  );
                }
              },
            ),
          )),
    );
  }

  _addEduBtn(BuildContext context, Profile profile) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: MaterialButton(
          color: Colors.yellow.shade700,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          key: const Key('btnEdu'),
          minWidth: 30,
          padding: const EdgeInsets.symmetric(horizontal: 2),
          height: 26,
          shape: const CircleBorder(),
          onPressed: () async {
            final updateValue =
                context.read<DynamicFormCubit>().getCurrentValue()['education'];
            final edcValue = {
              'education': [...profile.education, updateValue]
            };
            await context
                .read<CurdProfileCubit>()
                .updateProfileEdc(edcValue, profile.id!);
            context.read<DynamicFormCubit>().resetDynModelByKey('education');
          },
          child: Center(
            child: BlocBuilder<CurdProfileCubit, CurdProfileState>(
              builder: (context, state) {
                if (state is LoadingEduProfileState) {
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
                    Icons.add,
                    color: Colors.white,
                    size: 16,
                  );
                }
              },
            ),
          )),
    );
  }
}
