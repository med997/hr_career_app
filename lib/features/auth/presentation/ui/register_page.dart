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
import 'package:hr_career_platform/features/general/presentation/bloc/general_cubit.dart';

import '../../../../core/widgets/map_icon_button.dart';
import '../widget/login_ana_register_appbar_functhion.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  List<DynamicModel> regFormCompany(
      BuildContext context, List<ItemModel> ciyItems) {
    return [
      DynamicModel('companyNameEn', FormType.text,
          controller: TextEditingController(),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          isRequired: true,
          disabled: false,
          key: 'companyNameEn'),
      DynamicModel('companyNameAr', FormType.text,
          controller: TextEditingController(),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          isRequired: true,
          disabled: false,
          key: 'companyNameAr'),
      DynamicModel('email', FormType.email,
          controller: TextEditingController(),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          isRequired: true,
          disabled: false,
          key: 'email'),
      DynamicModel(
        'address',
        FormType.text,
        controller: TextEditingController(),
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        isRequired: true,
        disabled: false,
        key: 'address',
        action: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: MaterialButton(
              disabledColor: Colors.grey.shade600,
              padding: const EdgeInsets.all(4),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                  builder: (context) => LocationWidget(),
                ))
                    .then((value) {
                  context
                      .read<DynamicFormCubit>()
                      .updateValueOnly('address', value[0].toString());
                  print(value[0]);
                  print(value[1]);
                });
              },
              shape: const CircleBorder(),
              color: primaryColor,
              child: const Icon(
                Icons.location_on_outlined,
                color: Colors.white,
                size: 18,
              )),
        ),
      ),
      DynamicModel('city', FormType.dropdown,
          items: ciyItems,
          controller: TextEditingController(),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          isRequired: true,
          disabled: false,
          key: 'city'),
      DynamicModel('phone', FormType.phone,
          isRequired: true,
          controller: TextEditingController(),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          disabled: false,
          key: 'phone'),
      DynamicModel('govRegNo', FormType.text,
          isRequired: true,
          controller: TextEditingController(),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          disabled: false,
          key: 'govRegNo'),
      DynamicModel('password', FormType.password,
          isRequired: true,
          controller: TextEditingController(),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          disabled: false,
          key: 'password'),
      DynamicModel('confirmPassword', FormType.password,
          isRequired: true,
          controller: TextEditingController(),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired'),
            DynamicFormValidator(ValidatorType.equalTo, 'PasswordNotMatch'),
          ],
          disabled: false,
          key: 'confirmPassword'),
    ];
  }

  List<DynamicModel> regFormUsers(
      List<ItemModel> genderItems, List<ItemModel> natList) {
    return [
      DynamicModel('fullName', FormType.text,
          controller: TextEditingController(),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          isRequired: true,
          disabled: false,
          key: 'fullName'),
      DynamicModel('fullNameAr', FormType.text,
          controller: TextEditingController(),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          isRequired: true,
          disabled: false,
          key: 'fullNameAr'),
      DynamicModel('email', FormType.email,
          controller: TextEditingController(),
          isRequired: true,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          disabled: false,
          key: 'email'),
      DynamicModel('phone', FormType.phone,
          controller: TextEditingController(),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          isRequired: true,
          disabled: false,
          key: 'phone'),
      DynamicModel('currentJob', FormType.text,
          controller: TextEditingController(),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          isRequired: true,
          disabled: false,
          key: 'currentJob'),
      DynamicModel('gender', FormType.dropdown,
          items: genderItems,
          controller: TextEditingController(),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          isRequired: true,
          disabled: false,
          key: 'gender'),
      DynamicModel('nationality', FormType.dropdown,
          items: natList,
          controller: TextEditingController(),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          isRequired: true,
          disabled: false,
          key: 'nationality'),
      DynamicModel('password', FormType.password,
          controller: TextEditingController(),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          isRequired: true,
          disabled: false,
          key: 'password'),
      DynamicModel('confirmPassword', FormType.password,
          controller: TextEditingController(),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired'),
            DynamicFormValidator(ValidatorType.equalTo, 'PasswordNotMatch'),
          ],
          isRequired: true,
          disabled: false,
          key: 'confirmPassword'),
    ];
  }

  final userDynForm = [
    DynamicModel('fullName', FormType.text,
        controller: TextEditingController(),
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        isRequired: true,
        disabled: false,
        key: 'fullName'),
    DynamicModel('fullNameAr', FormType.text,
        controller: TextEditingController(),
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        isRequired: true,
        disabled: false,
        key: 'fullNameAr'),
    DynamicModel('email', FormType.email,
        controller: TextEditingController(),
        isRequired: true,
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        disabled: false,
        key: 'email'),
    DynamicModel('phone', FormType.phone,
        controller: TextEditingController(),
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        isRequired: true,
        disabled: false,
        key: 'phone'),
    DynamicModel('currentJob', FormType.text,
        controller: TextEditingController(),
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        isRequired: true,
        disabled: false,
        key: 'currentJob'),
    DynamicModel('gender', FormType.dropdown,
        items: [],
        controller: TextEditingController(),
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        isRequired: true,
        disabled: false,
        key: 'gender'),
    DynamicModel('nationality', FormType.dropdown,
        items: [],
        controller: TextEditingController(),
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        isRequired: true,
        disabled: false,
        key: 'nationality'),
    DynamicModel('password', FormType.password,
        controller: TextEditingController(),
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
        ],
        isRequired: true,
        disabled: false,
        key: 'password'),
    DynamicModel('confirmPassword', FormType.password,
        controller: TextEditingController(),
        validators: [
          DynamicFormValidator(ValidatorType.notEmpty, 'isRequired'),
          DynamicFormValidator(ValidatorType.equalTo, 'PasswordNotMatch'),
        ],
        isRequired: true,
        disabled: false,
        key: 'confirmPassword'),
  ];
  final regFormKeyUser = GlobalKey<FormState>();
  final regFormKeyCompany = GlobalKey<FormState>();

  _cardRegister(BuildContext _) {
    return Container(
        height: 500,
        width: 400,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        margin: EdgeInsets.only(
            left: 28, right: 28, top: MediaQuery.of(_).size.height * 0.2),
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(18)),
        child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            children: [
              Center(child: ToggleBtnWidget()),
              const SizedBox(
                height: 8,
              ),
              Center(
                child: BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
                  builder: (context, state) {
                    if (state.selectedTab == 0) {
                      return DynamicFormWidget(
                          key: const Key('regFormUsers'),
                          formKey: regFormKeyUser,
                          dynamicFormsList: userDynForm,
                          submitBtnLabel: 'login',
                          useResponsiveUi: false);
                    } else {
                      return DynamicFormWidget(
                        key: const Key('regFormCompany'),
                        formKey: regFormKeyCompany,
                        dynamicFormsList: regFormCompany(_, []),
                        submitBtnLabel: 'login',
                        useResponsiveUi: false,
                      );
                    }
                  },
                ),
              ),
              BlocBuilder<GeneralCubit, GeneralState>(
                builder: (context, gnState) {
                  if (gnState is GeneralFetchedState) {
                    int tabSelected = (context.read<ToggleBtnCubit>().state as ToggleBtnChangedState).selectedTab;
                    if(tabSelected ==0){
                      List<ItemModel> genderList = gnState.generals.gender
                          .map((e) => ItemModel(key: e, value: e))
                          .toList();
                      List<ItemModel> natList = gnState.generals.nationality
                          .map((e) => ItemModel(key: e, value: e))
                          .toList();
                      context
                          .read<DynamicFormCubit>()
                          .addMenuItems2('nationality', natList, '');
                      context
                          .read<DynamicFormCubit>()
                          .addMenuItems2('gender', genderList, '');
                    }else if(tabSelected==1){
                      List<ItemModel> cityItems = gnState.generals.cities
                          .map((e) => ItemModel(key: e, value: e))
                          .toList();
                      context
                          .read<DynamicFormCubit>()
                          .addMenuItems2('city', cityItems, '');

                    }
                    return const SizedBox();
                  }
                  return const SizedBox();
                },
              ),
              _registerBtn(),
              if (Responsive.isMobile(_))
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
                          Navigator.of(_).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              (route) => false);
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: primaryColor),
                        )),
                  ],
                ),
            ]));
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
                          'If you already have an account',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                  (route) => false);
                            },
                            child: const Text('Login here !')),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                  flex: 1, fit: FlexFit.loose, child: _cardRegister(context)),
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: _buildMobileRegPage(context),
        tablet: _desktopAndTabletRegPage(context),
        desktop: _desktopAndTabletRegPage(context),
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
                final selectedTab =
                    context.read<ToggleBtnCubit>().state.selectedTab;
                if (selectedTab == 0) {
                  if (regFormKeyUser.currentState!.validate()) {
                    context.read<RegisterCubit>().registerUser(
                        context.read<ToggleBtnCubit>().state.selectedTab,
                        value);
                  }
                } else {
                  if (regFormKeyCompany.currentState!.validate()) {
                    context.read<RegisterCubit>().registerUser(
                        context.read<ToggleBtnCubit>().state.selectedTab,
                        value);
                  }
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
