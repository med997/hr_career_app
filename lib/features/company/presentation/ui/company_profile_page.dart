import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/core/cubit/toggle_btn_cubit.dart';
import 'package:hr_career_platform/features/company/presentation/widgets/company_button.dart';
import '../../../../core/model/dynamic_model.dart';
import '../../../../core/util/enums.dart';
import '../../../../core/util/responsive.dart';
import '../../../../core/util/validator.dart';
import '../../../../core/widgets/dyn_form_widget.dart';
import '../../../../core/widgets/sub-title.dart';
import '../widgets/company_appbar.dart';

class CompanyProfilePage extends StatelessWidget {
  CompanyProfilePage({
    super.key,
  });

  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    bool isEditing = false;
    double width = MediaQuery.of(context).size.width;
    List<DynamicModel> companyProfile() {
      return [
        DynamicModel(
            width: Responsive.isMobile(context) ? width : 300,
            'nameAr',
            FormType.text,
            value: '',
            disabled: isEditing,
            validators: [
              DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
            ]),
        DynamicModel('nameEn', FormType.text,
            value: '',
            width: Responsive.isMobile(context) ? width : 300,
            disabled: isEditing,
            validators: [
              DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
            ]),
        DynamicModel('headOffice', FormType.text,
            value: '',
            width: Responsive.isMobile(context) ? width : 300,
            disabled: isEditing,
            validators: [
              DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
            ]),
        DynamicModel('major', FormType.text,
            value: '',
            width: Responsive.isMobile(context) ? width : 300,
            disabled: isEditing,
            validators: [
              DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
            ]),
        DynamicModel('nationality', FormType.dropdown,
            value: '',
            width: Responsive.isMobile(context) ? width : 300,
            disabled: isEditing,
            items: [
              ItemModel(key: 'saudi', value: 'saudi'),
              ItemModel(key: 'yemeni', value: 'yemeni'),
              ItemModel(key: 'egyptian', value: 'egyptian'),
            ],
            validators: [
              DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
            ]),
        DynamicModel('size', FormType.dropdown,
            value: '',
            width: Responsive.isMobile(context) ? width : 300,
            disabled: isEditing,
            items: [
              ItemModel(key: '', value: '0-10'),
              ItemModel(key: '', value: '10-20'),
            ],
            validators: [
              DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
            ]),
        DynamicModel('phone', FormType.phone,
            value: '',
            width: Responsive.isMobile(context) ? width : 300,
            disabled: isEditing,
            validators: [
              DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
            ]),
        DynamicModel('start Date', FormType.text,
            value: '',
            width: Responsive.isMobile(context) ? width : 300,
            disabled: isEditing,
            validators: [
              DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
            ]),
        DynamicModel('email', FormType.email,
            value: '',
            width: Responsive.isMobile(context) ? width : 300,
            disabled: isEditing,
            validators: [
              DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
            ]),
        DynamicModel('website', FormType.text,
            value: '',
            width: Responsive.isMobile(context) ? width : 300,
            disabled: isEditing,
            validators: [
              DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
            ]),
        DynamicModel('address', FormType.text,
            value: '',
            width: Responsive.isMobile(context) ? width : 300,
            disabled: isEditing,
            validators: [
              DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
            ]),
        DynamicModel('aboutUs', FormType.text,
            value: '',
            width: Responsive.isMobile(context) ? width : 300,
            disabled: isEditing,
            validators: [
              DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
            ]),
      ];
    }
    return Scaffold(
      appBar: jobsAppBarFunction(
          backgroundCompanyImg: 'assets/imgs/google_background.png',
          companyEmail: '',
          companyLocation: 'US, California',
          companyLogo:'assets/imgs/google_logo.png',
          companyMajor: 'Software Engineering',
          companyName: 'Google',
          companyNumber: '',
          companyWebsite: ''),
      body: BlocProvider(
        create: (context) => DynamicFormCubit()
          ..addAllFields(companyProfile()),
        child: BlocBuilder<ToggleBtnCubit, ToggleBtnState>(
          builder: (context, state) {
            switch (state.selectedTab) {
              case 0:
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shrinkWrap: true,
                    children: [
                      CompanyButton(),
                      const SizedBox(
                        height: 14,
                      ),
                      SubTitle(
                        title: 'Main Information',
                        titleType: SubTitleType.withIcon,
                        iconButton: IconButton(
                            onPressed: () {
                              isEditing = !isEditing;
                              context.read<DynamicFormCubit>().replaceAll(
                                  companyProfile());
                            },
                            icon: const Icon(
                              Icons.edit_road,
                              color: primaryColor,
                            )),
                      ),
                      DynamicFormWidget(
                        // key: const Key('companyProfile'),
                        dynamicFormsList:
                            companyProfile(),
                        formKey: _formKey,
                        useResponsiveUi: true,
                      ),
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaterialButton(
                                color:  Colors.yellow.shade700,
                                minWidth: 12,
                                height: 40,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                onPressed: () {},
                                child: const Icon(
                                  Icons.save_outlined,
                                  color: Colors.white,
                                  size: 19,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              case 1:
                return ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    CompanyButton(),
                  ],
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
