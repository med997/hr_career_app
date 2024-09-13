import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/core/widgets/custom_drop_down_menu.dart';
import 'package:hr_career_platform/core/widgets/phone_fields_dyn.dart';
import 'package:hr_career_platform/core/widgets/text_fields_dyn.dart';

import '../model/dynamic_model.dart';

class DynamicFormWidget extends StatelessWidget {
  final bool useResponsiveUi;
  final double spacer = 4;
  final TextEditingController? controller;
  final List<DynamicModel> dynamicFormsList;
  final String submitBtnLabel;
  Function()? onSubmitClicked;
  final formKey;

  DynamicFormWidget({super.key,
    this.onSubmitClicked,
    required this.dynamicFormsList,
    required this.formKey,
    this.submitBtnLabel = 'go',
    this.controller,
    required this.useResponsiveUi});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _mobileDynamicFormBuilder(context),
      desktop: useResponsiveUi
          ? _desktopWidgetBuilder(context, 3)
          : _mobileDynamicFormBuilder(context),
      tablet: useResponsiveUi
          ? _desktopWidgetBuilder(context, 2)
          : _mobileDynamicFormBuilder(context),
    );
  }

  Widget getWidgetBasedFormType(DynamicModel dynModel, BuildContext context) {
    FormType type = dynModel.formType;
    switch (type) {
      case FormType.text:
        return SizedBox(
            width: dynModel.width, child: getTextWidget(dynModel, context));
      case FormType.email:
        return SizedBox(
            width: dynModel.width, child: getTextWidget(dynModel, context));
      case FormType.phone:
        return SizedBox(
            width: dynModel.width, child: getPhoneWidget(dynModel, context));
      case FormType.password:
        return SizedBox(
            width: dynModel.width, child: getTextWidget(dynModel, context));
      case FormType.number:
        return SizedBox(
            width: dynModel.width, child: getTextWidget(dynModel, context));
      case FormType.multiline:
        return SizedBox(
            width: dynModel.width, child: getTextWidget(dynModel, context));
      case FormType.dropdown:
        return SizedBox(
            width: dynModel.width, child: buildCustomDropDownMenu(dynModel));

      case FormType.autoComplete:
        return SizedBox();
      case FormType.rTE:
        return SizedBox();
      case FormType.datePicker:
        return SizedBox(
            width: dynModel.width, child: getTextWidget(dynModel, context));
    }
  }

  Widget _mobileDynamicFormBuilder(BuildContext context) {
    return Form(
      key: formKey,
      child: BlocBuilder<DynamicFormCubit, List<DynamicModel>>(
        builder: (context, state) {
          return Wrap(
            alignment: WrapAlignment.center,
            spacing: 4,
            children: [
              ...state.map(
                    (e) {
                  return getWidgetBasedFormType(e, context);
                },
              ),
            ],
          );
        },
      ),
    );
  }


  Widget _desktopWidgetBuilder(BuildContext context, int columnCount) {
    double itemWidth = MediaQuery
        .of(context)
        .size
        .width / columnCount - 50;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Form(
        key: formKey,
        child:
        BlocBuilder<DynamicFormCubit, List<DynamicModel>>(
          builder: (context, state) {
            return Wrap(
              alignment: WrapAlignment.center,
              direction: Axis.horizontal,
              spacing: (spacer * 2),
              children: <Widget>[
                ...state.map(
                      (e) {
                    return SizedBox(
                      width: e.width,
                      child: getWidgetBasedFormType(e, context),
                    );
                  },
                ),
                // Container(
                //     decoration:
                //         BoxDecoration(borderRadius: BorderRadius.circular(18)),
                //     width: itemWidth,
                //     height: 35,
                //     child: ElevatedButton(onPressed: () {}, child: Text('search'))),
              ],
            );
          },
        ),

      ),
    );
  }
}
