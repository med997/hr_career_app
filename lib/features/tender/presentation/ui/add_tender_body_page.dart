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
import 'package:hr_career_platform/core/widgets/location_widget.dart';
import 'package:hr_career_platform/features/general/domain/entities/general.dart';
import 'package:hr_career_platform/features/general/presentation/bloc/general_cubit.dart';
import 'package:hr_career_platform/features/job/presentation/bloc/stepper_cubit.dart';
import 'package:hr_career_platform/features/profile/presentation/bloc/profile_cubit.dart';

import '../../../auth/presentation/bloc/login_cubit.dart';
import '../../../company/presentation/bloc/curd_company_cubit.dart';
import '../../domain/entities/tender.dart';
import '../bloc/curd_tender_cubit.dart';

class AddTenderBodyPage extends StatefulWidget {
  const AddTenderBodyPage({super.key, this.generals, this.tender});

  final General? generals;
  final Tender? tender;

  @override
  State<AddTenderBodyPage> createState() => _AddTenderBodyPageState();
}

class _AddTenderBodyPageState extends State<AddTenderBodyPage> {
  final addTenderFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<GeneralCubit>().getGeneral();

  }

  @override
  Widget build(BuildContext context) {
    double width =
    Responsive.isMobile(context) ? MediaQuery.of(context).size.width : 300;
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      children: [
        _getMainInfAddTenderForm(width, context),
        BlocConsumer<CurdTenderCubit, CurdTenderState>(
          listener: (context, state) => state is MessageCurdTenderState
              ? context.read<StepperCubit>().addTenderChangeStep(1, addedTender: state.tender)
              : null,
          builder: (context, state) {
            if (state is LoadingCurdTenderState) {
              return LoadingWidget();
            }
            return const SizedBox();
          },
        )
      ],
    );
  }

  Widget _getMainInfAddTenderForm(double width, BuildContext context) {
    General? generals = context.read<GeneralCubit>().general;
    List<ItemModel> nationalityItems = [];
    List<ItemModel> categoryItems = [];
    List<ItemModel> cityItems = [];
    if (generals != null) {
      nationalityItems =
          generals.nationality.map((e) => ItemModel(key: e, value: e)).toList();

      cityItems =
          generals.cities.map((e) => ItemModel(key: e, value: e)).toList();
      categoryItems =
          generals.jobCategory.map((e) => ItemModel(key: e, value: e)).toList();

    }
    List<DynamicModel> addTenderForm = [
      DynamicModel(
        'tenderTitle',
        FormType.text,
        key: 'tenderTitle',
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        width: width,
        controller: TextEditingController(text: widget.tender?.tenderTitle),
        isRequired: true,
      ),
      DynamicModel(
        'otherApplyLinks',
        FormType.text,
        key: 'otherApplyLinks',
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        controller: TextEditingController(text: widget.tender?.otherApplyLinks),
        width: width,
        isRequired: true,
      ),
      DynamicModel(
        'tenderDesc',
        FormType.multiline,
        key: 'tenderDesc',
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        controllerFlt: FleatherController(),
        controller: TextEditingController(),
        width: width,
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

    ];

    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DynamicFormWidget(
          key: const Key('addTenderDynForm'),
          dynamicFormsList: addTenderForm,
          formKey: addTenderFormKey,
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
              context.read<CurdTenderCubit>().insertTender(value, companyId);

              // context.read<StepperCubit>().changeStep(1);
            })
      ],
    );
  }


}
