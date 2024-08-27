import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/core/widgets/custom_drop_down_menu.dart';
import 'package:hr_career_platform/core/widgets/text_fields_dyn.dart';

import '../model/dynamic_model.dart';

class DynamicFormWidget extends StatelessWidget {
  final double spacer = 4;
  final TextEditingController? controller;
  final List<DynamicModel> dynamicFormsList;
  final String submitBtnLabel;
  Function()? onSubmitClicked;
  final _formKey = GlobalKey<FormState>();
    DynamicFormWidget({super.key,
    this.onSubmitClicked,
    required this.dynamicFormsList,
    required this.submitBtnLabel,  this.controller});


  @override
  Widget build(BuildContext context) {
    return Responsive(

      mobile: _mobileDynamicFormBuilder(),
      desktop: _desktopWidgetBuilder(context,3),
      tablet: _desktopWidgetBuilder(context,2),

    );
  }


  Widget getWidgetBasedFormType(DynamicModel dynModel) {
    FormType type = dynModel.formType;
    switch (type) {
      case FormType.text:
        return SizedBox(
            width: dynModel.width,
            child: getTextWidget(dynModel));
      case FormType.number:
        return SizedBox();
      case FormType.multiline:
        return SizedBox();
      case FormType.dropdown:
        return buildCustomDropDownMenu(dynModel);
      case FormType.autoComplete:
        return SizedBox();
      case FormType.rTE:
        return SizedBox();
      case FormType.datePicker:
        return SizedBox();
    }
  }

  Widget _mobileDynamicFormBuilder() {
    return Form(
      key: _formKey,
      onChanged: () {print(_formKey.toString());},
      child: Column(children: [
        ...dynamicFormsList.map((e) {
          return getWidgetBasedFormType(e);
        },),

      ],
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
      child: Wrap(

        direction: Axis.horizontal,
        spacing: (spacer * 2),
        children: <Widget>[
          ...dynamicFormsList.map((e) {
            return SizedBox(
              width: e.width,
              child: getWidgetBasedFormType(e),
            );
          },),

          Container(
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(18)),
              width: itemWidth,
              height: 35,
              child: ElevatedButton(onPressed: () {}, child: Text('search'))),
        ],
      ),
    );
  }

  Widget _tabletDynamicFormBuilder() {
    return Column(children: [
      ...dynamicFormsList.map((e) => getWidgetBasedFormType(e),)
    ],
    );
  }

/*    case FormType.number:
        return getNumberTextWidget(index);
      case FormType.multiline:
        return getMultilineTextWidget(index);*/
/* case FormType.autoComplete:
        return getAutoComplete(index);
      case FormType.rTE:
        return getHtmlReadOnly(index);
      case FormType.datePicker:
        return getDatePicker(index);*/

/*
  Widget getAutoComplete(index) {
    return DropdownSearch<String>.multiSelection(
      items: const ["Facebook", "Twitter", "Microsoft"],
      popupProps: const PopupPropsMultiSelection.menu(
        isFilterOnline: true,
        showSelectedItems: true,
        showSearchBox: true,
        favoriteItemProps: FavoriteItemProps(
          showFavoriteItems: true,
        ),
      ),
      onChanged: print,
      selectedItems: const ["Facebook"],
    );
  }*/
}
