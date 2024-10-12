import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/core/widgets/color_fields_dyn.dart';
import 'package:hr_career_platform/core/widgets/custom_drop_down_menu.dart';
import 'package:hr_career_platform/core/widgets/date_fields_dyn.dart';
import 'package:hr_career_platform/core/widgets/multi_line_field_dyn.dart';
import 'package:hr_career_platform/core/widgets/phone_fields_dyn.dart';
import 'package:hr_career_platform/core/widgets/text_fields_dyn.dart';

import '../model/dynamic_model.dart';
import '../util/validator.dart';

class DynamicFormWidget extends StatefulWidget {
  final bool useResponsiveUi;
  final double spacer = 4;
  final TextEditingController? controller;
  final List<DynamicModel> dynamicFormsList;
  final String submitBtnLabel;
  Widget? submitBtn;
  final formKey;

  DynamicFormWidget(
      {super.key,
      this.submitBtn,

      required this.dynamicFormsList,
      required this.formKey,
      this.submitBtnLabel = 'go',
      this.controller,
      required this.useResponsiveUi});

  @override
  State<DynamicFormWidget> createState() => _DynamicFormWidgetState();
}

class _DynamicFormWidgetState extends State<DynamicFormWidget> {
  final double spacer = 4;

  @override
  void initState() {
    super.initState();
    context.read<DynamicFormCubit>().addAllFields(widget.dynamicFormsList);
  }

  @override
  Widget build(BuildContext context) {


    return Responsive(
      mobile: _mobileDynamicFormBuilder(context),
      desktop: widget.useResponsiveUi
          ? _desktopWidgetBuilder(3)
          : _mobileDynamicFormBuilder(context),
      tablet: widget.useResponsiveUi
          ? _desktopWidgetBuilder(2)
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
      case FormType.date:
        return SizedBox(
            width: dynModel.width,
            child: getDatePickerWidget(dynModel, context));
      case FormType.color:
        return SizedBox(
            width: dynModel.width,
            child: getColorPickerWidget(dynModel, context));
      case FormType.multiline:
        return SizedBox(
            width: dynModel.width,
            child: getMultiLineFieldWidget(dynModel, context));
      case FormType.dropdown:
        return SizedBox(
            width: dynModel.width, child: buildCustomDropDownMenu(context, dynModel));

      case FormType.autoComplete:
        return SizedBox();
      case FormType.rTE:
        return SizedBox();
      case FormType.subDynForm:
        return _desktopSubDynamicForm(
            context, dynModel.subFormKey, dynModel, 2);
      case FormType.listSubDynForm:
        return _desktopListSubDynamicForm(context, dynModel.subFormKey,
            dynModel, dynModel.listSubDynamicModel!, 2);

      default: return SizedBox();
    }
  }

  Widget _mobileDynamicFormBuilder(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: BlocBuilder<DynamicFormCubit, List<DynamicModel>>(
        builder: (context, state) {
          return Column(

            children: [
              ...state.map(
                (e) {
                  return getWidgetBasedFormType(e, context);
                },
              ),
              widget.submitBtn??const SizedBox()
            ],
          );
        },
      ),
    );
  }

  Widget _desktopWidgetBuilder(int columnCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Form(
        key: widget.formKey,
        child: BlocBuilder<DynamicFormCubit, List<DynamicModel>>(
          builder: (context, state) {
            return Wrap(
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
                widget.submitBtn??const SizedBox()
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

  Widget _mobileSubDynamicForm(
      BuildContext context, dynamic formKey, List<DynamicModel> dynFormList) {
    return Column(
      children: [
        ...dynFormList.map(
          (e) {
            return getWidgetBasedFormType(e, context);
          },
        ),
      ],
    );
  }

  Widget _desktopSubDynamicForm(BuildContext context, dynamic formKey,
      DynamicModel dynModel, int columnCount) {
    return Form(
      key: formKey,
      child: Wrap(
          direction: Axis.horizontal,
          spacing: (spacer * 2),
          runSpacing:1,
          children: <Widget>[
            dynModel.subFormHeader!,
            ...dynModel.subDynamicModel!.map((e) {
              return SizedBox(
                width: e.width,
                child: getWidgetBasedFormType(e, context),
              );
            }),
            dynModel.subFormFooter!,
          ]),
    );
  }

  Widget _desktopListSubDynamicForm(
      BuildContext context,
      dynamic formKey,
      DynamicModel dynModel,
      List<List<DynamicModel>> dynFormList,
      int columnCount) {

    return Form(
        key: formKey,
        child: Wrap(
          direction: Axis.vertical,
          spacing: 1,
          children: [
            Wrap(
                direction: Axis.horizontal,
                spacing: (spacer * 2),
                children: <Widget>[
                  ...dynFormList[0].map((eSub) {
                    return Container(
                      height: 35,
                      margin: EdgeInsets.symmetric(vertical: 12),
                      width: eSub.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primaryColor),
                      child: Center(
                        child: Text(
                          eSub.controlName,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    );
                  }),
                  Container(
                      height: 35,
                      margin: EdgeInsets.symmetric(vertical: 12),
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: secondaryColor),
                      child: IconButton(
                        onPressed: () {
                          List<DynamicModel> newFields =   dynFormList[0].map((e) {
                            return DynamicModel(
                                e.controlName,
                                e.formType,
                                controller: TextEditingController(),
                                validators: [
                                  DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                                ],
                                isRequired: true,
                                key: '${e.controlName}${dynFormList.length}');
                          }).toList();
                          print('newFields');
                          print(newFields[0]);
                          dynModel.listSubDynamicModel!.add(newFields);
                          context.read<DynamicFormCubit>().updateFieldValue(dynModel);
                        },
                        icon: Icon(Icons.add, size: 18,),
                        color: Colors.white,
                      ))
                ]),
            ...dynFormList.map((parent) {
              return Wrap(
                  direction: Axis.horizontal,
                  spacing: (spacer * 2),
                  children: <Widget>[
                    ...parent.map((eSub) {
                      return SizedBox(
                        width: eSub.width,
                        child: getWidgetBasedFormType(eSub, context),
                      );
                    })
                  ]);
            })
          ],
        ));
  }
}
