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

  DynamicFormWidget(
      {super.key,
      this.onSubmitClicked,
      required this.dynamicFormsList,
      required this.formKey,
      this.submitBtnLabel = 'go',
      this.controller,
      required this.useResponsiveUi});

  @override
  Widget build(BuildContext context) {
    context.read<DynamicFormCubit>().replaceAll(dynamicFormsList);

    return BlocBuilder<DynamicFormCubit,List<DynamicModel>>(
  builder: (context, state) {
    return Responsive(
      mobile: _mobileDynamicFormBuilder(context, state),
      desktop: useResponsiveUi
          ? _desktopWidgetBuilder(context, 3)
          : _mobileDynamicFormBuilder(context, state),
      tablet: useResponsiveUi
          ? _desktopWidgetBuilder(context, 2)
          : _mobileDynamicFormBuilder(context, state),
    );
  },
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
        return buildCustomDropDownMenu(dynModel);
      case FormType.autoComplete:
        return SizedBox();
      case FormType.rTE:
        return SizedBox();
      case FormType.datePicker:
        return SizedBox(
            width: dynModel.width, child: getTextWidget(dynModel, context));
    }
  }

  Widget _mobileDynamicFormBuilder(BuildContext context,List<DynamicModel> dynamicModelList) {
 
        return Form(
          key: formKey,
          child: Column(
            children: [
              ...dynamicModelList.map(
                (e) {
                  return getWidgetBasedFormType(e, context);
                },
              ),
            ],
          ),
        );

  }

  Widget _desktopWidgetBuilder(BuildContext context, int columnCount) {
    double itemWidth = MediaQuery.of(context).size.width / columnCount - 50;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Wrap(
        direction: Axis.horizontal,
        spacing: (spacer * 2),
        children: <Widget>[
          ...dynamicFormsList!.map(
            (e) {
              return SizedBox(
                width: e.width,
                child: getWidgetBasedFormType(e, context),
              );
            },
          ),
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
