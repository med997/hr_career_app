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
import 'package:hr_career_platform/features/job/presentation/bloc/job_cubit.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/stepper_cubit.dart';

class AddJobBodyPage extends StatelessWidget {
  AddJobBodyPage({super.key, this.generals, this.job});

  final General? generals;
  final Job? job;

  final addJobFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView(
      shrinkWrap: true,
      children: [
        BlocConsumer<JobCubit, JobState>(
          listener: (context, state) {
            if (state is JobFetchedState) {
              context.read<GeneralCubit>().getGeneral();
            }
          },
          builder: (context, state) {
            BlocListener<GeneralCubit, GeneralState>(
                listener: (context, gnState) {});
            if (state is JobLoadingState) {
              return LoadingWidget();
            } else if (state is JobFetchedState) {
              List<DynamicModel> addJobForm = [
                DynamicModel(
                  'jobTitle',
                  FormType.text,
                  key: 'jobTitle',
                  validators: [
                    DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                  ],
                  width: width,
                  controller: TextEditingController(text: job?.jobTitle),
                  isRequired: true,
                ),
                DynamicModel(
                  'deadlineDate',
                  FormType.date,
                  key: 'deadlineDate',
                  controller:
                      TextEditingController(text: job?.deadlineDate.toString()),
                  width: width,
                  isRequired: true,
                  validators: [
                    DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                  ],
                ),
                DynamicModel(
                  'otherApplyLinks',
                  FormType.text,
                  key: 'otherApplyLinks',
                  validators: [
                    DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                  ],
                  controller: TextEditingController(text: job?.otherApplyLinks),
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
                  controller: TextEditingController(text: job?.jobDesc),
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
                  controller: TextEditingController(text: job?.jobRequirements),
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
                  action: ElevatedButton(
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
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: primaryColor,
                      ),
                      child: const Icon(Icons.location_on_outlined,
                          color: Colors.white)),
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
                  items: [],
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
                  items: [],
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
                  items: [],
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
                  items: [],
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
                  items: [],
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
                  items: [],
                ),
                DynamicModel(
                  'timeParts',
                  FormType.dropdown,
                  key: 'timeParts',
                  validators: [
                    DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                  ],
                  width: width,
                  items: [],
                  controller: TextEditingController(),
                  isRequired: true,
                ),
              ];
              return Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: BlocBuilder<GeneralCubit, GeneralState>(
                      builder: (context, gnState) {
                        if (gnState is GeneralFetchedState) {
                          print('GeneralFetchedState');
                          List<ItemModel> nationalityItems = gnState
                              .generals.nationality
                              .map((e) => ItemModel(key: e, value: e))
                              .toList();
                          List<ItemModel> qualificationsItems = gnState
                              .generals.qualifications
                              .map((e) => ItemModel(key: e, value: e))
                              .toList();
                          List<ItemModel> genderItems = gnState.generals.gender
                              .map((e) => ItemModel(key: e, value: e))
                              .toList();
                          List<ItemModel> officeItems = gnState
                              .generals.officeType
                              .map((e) => ItemModel(key: e, value: e))
                              .toList();
                          List<ItemModel> cityItems = gnState.generals.cities
                              .map((e) => ItemModel(key: e, value: e))
                              .toList();
                          List<ItemModel> categoryItems = gnState
                              .generals.jobCategory
                              .map((e) => ItemModel(key: e, value: e))
                              .toList();
                          List<ItemModel> timePartsItems = gnState
                              .generals.timeParts
                              .map((e) => ItemModel(key: e, value: e))
                              .toList();
                          context.read<DynamicFormCubit>().addMenuItems(
                              addJobForm
                                  .where((element) =>
                                      element.key == 'nationalities')
                                  .first,
                              nationalityItems,
                              state.jobs[0].nationalities!);
                          context.read<DynamicFormCubit>().addMenuItems(
                              addJobForm
                                  .where((element) => element.key == 'category')
                                  .first,
                              categoryItems,
                              state.jobs[0].category);
                          context.read<DynamicFormCubit>().addMenuItems(
                              addJobForm
                                  .where((element) => element.key == 'city')
                                  .first,
                              cityItems,
                              state.jobs[0].city);
                          context.read<DynamicFormCubit>().addMenuItems(
                              addJobForm
                                  .where((element) =>
                                      element.key == 'qualifications')
                                  .first,
                              qualificationsItems,
                              state.jobs[0].qualifications!);
                          context.read<DynamicFormCubit>().addMenuItems(
                              addJobForm
                                  .where((element) => element.key == 'gender')
                                  .first,
                              genderItems,
                              state.jobs[0].gender!);
                          context.read<DynamicFormCubit>().addMenuItems(
                              addJobForm
                                  .where(
                                      (element) => element.key == 'timeParts')
                                  .first,
                              timePartsItems,
                              state.jobs[0].timeParts);
                          context.read<DynamicFormCubit>().addMenuItems(
                              addJobForm
                                  .where((element) => element.key == 'office')
                                  .first,
                              officeItems,
                              state.jobs[0].office);
                        }
                        return DynamicFormWidget(
                          key: const Key('profileInf'),
                          dynamicFormsList: addJobForm,
                          formKey: addJobFormKey,
                          useResponsiveUi: true,
                        );
                      },
                    ),
                  ),
                  FloatingActionButton(
                      child: const Icon(
                        Icons.navigate_next,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        var value =
                            context.read<DynamicFormCubit>().getCurrentValue();
                        print(value.toString());
                        context.read<CurdJobCubit>().insertJob(value);

                        // context.read<StepperCubit>().changeStep(1);
                      })
                ],
              );
            } else
              return SizedBox();
          },
        ),
        // BlocListener(listener: (context, state) => ),
        BlocConsumer<CurdJobCubit, CurdJobState>(
          listener: (context, state) => state is MessageCurdJobState
              ? context.read<StepperCubit>().changeStep(1)
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
