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
import 'package:hr_career_platform/features/general/presentation/bloc/general_cubit.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/job_cubit.dart';
import 'package:hr_career_platform/features/profile/domain/entities/profile.dart';
import 'package:hr_career_platform/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:hr_career_platform/injection_container.dart' as di;

import '../../../../core/util/responsive.dart';
import '../../../profile/presentation/widgets/education_widget.dart';
import '../../../profile/presentation/widgets/experience_widget.dart';

class HomeProfilePage extends StatefulWidget {
  final Auth auth;
  const HomeProfilePage({super.key, required this.auth});

  @override
  State<HomeProfilePage> createState() => _HomeProfilePageState();
}

class _HomeProfilePageState extends State<HomeProfilePage> {
  final mainInfoFormKey = GlobalKey<FormState>();

  final expFormKey = GlobalKey<FormState>();

  final edcFormKey = GlobalKey<FormState>();

  final uplFormKey = GlobalKey<FormState>();

  double defaultWidth = 300;


  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getUserByUuid(widget.auth.userAuth!.id);

  }

  List<DynamicModel>  profileExp= [
    DynamicModel('from', FormType.date,
        icons: Icon(
          Icons.date_range_outlined,
          color: primaryColor.withOpacity(0.7),
          size: 18,
        ),
        controller: TextEditingController(),

        // disabled: !state.isDisabled,
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        key: 'from'),
    DynamicModel('to', FormType.date,
        controller: TextEditingController(),
        icons: Icon(
          Icons.date_range_outlined,
          color: primaryColor.withOpacity(0.7),
          size: 18,
        ),

        // disabled: !state.isDisabled,
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        key: 'to'),
    DynamicModel('where', FormType.text,
        icons: Icon(
          Icons.location_on_outlined,
          color: primaryColor.withOpacity(0.7),
          size: 18,
        ),
        controller: TextEditingController(),

        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        key: 'where'),
    DynamicModel('jobTitle', FormType.text,
        icons: Icon(
          Icons.info_outline_rounded,
          color: primaryColor.withOpacity(0.7),
          size: 18,
        ),
        controller: TextEditingController(),


        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        key: 'jobTitle'),
  ];

  List<DynamicModel> profileEdc=
  [
    DynamicModel('from', FormType.date,
        icons: Icon(
          Icons.date_range_outlined,
          color: primaryColor.withOpacity(0.7),
          size: 18,
        ),
        controller: TextEditingController(),

        // disabled: !state.isDisabled,
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        key: 'from'),
    DynamicModel('to', FormType.date,
        icons: Icon(
          Icons.date_range_outlined,
          color: primaryColor.withOpacity(0.7),
          size: 18,
        ),
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

        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        key: 'studyGrade'),
    DynamicModel('qualifications ', FormType.dropdown,
        controller: TextEditingController(),
        // disabled: !state.isDisabled,
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        key: 'qualifications'),
    DynamicModel('where', FormType.text,
        controller: TextEditingController(),
        icons: Icon(
          Icons.location_on_outlined,
          color: primaryColor.withOpacity(0.7),
          size: 18,
        ),

        // disabled: !state.isDisabled,
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        key: 'where'),
  ];

  @override
  Widget build(BuildContext context) {
    var isEditing = false;
    double width = MediaQuery.of(context).size.width;
    print('build');
    /*  List<DynamicModel>  = [
      ...profileInf(context, width),


    ];*/
    List<DynamicModel> dynFinalForm;
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return LoadingWidget();
        } else if (state is ProfileFetchedState) {
          print('ProfileFetchedState');
          dynFinalForm = [
            DynamicModel('fullName', FormType.text,
                disabled: true,
                controller: TextEditingController(text: state.profile.fullName),
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ],
                key: 'fullName'),
            DynamicModel('fullNameAr', FormType.text,
                key: 'fullNameAr',
                controller: TextEditingController(text: state.profile.fullNameAr),
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('currentJob', FormType.text,
                key: 'currentJob',
                controller: TextEditingController(text: state.profile.currentJob),
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('dob', FormType.text,
                key: 'dob',
                controller: TextEditingController(text: state.profile.dob.toString()),
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('nationality', FormType.dropdown,
                controller: TextEditingController(),
                key: 'nationality',
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('status', FormType.dropdown,
                key: 'status',
                controller: TextEditingController(),
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('phone', FormType.phone,
                key: 'phone',
                controller: TextEditingController(text: state.profile.phone),
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('secondaryPhone', FormType.phone,

                controller: TextEditingController(text: state.profile.secondaryPhone),
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ],
                key: 'secondaryPhone'),
            DynamicModel('email', FormType.email,
                key: 'email',
                controller: TextEditingController(text: state.profile.email),
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('address', FormType.text,

                key: 'address',
                controller: TextEditingController(text: state.profile.address),
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('gender', FormType.dropdown,
                key: 'gender',
                controller: TextEditingController(),
                width: Responsive.isMobile(context) ? width : defaultWidth,
                validators: [
                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                ]),
            DynamicModel('experience', FormType.subDynForm,
                key: 'experience',
                subDynamicModel: profileExp,
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
                subFormFooter: Flex(
                  direction: Axis.horizontal,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                        minWidth: 75,
                        padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 14),
                        color: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: () {},
                        child: Wrap(
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
                      titleType: SubTitleType.withShowMore,
                    ),
                    ...state.profile.education.map(
                          (e) => educationWidget(
                          dateText: '${e['from_date']}-${e['to_date']}',
                          locationText: e['where'].toString(),
                          infoText: e['title'].toString()),
                    ), //*
                  ],
                ),
                subFormFooter: const SizedBox(),
                subDynamicModel: profileEdc,
                width: Responsive.isMobile(context) ? width : width,
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
                      imgUrl: state.profile.avatarUrl ?? '', withBorder: false),
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
                key: const Key('profileInf'),
                dynamicFormsList: dynFinalForm,
                formKey: mainInfoFormKey,
                useResponsiveUi: true,
              ),
              BlocBuilder<GeneralCubit,GeneralState>(

                  builder: (context, gnState) {
                  if(gnState is GeneralFetchedState){

                List<ItemModel> nationalityItems =  gnState.generals.nationality.map((e) => ItemModel(key: e, value: e)).toList();
                List<ItemModel> qualificationsItems = gnState.generals.qualifications.map((e) => ItemModel(key: e, value: e)).toList();
                List<ItemModel> genderItems =    gnState.generals.gender.map((e) => ItemModel(key: e, value: e)).toList();
                context.read<DynamicFormCubit>().addMenuItems('nationality', nationalityItems, state.profile.nationality!);
                context.read<DynamicFormCubit>().addMenuItems('qualifications', qualificationsItems, '');
                context.read<DynamicFormCubit>().addMenuItems('gender', genderItems, state.profile.gender!);
                return SizedBox();
                  }
                    return SizedBox();
                  },),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
