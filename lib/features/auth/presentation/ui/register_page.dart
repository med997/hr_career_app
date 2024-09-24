import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/core/cubit/toggle_btn_cubit.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
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
        disabled: false, key: 'fullName'),
    DynamicModel('email', FormType.email,
        value: '',
        isRequired: true,
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        disabled: false, key: 'email'),
    DynamicModel('phone', FormType.phone,
        value: '',
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        isRequired: true,
        disabled: false, key: 'phone'),
    DynamicModel('password', FormType.password,
        value: '',
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        isRequired: true,
        disabled: false, key: 'password'),
    DynamicModel('confirmPassword', FormType.password,
        value: '',
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired'),
          DynamicFormValidator(ValidatorType.equalTo, 'PasswordNotMatch'),
        ],
        isRequired: true,
        disabled: false, key: 'confirmPassword'),
  ];
  List<DynamicModel> regFormCompany = [
    DynamicModel('companyName', FormType.text,
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        isRequired: true,
        disabled: false, key: 'companyName'),
    DynamicModel('email', FormType.email,
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        isRequired: true,
        disabled: false, key: 'email'),
    DynamicModel('address', FormType.text,
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        isRequired: true,
        disabled: false, key: 'address'),
    DynamicModel('phone', FormType.phone,
        isRequired: true,
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        disabled: false, key: 'phone'),
    DynamicModel('password', FormType.password,
        isRequired: true,
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        disabled: false, key: 'password'),
    DynamicModel('confirmPassword', FormType.password,
        isRequired: true,
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired'),
          DynamicFormValidator(ValidatorType.equalTo, 'PasswordNotMatch'),
        ],
        disabled: false, key: 'confirmPassword'),
  ];
  final regFormKey = GlobalKey<FormState>();

  _cardRegister(BuildContext _) {
    return Container(
width: 400,
      padding: const EdgeInsets.symmetric(horizontal:  24,vertical: 10),
      margin:  EdgeInsets.only(left: 28,right: 28, top: MediaQuery.of(_).size.height*0.2),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(18)
      ),
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 12 ,vertical: 12),

        children: [
          Center(child: ToggleBtnWidget()),
         SizedBox(height: 8,),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              Center(
                child: BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
                  builder: (context, state) {
                    if (state.selectedTab == 0) {
                      context.read<DynamicFormCubit>().replaceAll(regFormUsers);
                      return DynamicFormWidget(
                          key: Key('regFormUsers'),
                          formKey: regFormKey,
                          dynamicFormsList: regFormUsers,
                          submitBtnLabel: 'login',
                          useResponsiveUi: false);
                    } else {
                      context.read<DynamicFormCubit>().replaceAll(regFormCompany);
                      return DynamicFormWidget(
                        key: Key('regFormCompany'),
                        formKey: regFormKey,
                        dynamicFormsList: regFormCompany,
                        submitBtnLabel: 'login',
                        useResponsiveUi: false,
                      );
                    }
                  },
                ),
              ),

            ],
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
                      _,
                      MaterialPageRoute(builder: (context) => LoginPage()),
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
  Widget _buildMobileRegPage(BuildContext _) {
    return SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.3),
                image: const DecorationImage(
                  image: AssetImage('assets/imgs/image10.png'),
                  fit: BoxFit.fitWidth, // Adjust fit as needed
                ),
                /*color: primaryColor,
              border: Border.all(
                color: primaryColor,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(12)*/
              ),

            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: loginAndRegisterAppBar(bgColor: Colors.transparent),
            ),
            _cardRegister(_),
          ],
        ),
    );
  }


  Widget _desktopAndTabletRegPage(BuildContext context) {
    return Container(

            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/imgs/bglarg.png'),
                fit: BoxFit.fitWidth, // Adjust fit as needed
              ),
              /*color: primaryColor,
          border: Border.all(
            color: primaryColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(12)*/
            ),
            child: Flex(
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        loginAndRegisterAppBar(bgColor: Colors.transparent),
                        const SizedBox(
                          height: 60,
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Text(
                              'If you don’t have an account register You can',
                              style:
                              TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: const Text('Register here !')),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: _cardRegister(context)),
                ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocProvider(
        create: (context) => DynamicFormCubit()..addAllFields(regFormUsers),
        child: Responsive(
          mobile: _buildMobileRegPage(context),
          tablet: _desktopAndTabletRegPage(context),
          desktop: _desktopAndTabletRegPage(context),

        ),
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
                final value =
                    context.read<DynamicFormCubit>().getCurrentValue();
                print(value);
                if (regFormKey.currentState!.validate()) {
                  context.read<RegisterCubit>().registerUser(
                      context.read<ToggleBtnCubit>().state.selectedTab, value);
                }
              },
              enableFeedback: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  if (state is RegisterLoading)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
