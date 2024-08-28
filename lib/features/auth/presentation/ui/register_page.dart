import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/toggle_btn_cubit.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/widgets/dyn_form_widget.dart';
import 'package:hr_career_platform/core/widgets/jobCard_widget.dart';
import 'package:hr_career_platform/core/widgets/toggle_btn_widget.dart';
import 'package:hr_career_platform/features/auth/presentation/bloc/register_cubit.dart';
import 'package:hr_career_platform/features/auth/presentation/ui/login_page.dart';

import '../widget/login_ana_register_appbar_functhion.dart';


class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: loginAndRegisterAppBar(),
      body: ListView(
        children: [
          ToggleBtnWidget(),
          BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
            builder: (context, state) {
              if (state.selectedTab == 0 ) {
                return DynamicFormWidget(dynamicFormsList: [
                  DynamicModel('Full Name', FormType.text,
                      controller: context
                          .read<RegisterCubit>()
                          .userNameController,
                      value: '', isRequired: true, disabled: false),
                  DynamicModel('Email', FormType.text,
                      controller: context
                          .read<RegisterCubit>()
                          .userEmailController,
                      value: '', isRequired: true, disabled: false),
                  DynamicModel('phone Number', FormType.phone,
                      controller: context
                          .read<RegisterCubit>()
                          .userPhoneController,
                      value: '', isRequired: true, disabled: false),
                  DynamicModel('Password', FormType.password,
                      controller: context
                          .read<RegisterCubit>()
                          .userPasswordController,
                      value: '', isRequired: true, disabled: false),
                  DynamicModel('Confirm Password', FormType.password,
                      controller: context
                          .read<RegisterCubit>()
                          .userConfirmPasswordController,
                      value: '', isRequired: true, disabled: false),
                ], submitBtnLabel: 'login', useResponsiveUi: false,);
              } else {
                return DynamicFormWidget(dynamicFormsList: [
                  DynamicModel('Company Name', FormType.text,
                      controller: context.read<RegisterCubit>().companyNameController,
                      value: '', isRequired: true, disabled: false),
                  DynamicModel('Email', FormType.text,
                      controller: context.read<RegisterCubit>().companyEmailController,
                      value: '', isRequired: true, disabled: false),
                  DynamicModel('Address', FormType.text,
                      controller: context.read<RegisterCubit>().companyAddressController,
                      value: '', isRequired: true, disabled: false),
                  DynamicModel('Phone Number', FormType.phone,
                      controller: context.read<RegisterCubit>().companyPhoneController,
                      value: '', isRequired: true, disabled: false),
                  DynamicModel('Password', FormType.text,
                      controller: context.read<RegisterCubit>().companyPasswordController,
                      value: '', isRequired: true, disabled: false),
                  DynamicModel('Confirm Password', FormType.text,
                      controller: context.read<RegisterCubit>().companyConfirmPasswordController,
                      value: '', isRequired: true, disabled: false),
                ], submitBtnLabel: 'login', useResponsiveUi: false,);
              }

            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {

                context.read<RegisterCubit>().registerUser(0);
              },
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(primaryColor),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  )),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 14.0,
                width: 150,
                child: Divider(
                  endIndent: 20,
                  color: Colors.grey,
                ),
              ),
              Text(
                'or with',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              SizedBox(
                height: 14.0,
                width: 150,
                child: Divider(
                  indent: 20,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: CircleAvatar(),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: CircleAvatar(),
              ),
            ],
          ),
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
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: primaryColor),
                  )),
            ],
          ),
        ]
        ,
      )
      ,
    );
  }
}
