import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/core/cubit/toggle_btn_cubit.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/core/util/validator.dart';
import 'package:hr_career_platform/core/widgets/dyn_form_widget.dart';
import 'package:hr_career_platform/core/widgets/loading_widget.dart';
import 'package:hr_career_platform/core/widgets/toggle_btn_widget.dart';
import 'package:hr_career_platform/features/auth/presentation/bloc/login_cubit.dart';
import 'package:hr_career_platform/features/auth/presentation/bloc/register_cubit.dart';
import 'package:hr_career_platform/features/auth/presentation/ui/register_page.dart';
import 'package:hr_career_platform/features/auth/presentation/widget/login_ana_register_appbar_functhion.dart';

import '../../../../core/app_theme.dart';
import '../../../home/presentation/ui/company_home_page.dart';
import '../../../home/presentation/ui/home_page.dart';

class LoginPage extends StatelessWidget {
  final loginFormKey = GlobalKey<FormState>();

  List<DynamicModel> loginDynForm = [
    DynamicModel('email', FormType.text,
        value: '',
        isRequired: true,
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        disabled: false),
    DynamicModel('password', FormType.password,
        value: '',
        isRequired: true,
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        disabled: false),
  ];

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: _buildMobileLoginPage(context),
        tablet: _desktopAndTabletLoginPage(context),
        desktop: _desktopAndTabletLoginPage(context));
  }


  Widget _desktopAndTabletLoginPage(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(120.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/imgs/project_logo.png',
                ),
                const Text(
                  'Sign in to',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Lorem Ipsum is simply ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 60,
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text(
                      'If you don’t have an account register You can',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    TextButton(
                        onPressed: () {}, child: const Text('Register here !')),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                image: const DecorationImage(
                  opacity: 0.2,
                  image: AssetImage('imgs/image10.png'),
                  fit: BoxFit.fitWidth, // Adjust fit as needed
                ),
                border: Border.all(
                  color: Colors.transparent,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ToggleBtnWidget(options: [],),
                ),
                BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
                  builder: (context, state) {
                    if (state.selectedTab == 0) {
                      return DynamicFormWidget(
                        formKey: loginFormKey,
                        dynamicFormsList: loginDynForm,
                        submitBtnLabel: 'login', useResponsiveUi: false,);
                    } else {
                      return DynamicFormWidget(
                        formKey: loginFormKey,
                        dynamicFormsList: loginDynForm,
                        submitBtnLabel: 'login', useResponsiveUi: false,);
                    }
                  },
                ),
                _loginBtn(),
                TextButton(
                    onPressed: () {},
                    child: const Text('Forget Password?',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 14))),
              ],
            ),
          )
        ]),
      ),
    );
  }

  Widget _buildMobileLoginPage(BuildContext context) {
    return Scaffold(
      appBar: loginAndRegisterAppBar(),
      body: ListView(
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: ToggleBtnWidget(options: [],),
              ),
              BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
                builder: (context, state) {
                  if (state.selectedTab == 0) {
                    return DynamicFormWidget(
                      formKey: loginFormKey,
                      dynamicFormsList: loginDynForm,
                      submitBtnLabel: 'login', useResponsiveUi: false,);
                  } else {
                    return DynamicFormWidget(
                      formKey: loginFormKey,
                      dynamicFormsList: loginDynForm,
                      submitBtnLabel: 'login',
                      useResponsiveUi: false,
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forget Password?',
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    )),
              ),
              _loginBtn(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: SizedBox(
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.yellow.shade700),
                    ),
                    child: const Text(
                      'Continue as Gust',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Haven't an account?",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()),
                        );
                      },
                      child: const Text('Register')),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }


  _loginBtn() {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is SuccessLoginUser) {
          if (state.auth.userType == UsrType.user) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
                    (route) => false);
          }else{
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) =>  HomeCompanyPage(),
                ),
                    (route) => false);
          }
        }
      },
      builder: (context, state) {
        return BlocBuilder<LoginCubit, LoginState>(
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
                    final value = context.read<DynamicFormCubit>()
                        .getCurrentValue();
                    print(value);
                    if (loginFormKey.currentState!.validate()) {
                      context.read<LoginCubit>().loginUser(
                          context
                              .read<ToggleBtnCubit>()
                              .state
                              .selectedTab,
                          value);
                    }
                  },
                  enableFeedback: false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      if (state is LoginLoading)
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
      },
    );
  }
}
