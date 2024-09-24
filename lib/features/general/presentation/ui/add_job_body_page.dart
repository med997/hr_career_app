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
import 'package:hr_career_platform/features/job/domain/entities/job.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/curd_job_cubit.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/stepper_cubit.dart';

class AddJobBodyPage extends StatelessWidget {
  AddJobBodyPage({super.key, this.generals});

  final General? generals;

  final addJobFormKey = GlobalKey<FormState>();

  TextEditingController address = TextEditingController();

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
  List<DynamicModel> addJobForm = [
    DynamicModel('jobTitle', FormType.text,
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        value: '',
        isRequired: true,
        disabled: false),
    DynamicModel('deadlineDate', FormType.date,
        value: '',
        isRequired: true,
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        disabled: false),

    DynamicModel('otherApplyLinks', FormType.text,
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        value: '',
        isRequired: true,
        disabled: false),
    DynamicModel('jobDesc', FormType.multiline,
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        value: '',
        isRequired: true,
        disabled: false),
    DynamicModel('jobRequirements', FormType.multiline,
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        value: '',
        isRequired: true,
        disabled: false),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DynamicFormCubit(),
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
                addJobForm.addAll([
                  DynamicModel(
                    'address',
                    FormType.text,
                    controller: TextEditingController(),
                    validators: [
                      DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                    ],
                    disabled: false,
                    action: ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                            builder: (context2) => LocationWidget(),
                          ))
                              .then(
                                (value) {
                              context.read<DynamicFormCubit>().updateValueOnly(
                                  'address', value[0].toString());
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
                  DynamicModel('office', FormType.dropdown,
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
                  DynamicModel('city', FormType.dropdown,
                      validators: [
                        DynamicFormValidator(
                            ValidatorType.notEmpty, 'isRequired')
                      ],
                      value: '',
                      items: state.generals.cities
                          .map(
                            (e) => ItemModel(key: e, value: e),
                      )
                          .toList(),
                      isRequired: true,
                      disabled: false),
                  DynamicModel('qualifications', FormType.dropdown,
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
                  DynamicModel('nationalities', FormType.dropdown,
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
                  DynamicModel('gender', FormType.dropdown,
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
                  DynamicModel('category', FormType.dropdown,
                      validators: [
                        DynamicFormValidator(
                            ValidatorType.notEmpty, 'isRequired')
                      ],
                      value: '',
                      items: state.generals.jobCategory
                          .map(
                            (e) => ItemModel(key: e, value: e),
                      )
                          .toList(),
                      isRequired: true,
                      disabled: false),
                  DynamicModel('timeParts', FormType.dropdown,
                      validators: [
                        DynamicFormValidator(
                            ValidatorType.notEmpty, 'isRequired')
                      ],
                      value: '',
                      items: state.generals.timeParts
                          .map(
                            (e) => ItemModel(key: e, value: e),
                      )
                          .toList(),
                      isRequired: true,
                      disabled: false),
                ]);
                context.read<DynamicFormCubit>().replaceAll(addJobForm);

                return Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DynamicFormWidget(
                      dynamicFormsList: [],
                      formKey: addJobFormKey,
                      useResponsiveUi: true,
                    ),
                    FloatingActionButton(
                        child: const Icon(
                          Icons.navigate_next,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          var value = context
                              .read<DynamicFormCubit>()
                              .getCurrentValue();
                          print(value.toString());
                          context.read<CurdJobCubit>().insertJob(value);

                          // context.read<StepperCubit>().changeStep(1);
                        })
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

          // BlocListener(listener: (context, state) => ),
          BlocConsumer<CurdJobCubit, CurdJobState>(
            listener: (context, state) =>state is MessageCurdJobState? context.read<StepperCubit>().changeStep(1):null,
            builder: (context, state) {

                  if (state is LoadingCurdJobState) {
                    return LoadingWidget();
                  }
                  return SizedBox();
                },

          )
        ],
      ),
    );
  }
}
