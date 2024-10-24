import 'dart:convert';

import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/core/util/validator.dart';
import 'package:hr_career_platform/core/widgets/dyn_form_widget.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/core/widgets/map_icon_button.dart';
import 'package:hr_career_platform/features/general/domain/entities/general.dart';
import 'package:hr_career_platform/features/general/presentation/bloc/general_cubit.dart';
import 'package:hr_career_platform/features/job/domain/entities/job.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/curd_job_cubit.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/stepper_cubit.dart';
import 'package:hr_career_platform/features/profile/presentation/bloc/profile_cubit.dart';

import '../../../auth/presentation/bloc/login_cubit.dart';
import '../../../company/presentation/bloc/curd_company_cubit.dart';

class AddJobBodyPage extends StatefulWidget {
  const AddJobBodyPage({super.key, this.generals, this.job});

  final General? generals;
  final Job? job;

  @override
  State<AddJobBodyPage> createState() => _AddJobBodyPageState();
}

class _AddJobBodyPageState extends State<AddJobBodyPage> {
  final addJobFormKey = GlobalKey<FormState>();
  List<String> latLong = [];

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    double width =
        Responsive.isMobile(context) ? MediaQuery.of(context).size.width : 300;
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      children: [
        _getMainInfAddJobForm(width, context),
        BlocConsumer<CurdJobCubit, CurdJobState>(
          listener: (context, state) => state is MessageCurdJobState
              ? context.read<StepperCubit>().addJobChangeStep(1, addedJob: state.job)
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

  Widget _getMainInfAddJobForm(double width, BuildContext context) {
    General? generals = context.read<GeneralCubit>().general;
    List<ItemModel> nationalityItems = [];
    List<ItemModel> qualificationsItems = [];
    List<ItemModel> genderItems = [];
    List<ItemModel> officeItems = [];
    List<ItemModel> timePartsItems = [];
    List<ItemModel> categoryItems = [];
    List<ItemModel> cityItems = [];
    if (generals != null) {
      nationalityItems =
          generals.nationality.map((e) => ItemModel(key: e, value: e)).toList();
      qualificationsItems = generals.qualifications
          .map((e) => ItemModel(key: e, value: e))
          .toList();
      genderItems =
          generals.gender.map((e) => ItemModel(key: e, value: e)).toList();
      officeItems =
          generals.officeType.map((e) => ItemModel(key: e, value: e)).toList();
      cityItems =
          generals.cities.map((e) => ItemModel(key: e, value: e)).toList();
      categoryItems =
          generals.jobCategory.map((e) => ItemModel(key: e, value: e)).toList();
      timePartsItems =
          generals.timeParts.map((e) => ItemModel(key: e, value: e)).toList();
    }
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
      DynamicModel(
        'otherApplyLinks',
        FormType.text,
        key: 'otherApplyLinks',
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        controller: TextEditingController(text: widget.job?.otherApplyLinks),
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
        controller: TextEditingController(),
        controllerFlt: FleatherController(),
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
        controllerFlt: FleatherController(),
        controller: TextEditingController(),
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
          action: _addressActionBtn(context)),
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
          key: const Key('addJobDynForm'),
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
              var value = context.read<DynamicFormCubit>().getCurrentValue();
              final companyId =
                  context.read<LoginCubit>().authenticatedUser!.userAuth!.id;

              print('company_id: $companyId ===> $value');
              context.read<CurdJobCubit>().insertJob(value, companyId);

              // context.read<StepperCubit>().changeStep(1);
            })
      ],
    );
  }

  _addressActionBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: MaterialButton(
          disabledColor: Colors.grey.shade600,
          padding: const EdgeInsets.all(4),
          onPressed: () async {
            Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (context) => LocationWidget(),
            ))
                .then((value) {
              context
                  .read<DynamicFormCubit>()
                  .updateValueOnly('address', value[0].toString());
              // print(value[0]);
              // print(value[1]);
              latLong = value[1].split(",");
              // print(latLong);
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
}
