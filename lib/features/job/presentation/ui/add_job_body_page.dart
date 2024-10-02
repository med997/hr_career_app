import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
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

import '../../../auth/presentation/bloc/login_cubit.dart';

class AddJobBodyPage extends StatefulWidget {
  AddJobBodyPage({super.key, this.generals, this.job});

  final General? generals;
  final Job? job;

  @override
  State<AddJobBodyPage> createState() => _AddJobBodyPageState();
}

class _AddJobBodyPageState extends State<AddJobBodyPage> {
  final addJobFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<GeneralCubit>().getGeneral();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      children: [
        BlocConsumer<GeneralCubit, GeneralState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GeneralLoading) {
              return LoadingWidget();
            } else if (state is GeneralFetchedState) {
              List<ItemModel> nationalityItems = state.generals.nationality
                  .map((e) => ItemModel(key: e, value: e))
                  .toList();
              List<ItemModel> qualificationsItems = state
                  .generals.qualifications
                  .map((e) => ItemModel(key: e, value: e))
                  .toList();
              List<ItemModel> genderItems = state.generals.gender
                  .map((e) => ItemModel(key: e, value: e))
                  .toList();
              List<ItemModel> officeItems = state.generals.officeType
                  .map((e) => ItemModel(key: e, value: e))
                  .toList();
              List<ItemModel> cityItems = state.generals.cities
                  .map((e) => ItemModel(key: e, value: e))
                  .toList();
              List<ItemModel> categoryItems = state.generals.jobCategory
                  .map((e) => ItemModel(key: e, value: e))
                  .toList();
              List<ItemModel> timePartsItems = state.generals.timeParts
                  .map((e) => ItemModel(key: e, value: e))
                  .toList();
              List<DynamicModel> addJobForm = [
                DynamicModel(
                  'jobTitle',
                  FormType.text,
                  key: 'jobTitle',
                  validators: [
                    DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                  ],
                  width: width,
                  controller: TextEditingController(text: widget.job?.jobTitle),
                  isRequired: true,
                ),
                // DynamicModel(
                //   'deadlineDate',
                //   FormType.date,
                //   key: 'deadlineDate',
                //   controller: TextEditingController(
                //       text: widget.job?.deadlineDate.toString()),
                //   width: width,
                //   isRequired: true,
                //   validators: [
                //     DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                //   ],
                // ),
                DynamicModel(
                  'otherApplyLinks',
                  FormType.text,
                  key: 'otherApplyLinks',
                  validators: [
                    DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                  ],
                  controller:
                      TextEditingController(text: widget.job?.otherApplyLinks),
                  width: width,
                  isRequired: true,
                ),
                DynamicModel(
                  'jobDesc',
                  FormType.multiline,
                  key: 'jobDesc',
                  validators: [
                    DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                  ],
                  controller: TextEditingController(text: widget.job?.jobDesc),
                  width: width,
                  isRequired: true,
                ),
                DynamicModel(
                  'jobRequirements',
                  FormType.multiline,
                  key: 'jobRequirements',
                  validators: [
                    DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                  ],
                  controller:
                      TextEditingController(text: widget.job?.jobRequirements),
                  width: width,
                  isRequired: true,
                ),
                DynamicModel(
                  'address',
                  width: width,
                  key: 'address',
                  FormType.text,
                  controller: TextEditingController(),
                  validators: [
                    DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                  ],
                  isRequired: true,
                  action: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: MaterialButton(
                        disabledColor: Colors.grey.shade600,
                        padding: EdgeInsets.all(4),
                        onPressed: () async {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                            builder: (context) => LocationWidget(),
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
                        shape: const CircleBorder(),
                        color: primaryColor,

                        child: const Icon(Icons.location_on_outlined,
                          color: Colors.white,size: 18,)),
                  ),
                ),
                DynamicModel(
                  'office',
                  FormType.dropdown,
                  key: 'office',
                  validators: [
                    DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                  ],
                  controller: TextEditingController(),
                  width: width,
                  items: officeItems,
                  isRequired: true,
                ),
                DynamicModel(
                  'city',
                  FormType.dropdown,
                  key: 'city',
                  validators: [
                    DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                  ],
                  controller: TextEditingController(),
                  width: width,
                  items: cityItems,
                  isRequired: true,
                ),
                DynamicModel(
                  'qualifications',
                  FormType.dropdown,
                  key: 'qualifications',
                  validators: [
                    DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                  ],
                  controller: TextEditingController(),
                  width: width,
                  items: qualificationsItems,
                  isRequired: true,
                ),
                DynamicModel(
                  'nationalities',
                  FormType.dropdown,
                  key: 'nationalities',
                  validators: [
                    DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                  ],
                  controller: TextEditingController(),
                  width: width,
                  items: nationalityItems,
                  isRequired: true,
                ),
                DynamicModel(
                  'gender',
                  FormType.dropdown,
                  key: 'gender',
                  validators: [
                    DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                  ],
                  controller: TextEditingController(),
                  width: width,
                  items: genderItems,
                  isRequired: true,
                ),
                DynamicModel(
                  'category',
                  FormType.dropdown,
                  key: 'category',
                  validators: [
                    DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                  ],
                  controller: TextEditingController(),
                  width: width,
                  items: categoryItems,
                ),
                DynamicModel(
                  'timeParts',
                  FormType.dropdown,
                  key: 'timeParts',
                  validators: [
                    DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                  ],
                  width: width,
                  items: timePartsItems,
                  controller: TextEditingController(),
                  isRequired: true,
                ),
              ];

              return Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DynamicFormWidget(
                    key: const Key('profileInf'),
                    dynamicFormsList: addJobForm,
                    formKey: addJobFormKey,
                    useResponsiveUi: true,
                  ),
                  FloatingActionButton(
                      child: const Icon(
                        Icons.navigate_next,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        var value =
                            context.read<DynamicFormCubit>().getCurrentValue();
                        final companyId = context.read<LoginCubit>().authenticatedUser!.userAuth!.id;

                        print('company_id: $companyId ===> $value');
                        context.read<CurdJobCubit>().insertJob(value,companyId);

                        // context.read<StepperCubit>().changeStep(1);
                      })
                ],
              );
            }
              return const SizedBox();
          },
        ),
        // BlocListener(listener: (context, state) => ),
        BlocConsumer<CurdJobCubit, CurdJobState>(
          listener: (context, state) => state is MessageCurdJobState
              ? context.read<StepperCubit>().changeStep(1,addedJob: state.job)
              : null,
          builder: (context, state) {
            if (state is LoadingCurdJobState) {
              return LoadingWidget();
            }
            return const SizedBox();
          },
        )
      ],
    );
  }
}
