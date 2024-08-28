import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/features/auth/presentation/bloc/register_cubit.dart';
import 'package:hr_career_platform/features/auth/presentation/bloc/register_cubit.dart';
import 'package:hr_career_platform/features/auth/presentation/widget/text_field_widget.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/model/dynamic_model.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/widgets/dyn_form_widget.dart';

class SegmentedControlRegisterWidget extends StatefulWidget {


  const SegmentedControlRegisterWidget({super.key});

  @override
  _SegmentedControlRegisterWidgetState createState() =>
      _SegmentedControlRegisterWidgetState();
}

class _SegmentedControlRegisterWidgetState
    extends State<SegmentedControlRegisterWidget> {

  _submitClicked(BuildContext context) {
    context.read<RegisterCubit>().insertRegisterCompany();
  }
  int _selectedIndex = 0;
  final List<String> _options = ['User', 'Company'];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Padding(
          padding: const EdgeInsets.all(12.0),
          child: _selectedIndex == 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocBuilder<RegisterCubit, RegisterState>(
                      builder: (context, state) {
                        return DynamicFormWidget(dynamicFormsList: [
                          DynamicModel('Full Name', FormType.text,
                              controller: context.read<RegisterCubit>().userNameController,
                              value: '', isRequired: true, disabled: false),
                          DynamicModel('Email', FormType.text,
                              controller: context.read<RegisterCubit>().userEmailController,
                              value: '', isRequired: true, disabled: false),
                          DynamicModel('phone Number', FormType.text,
                              controller: context.read<RegisterCubit>().userPhoneController,
                              value: '', isRequired: true, disabled: false),
                          DynamicModel('Password', FormType.text,
                              controller: context.read<RegisterCubit>().userPasswordController,
                              value: '', isRequired: true, disabled: false),
                          DynamicModel('Confirm Password', FormType.text,
                              controller: context.read<RegisterCubit>().userConfirmPasswordController,
                              value: '', isRequired: true, disabled: false),
                        ], submitBtnLabel: 'login');
                      },
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DynamicFormWidget(dynamicFormsList: [
                      DynamicModel('Company Name', FormType.text,
                          controller: context.read<RegisterCubit>().companyNameController,
                          value: '', isRequired: true, disabled: false),
                      DynamicModel('Email', FormType.text,
                          controller: context.read<RegisterCubit>().companyEmailController,
                          value: '', isRequired: true, disabled: false),
                      DynamicModel('Address', FormType.text,
                          controller: context.read<RegisterCubit>().companyAddressController,
                          value: '', isRequired: true, disabled: false),
                      DynamicModel('Phone Number', FormType.text,
                          controller: context.read<RegisterCubit>().companyPhoneController,
                          value: '', isRequired: true, disabled: false),
                      DynamicModel('Password', FormType.text,
                          controller: context.read<RegisterCubit>().companyPasswordController,
                          value: '', isRequired: true, disabled: false),
                      DynamicModel('Confirm Password', FormType.text,
                          controller: context.read<RegisterCubit>().companyPasswordController,
                          value: '', isRequired: true, disabled: false),
                    ], submitBtnLabel: 'login'),
                  ],
                ),
        ),
      ],
    );
  }
}
