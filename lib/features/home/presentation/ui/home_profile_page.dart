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
import 'package:hr_career_platform/core/widgets/avatar_network.dart';
import 'package:hr_career_platform/core/widgets/dyn_form_widget.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/core/widgets/sub-title.dart';
import 'package:hr_career_platform/core/widgets/text_with_icon.dart';
import 'package:hr_career_platform/features/auth/domain/entities/auth.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/job_cubit.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:hr_career_platform/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:hr_career_platform/injection_container.dart' as di;

import '../../../../core/util/responsive.dart';
import '../../../profile/presentation/widgets/education_widget.dart';
import '../../../profile/presentation/widgets/experience_widget.dart';

class HomeProfilePage extends StatelessWidget {
  HomeProfilePage({super.key});

  final mainInfoFormKey = GlobalKey<FormState>();
  final expFormKey = GlobalKey<FormState>();
  final edcFormKey = GlobalKey<FormState>();
  final uplFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
      var isEditing = false;
      double width = MediaQuery.of(context).size.width;
      double defaultWidth = 300;

    List<DynamicModel> profileExp() {
      return [
        DynamicModel('from', FormType.text,
            disabled: isEditing,
            icons: Icon(
              Icons.date_range_outlined,
              color: primaryColor.withOpacity(0.7),
              size: 18,
            ),
            width:
                Responsive.isMobile(context) ? (width / 2 * 0.9) : defaultWidth,
            // disabled: !state.isDisabled,
            validators: [
              DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
            ]),
        DynamicModel('to', FormType.text,
            disabled: isEditing,
            icons: Icon(
              Icons.date_range_outlined,
              color: primaryColor.withOpacity(0.7),
              size: 18,
            ),
            width:
                Responsive.isMobile(context) ? (width / 2 * 0.9) : defaultWidth,
            // disabled: !state.isDisabled,
            validators: [
              DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
            ]),
        DynamicModel('where', FormType.text,
            disabled: isEditing,
            icons: Icon(
              Icons.location_on_outlined,
              color: primaryColor.withOpacity(0.7),
              size: 18,
            ),
            width:
                Responsive.isMobile(context) ? (width / 2 * 0.9) : defaultWidth,
            validators: [
              DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
            ]),
        DynamicModel('jobTitle', FormType.text,
            disabled: isEditing,
            icons: Icon(
              Icons.info_outline_rounded,
              color: primaryColor.withOpacity(0.7),
              size: 18,
            ),
            width:
                Responsive.isMobile(context) ? (width / 2 * 0.9) : defaultWidth,
            validators: [
              DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
            ]),
      ];
    }

    List<DynamicModel> profileEdc() {
      return [
        DynamicModel('from', FormType.text,
            disabled: isEditing,
            value: '',
            icons: Icon(
              Icons.date_range_outlined,
              color: primaryColor.withOpacity(0.7),
              size: 18,
            ),
            width:
                Responsive.isMobile(context) ? (width / 2 * 0.9) : defaultWidth,
            // disabled: !state.isDisabled,
            validators: [
              DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
            ]),
        DynamicModel('to', FormType.text,
            disabled: isEditing,
            value: '',
            icons: Icon(
              Icons.date_range_outlined,
              color: primaryColor.withOpacity(0.7),
              size: 18,
            ),
            width:
                Responsive.isMobile(context) ? (width / 2 * 0.9) : defaultWidth,
            // disabled: !state.isDisabled,
            validators: [
              DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
            ]),
        DynamicModel('studyGrade', FormType.text,
            disabled: isEditing,
            value: '',
            icons: Icon(
              Icons.info_outline_rounded,
              color: primaryColor.withOpacity(0.7),
              size: 18,
            ),
            width:
                Responsive.isMobile(context) ? (width / 2 * 0.9) : defaultWidth,
            validators: [
              DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
            ]),
        DynamicModel('qualifications ', FormType.dropdown,
            disabled: isEditing,
            value: ' ',
            items: [
              ItemModel(key: 'High School', value: 'High School'),
              ItemModel(key: 'Associate', value: 'Associate'),
              ItemModel(key: 'Bachelor', value: 'Bachelor'),
              ItemModel(key: 'Master', value: 'Master'),
            ],
            width:
                Responsive.isMobile(context) ? (width / 2 * 0.9) : defaultWidth,
            // disabled: !state.isDisabled,
            validators: [
              DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
            ]),
        DynamicModel('where', FormType.text,
            disabled: isEditing,
            value: '',
            icons: Icon(
              Icons.location_on_outlined,
              color: primaryColor.withOpacity(0.7),
              size: 18,
            ),
            width: Responsive.isMobile(context) ? width * 0.9 : defaultWidth,
            // disabled: !state.isDisabled,
            validators: [
              DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
            ]),
      ];
    }

    List<DynamicModel> profileUpl() {
      return [];
    }

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return LoadingWidget();
        } else if (state is ProfileFetchedState) {
          List<DynamicModel> profileInf = [
            DynamicModel('fullName', FormType.text,
                disabled: isEditing,
                value: state.profile.fullName,
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('fullNameAr', FormType.text,
                disabled: isEditing,
                width: Responsive.isMobile(context) ? width : defaultWidth,
                value: state.profile.fullNameAr,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('currentJob', FormType.text,
                disabled: isEditing,
                value: state.profile.currentJob,
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('dob', FormType.text,
                value: state.profile.dob.toString(),
                width: Responsive.isMobile(context) ? width : defaultWidth,
                disabled: isEditing,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('nationality', FormType.dropdown,
                disabled: isEditing,
                value: state.profile.nationality,
                width: Responsive.isMobile(context) ? width : defaultWidth,
                items: [
                  ItemModel(key: 'saudi', value: 'saudi'),
                  ItemModel(key: 'yemeni', value: 'yemeni'),
                  ItemModel(key: 'egyptian', value: 'egyptian'),
                ],
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('status', FormType.dropdown,
                disabled: isEditing,
                value: '',
                width: Responsive.isMobile(context) ? width : defaultWidth,
                items: [
                  ItemModel(key: 'married', value: 'married'),
                  ItemModel(key: 'single', value: 'single'),
                ],
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('phone', FormType.phone,
                disabled: isEditing,
                value: state.profile.phone,
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('secondaryPhone', FormType.phone,
                disabled: isEditing,
                value: '',
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('email', FormType.email,
                disabled: isEditing,
                value: state.profile.email,
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('address', FormType.text,
                disabled: isEditing,
                value: '',
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('gender', FormType.dropdown,
                disabled: isEditing,
                value: '',
                width: Responsive.isMobile(context) ? width : defaultWidth,
                items: [
                  ItemModel(key: 'male', value: 'male'),
                  ItemModel(key: 'female', value: 'female'),
                ],
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
          ];
          return ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AvatarNetwork(
                        imgUrl: state.profile.avatarUrl ?? '',
                        withBorder: false),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      state.profile.fullName ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                     Text(
                      tr("description_msg"),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Container(
                  height: 60,
                  margin: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: Responsive.isMobile(context) ? 32 : 65),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.blueGrey.withOpacity(0.5), width: 0.5),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white),
                  child: const Flex(
                    direction: Axis.horizontal,
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '27',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('applied')
                          ],
                        ),
                      ),
                      VerticalDivider(),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '19',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('viewed')
                          ],
                        ),
                      ),
                      VerticalDivider(),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '14',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('interview')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SubTitle(
                  title: tr("main_information_msg"),
                  titleType: SubTitleType.withIcon,
                  iconButton: IconButton(
                      onPressed: () {
                        isEditing = !isEditing;
                        context.read<DynamicFormCubit>().replaceAll(profileInf);
                      },
                      icon: const Icon(
                        Icons.edit_road,
                        color: primaryColor,
                      )),
                ),
                BlocProvider(
                  create: (context) =>
                      DynamicFormCubit()..addAllFields(profileInf),
                  child: DynamicFormWidget(
                    key: const Key('profileInf'),
                    dynamicFormsList: profileInf,
                    formKey: mainInfoFormKey,
                    useResponsiveUi: true,
                  ),
                ),
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
                BlocProvider(
                  create: (context) =>
                      DynamicFormCubit()..addAllFields(profileExp()),
                  child: DynamicFormWidget(
                      key: const Key('profileExp'),
                      dynamicFormsList: profileExp(),
                      formKey: expFormKey,
                      useResponsiveUi: true),
                ),
                Flex(
                  direction: Axis.horizontal,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                        minWidth: 75,
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 14),
                        color: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: () {},
                        child:  Wrap(
                          spacing: 4,
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          direction: Axis.horizontal,
                          children: [
                            const Icon(
                              Icons.save_outlined,
                              size: 18,
                              color: Colors.white,
                            ),
                            Text(
                             tr("save_msg"),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
                SubTitle(
                  title: tr("education_msg"),
                  titleType: SubTitleType.withShowMore,
                ),
                ...state.profile.education.map(
                  (e) => educationWidget(
                      dateText: '${e['from_date']}-${e['to_date']}',
                      locationText: e['where'].toString(),
                      infoText: e['title'].toString()),
                ),
                BlocProvider(
                  create: (context) =>
                      DynamicFormCubit()..addAllFields(profileEdc()),
                  child: DynamicFormWidget(
                      key: const Key('profileEdc'),
                      dynamicFormsList: profileEdc(),
                      formKey: edcFormKey,
                      useResponsiveUi: true),
                ),
                SubTitle(
                  title: tr("resume_msg"),
                  titleType: SubTitleType.textOnly,
                ),
                BlocProvider(
                  create: (_)  => DynamicFormCubit()
                    ..addAllFields([
                      DynamicModel('pdfName', FormType.text,
                          disabled: true,
                          action: ElevatedButton(
                              onPressed: () async {
                                FilePickerResult? result =
                                await FilePicker.platform.pickFiles();
                                if (result != null &&
                                    result.files.isNotEmpty) {
                                  String fileName = result.files.first.name;
                                  // context.read<ProfileCubit>().uploadFile(fileName);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                backgroundColor: primaryColor,
                              ),
                              child: const Icon(Icons.cloud_upload_outlined,
                                  color: Colors.white)),
                          inputBorder: InputBorder.none,
                          value: '',
                          validators: [
                            DynamicFormValidator(
                                ValidatorType.notEmpty, 'isRequired')
                          ])
                    ]),

                  child: DynamicFormWidget(
                      key: const Key('profileUpl'),
                      dynamicFormsList: [],

                      formKey: uplFormKey,
                      useResponsiveUi: true),
                )
              ]);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
