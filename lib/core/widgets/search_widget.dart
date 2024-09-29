import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_localizations.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/core/widgets/custom_drop_down_menu.dart';
import 'package:hr_career_platform/core/widgets/dyn_form_widget.dart';

import '../../features/general/presentation/bloc/general_cubit.dart';
import '../util/validator.dart';

class SearchWidget extends StatelessWidget {
  final double spacer = 4.0;
  late double screenWidth;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    List<DynamicModel> searchForm(double number) {
      if (number == 0) {
        return [
          DynamicModel(
              'search',
              key: 'search',
              FormType.text,
              icons: Icon(
                Icons.search,
                size: 16,
                color: primaryColor.withOpacity(0.8),
              ),
              controller: TextEditingController()),
          DynamicModel(
              'category',
              key: 'category',
              items: [],
              width: Responsive.isMobile(context) ? screenWidth : 300,
              FormType.dropdown,
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ],
              controller: TextEditingController()),
          DynamicModel(
              'company',
              key: 'company',
              width: Responsive.isMobile(context) ? screenWidth : 300,
              FormType.dropdown,
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ],
              controller: TextEditingController()),
          DynamicModel(
              'location',
              key: 'location',
              width: Responsive.isMobile(context) ? screenWidth : 300,
              FormType.dropdown,
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ],
              controller: TextEditingController()),
        ];
      } else {
        return [
          DynamicModel(
              'category',
              key: 'category',
              items: [],
              width: Responsive.isMobile(context) ? screenWidth : 300,
              FormType.dropdown,
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ],
              controller: TextEditingController()),
          DynamicModel(
              'company',
              key: 'company',
              width: Responsive.isMobile(context) ? screenWidth : 300,
              FormType.dropdown,
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ],
              controller: TextEditingController()),
          DynamicModel(
              'location',
              key: 'location',
              width: Responsive.isMobile(context) ? screenWidth : 300,
              FormType.dropdown,
              validators: [
                DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
              ],
              controller: TextEditingController()),
        ];
      }
    }

    return Responsive(
        mobile: _mobileWidgetBuilder(searchForm(1)),
        tablet: _desktopWidgetBuilder(searchForm(0)),
        desktop: _desktopWidgetBuilder(searchForm(0)));
  }

  Widget _mobileWidgetBuilder(List<DynamicModel> searchForm) {
    return ExpansionTile(
      childrenPadding: const EdgeInsets.all(4),
      title: SizedBox(
        width: 200,
        child: SearchBar(
          constraints: BoxConstraints.tight(const Size.fromHeight(35)),
          elevation: const WidgetStatePropertyAll(0.0),
          hintText: tr("search_msg"),
          leading: const Icon(
            Icons.search,
            color: primaryTransparent,
          ),
        ),
      ),
      children: [
        DynamicFormWidget(
            dynamicFormsList: searchForm,
            key: const Key('searchForm'),
            formKey: _formKey,
            useResponsiveUi: false),
        Padding(
          padding: EdgeInsets.all(spacer),
          child: SizedBox(
              width: 350,
              height: 35,
              child: ElevatedButton(
                  onPressed: () {}, child: const Text('search'))),
        )
      ],
    );
  }

  Widget _desktopWidgetBuilder(List<DynamicModel> searchForm) {
    double widthItem = (screenWidth / 5 - 50);
    return Wrap(
      direction: Axis.horizontal,
      spacing: (spacer * 2),
      children: <Widget>[
        DynamicFormWidget(
            dynamicFormsList: searchForm,
            key: const Key('searchForm'),
            formKey: _formKey,
            useResponsiveUi: true),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SizedBox(
              height: 35,
              width: widthItem,
              child: MaterialButton(
                  onPressed: () {},
                  height: 35,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                  color: primaryColor,
                  child: const Text(
                    'search',
                    style: TextStyle(color: Colors.white),
                  ))),
        ),
      ],
    );
  }
}
