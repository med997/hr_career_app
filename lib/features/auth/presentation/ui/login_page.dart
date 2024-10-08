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
import 'package:hr_career_platform/features/auth/presentation/ui/verification_page.dart';
import 'package:hr_career_platform/features/auth/presentation/widget/login_ana_register_appbar_functhion.dart';

import '../../../../core/app_theme.dart';
import '../../../home/presentation/ui/company_home_page.dart';
import '../../../home/presentation/ui/home_page.dart';

class LoginPage extends StatelessWidget {
  final loginFormKey = GlobalKey<FormState>();

  LoginPage({super.key});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Responsive(
        mobile: _buildMobileLoginPage(context),
        tablet: _desktopAndTabletLoginPage(context),
        desktop: _desktopAndTabletLoginPage(context));
  }



  Widget _desktopAndTabletLoginPage(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(120.0),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/imgs/bglarg.png'),
                fit: BoxFit.fitWidth, // Adjust fit as needed
              ),
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
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => RegisterPage()),
                                  );
                                },
                                child: const Text('Register here !')),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: _cardLogin(context)),
                ])));
  }

  Widget _buildMobileLoginPage(BuildContext _) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: primaryTransparent.withOpacity(0.2),
                image: const DecorationImage(
                  image: AssetImage('assets/imgs/paternPrimary.png'),
                  fit: BoxFit.fitWidth, // Adjust fit as needed
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: loginAndRegisterAppBar(bgColor: Colors.transparent),
            ),
            Center(child: _cardLogin(_)),
          ],
        ),
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
                  builder: (context) => HomePage(auth: state.auth,),
                ),
                (route) => false);
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeCompanyPage(auth: state.auth,),
                ),
                (route) => false);
          }
        }
      },
      builder: (context, state) {
        return BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
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
                        if (loginFormKey.currentState!.validate()) {
                          context.read<LoginCubit>().loginUser(
                              context.read<ToggleBtnCubit>().state.selectedTab,
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
                ),
                if (state is ErrLoginUser)
                  Text(
                    state.msg,
                    style: const TextStyle(
                        color: Colors.redAccent, fontWeight: FontWeight.w500),
                  )
              ],
            );
          },
        );
      },
    );
  }

  Widget _asGustBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: SizedBox(
          width: 350,
          height: 30,
          child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            onPressed: () {},
            color: Colors.yellow.shade700,
            child: const Text(
              'Continue as Gust',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _cardLogin(BuildContext _) {
    final List<DynamicModel> loginDynForm = [
      DynamicModel('email', FormType.email,
          controller:  TextEditingController(),
          isRequired: true,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          disabled: false, key: 'email'),
      DynamicModel('password', FormType.password,
          controller:  TextEditingController(),
          isRequired: true,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          disabled: false, key: 'password'),
    ];
    return Container(
      width: 400,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      margin: const EdgeInsets.symmetric(horizontal: 28),
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(18)),
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              Center(
                child: DynamicFormWidget(
                  key: const Key('loginForm'),
                  formKey: loginFormKey,
                  dynamicFormsList: loginDynForm,
                  submitBtnLabel: 'login',
                  useResponsiveUi: false,
                ),
              ),
            ],
          ),
          _loginBtn(),
          _asGustBtn(),
           Center(
            child: TextButton(onPressed: () {
              Navigator.of(_).push(MaterialPageRoute(
                  builder: (context) => const VerificationPage()));
            },
            child: const Text(
              'Forget Password?',
              style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),)
          ),
          if(Responsive.isMobile(_))
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
                    Navigator.of(_).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => RegisterPage()),(route) => false);
                  },
                  child: const Text('Register')),
            ],
          ),
        ],
      ),
    );
  }
}
