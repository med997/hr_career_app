import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/core/cubit/location_cubit.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/util/validator.dart';
import 'package:hr_career_platform/core/widgets/dyn_form_widget.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/core/widgets/map_icon_button.dart';
import 'package:hr_career_platform/features/general/domain/entities/general.dart';
import 'package:hr_career_platform/features/general/presentation/bloc/general_cubit.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/stepper_cubit.dart';
import 'package:hr_career_platform/features/job/presentation/widgets/strepper_page_body_widget.dart';
import 'package:hr_career_platform/core/widgets/map_icon_button.dart';
import 'package:map_location_picker/map_location_picker.dart';

import '../../../payment/presentation/ui/pkg_Page.dart';

class AddJobBodyPage extends StatelessWidget {
  AddJobBodyPage({super.key, this.generals});

  final General? generals;

  final addJobFormKey = GlobalKey<FormState>();
  List<DynamicModel> addJobForm(context) {
    return [
      DynamicModel('Job Title', FormType.text,
          validators: [
            DynamicFormValidator(
                ValidatorType.notEmpty, 'isRequired')
          ],
          value: '',
          isRequired: true,
          disabled: false),
      DynamicModel('Deadline', FormType.datePicker,
          value: '',
          isRequired: true,
          validators: [
            DynamicFormValidator(
                ValidatorType.notEmpty, 'isRequired')
          ],
          disabled: false),

      DynamicModel('Time parts', FormType.dropdown,
          validators: [
            DynamicFormValidator(
                ValidatorType.notEmpty, 'isRequired')
          ],
          value: '',
          isRequired: true,
          disabled: false),
      DynamicModel('Other apply links', FormType.text,
          validators: [
            DynamicFormValidator(
                ValidatorType.notEmpty, 'isRequired')
          ],
          value: '',
          isRequired: true,
          disabled: false),

      DynamicModel('Job Description', FormType.multiline,
          validators: [
            DynamicFormValidator(
                ValidatorType.notEmpty, 'isRequired')
          ],
          value: '',
          isRequired: true,
          disabled: false),
      DynamicModel('Job requirement', FormType.multiline,
          validators: [
            DynamicFormValidator(
                ValidatorType.notEmpty, 'isRequired')
          ],
          value: '',
          isRequired: true,
          disabled: false),
    ];
  }
/*  Widget addJobDynamicForm(BuildContext context) {
    return BlocProvider(

      child: DynamicFormWidget(
        key: const Key('minInfForm'),
        dynamicFormsList: addJobForm(addJobFormKey),
        formKey: addJobFormKey,
        useResponsiveUi: true,
      ),
    );
  }*/
    @override
    Widget build(BuildContext context) {
      return BlocProvider(
        create: (_) => DynamicFormCubit()..addAllFields(addJobForm(context)),
  child: ListView(
        shrinkWrap: true,
        children: [
          BlocBuilder<GeneralCubit, GeneralState>(

            builder: (context, state) {
              if (state is GeneralLoading) {
                return Center(
                  child: LoadingWidget(),
                );
              } else if (state is GeneralFetchedState) {

                List<DynamicModel> externalModel = [
                  DynamicModel(
                    'Address',
                    FormType.text,
                    controller: TextEditingController(),
                    validators: [
                      DynamicFormValidator(
                          ValidatorType.notEmpty, 'isRequired')
                    ],
                    value:  context.read<DynamicFormCubit>().getCurrentValue()['Address'],
                    isRequired: true,
                    disabled: false,
                    action: IconButton(
                      onPressed: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LocationWidget(),)).then((value) {
                          context.read<DynamicFormCubit>().updateValueOnly(
                              'Address', value[0].toString());
                          print(value[0]);
                          print(value[1]);
                        },);
                      },
                      icon: const Icon(
                        Icons.location_on,
                        color: primaryColor,
                      ),

                    ),
                  ),
                  DynamicModel('Office Type', FormType.dropdown,
                      validators: [
                        DynamicFormValidator(
                            ValidatorType.notEmpty, 'isRequired')
                      ],
                      value: '',
                      items: state.generals.officeType
                          .map(
                            (e) => ItemModel(key: e, value: e),
                      )
                          .toList(),
                      isRequired: true,
                      disabled: false),
                  DynamicModel('Qualifications', FormType.dropdown,
                      validators: [
                        DynamicFormValidator(
                            ValidatorType.notEmpty, 'isRequired')
                      ],
                      value: '',
                      items: state.generals.qualifications
                          .map(
                            (e) => ItemModel(key: e, value: e),
                      )
                          .toList(),
                      isRequired: true,
                      disabled: false),
                  DynamicModel('Nationality', FormType.dropdown,
                      validators: [
                        DynamicFormValidator(
                            ValidatorType.notEmpty, 'isRequired')
                      ],
                      value: '',
                      items: state.generals.nationality
                          .map(
                            (e) => ItemModel(key: e, value: e),
                      )
                          .toList(),
                      isRequired: true,
                      disabled: false),
                  DynamicModel('Gender', FormType.dropdown,
                      validators: [
                        DynamicFormValidator(
                            ValidatorType.notEmpty, 'isRequired')
                      ],
                      value: '',
                      items: state.generals.gender
                          .map(
                            (e) => ItemModel(key: e, value: e),
                      )
                          .toList(),
                      isRequired: true,
                      disabled: false),
                ];
                for (var element in externalModel) {
                  context.read<DynamicFormCubit>().addField(element);
                }


                return Column(
                  children: [
                    DynamicFormWidget(
                      dynamicFormsList: [...addJobForm(addJobFormKey),...externalModel],
                      formKey: addJobFormKey,
                      useResponsiveUi: true,
                    ),
                    FloatingActionButton(
                        child: const Icon(
                          Icons.navigate_next,
                          color: Colors.white,
                        ),
                        onPressed: () {
                         context.read<StepperCubit>().changeStep(1);
                        }),
                  ],
                );
              } else if (state is GeneralErrorState) {
                print('GeneralErrorState');
                return Text(
                  state.msg,
                  style: TextStyle(color: Colors.red),
                );
              }
              return SizedBox();
            },
          ),
        ],
      ),
);
    }

}
