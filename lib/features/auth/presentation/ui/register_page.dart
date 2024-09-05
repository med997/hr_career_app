import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/core/cubit/toggle_btn_cubit.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/util/validator.dart';
import 'package:hr_career_platform/core/widgets/dyn_form_widget.dart';
import 'package:hr_career_platform/core/widgets/jobCard_widget.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/core/widgets/toggle_btn_widget.dart';
import 'package:hr_career_platform/features/auth/presentation/bloc/register_cubit.dart';
import 'package:hr_career_platform/features/auth/presentation/ui/login_page.dart';

import '../widget/login_ana_register_appbar_functhion.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  List<DynamicModel> regFormUsers = [
    DynamicModel('fullName', FormType.text,
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        value: '',
        isRequired: true,
        disabled: false),
    DynamicModel('email', FormType.email,
        value: '',
        isRequired: true,
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        disabled: false),
    DynamicModel('phone', FormType.phone,
        value: '',
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        isRequired: true,
        disabled: false),
    DynamicModel('password', FormType.password,
        value: '',
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        isRequired: true,
        disabled: false),
    DynamicModel('confirmPassword', FormType.password,
        value: '',
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired'),
          DynamicFormValidator(ValidatorType.equalTo, 'PasswordNotMatch'),
        ],
        isRequired: true,
        disabled: false),
  ];
  List<DynamicModel> regFormCompany = [
    DynamicModel('companyName', FormType.text,
        value: 'ahmedBro',
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        isRequired: true,
        disabled: false),
    DynamicModel('email', FormType.email,
        value: 'ahmedafeef1999@gmail.com',
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        isRequired: true,
        disabled: false),
    DynamicModel('address', FormType.text,
        value: 'yemen',
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        isRequired: true,
        disabled: false),
    DynamicModel('phone', FormType.phone ,
        value: '779377119',
        isRequired: true,
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        disabled: false),
    DynamicModel('password', FormType.password,
        value: '123456',
        isRequired: true,
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        disabled: false),
    DynamicModel('confirmPassword', FormType.password,
        value: '123456',
        isRequired: true,
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired'),
          DynamicFormValidator(ValidatorType.equalTo, 'PasswordNotMatch'),
        ],
        disabled: false),
  ];
final regFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: loginAndRegisterAppBar(),
      body: ListView(
          shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(child: ToggleBtnWidget()),
          ),
          BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
            builder: (context, state) {
              if (state.selectedTab == 0) {

                return DynamicFormWidget(
                  formKey:regFormKey ,
                  dynamicFormsList: regFormUsers,
                    submitBtnLabel: 'login', useResponsiveUi: false);
              } else {
                return DynamicFormWidget(
                  formKey:regFormKey ,
                  dynamicFormsList: regFormCompany,
                  submitBtnLabel: 'login',
                  useResponsiveUi: false,
                );
              }
            },
          ),
          _registerBtn(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Have an account?',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  LoginPage()),
                    );
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: primaryColor),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  _registerBtn() {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Center(
          child: SizedBox(
            width: 350,
            height: 35,
            child: MaterialButton(
              color: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onPressed: () {
                final value = context.read<DynamicFormCubit>().getCurrentValue();
                print(value);
                if (regFormKey.currentState!.validate()) {
                  context.read<RegisterCubit>().registerUser(
                      context.read<ToggleBtnCubit>().state.selectedTab,
                      value);
                }
              },
              enableFeedback: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  if (state is RegisterLoading)
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 12.0),
                      child: FittedBox(
                          child: LoadingWidget(
                            progressColor: Colors.white,
                          )),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
