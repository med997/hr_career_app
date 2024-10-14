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
   List<DynamicModel> searchWidegt = [];

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Responsive(
        mobile: _mobileWidgetBuilder(),
        tablet: _desktopWidgetBuilder(context),
        desktop: _desktopWidgetBuilder(context));
  }


  Widget _mobileWidgetBuilder() {
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
        BlocBuilder<GeneralCubit, GeneralState>(
          builder: (context, gnState) {
            if (gnState is GeneralFetchedState) {
              List<ItemModel> categoryItems = gnState
                  .generals.jobCategory
                  .map((e) => ItemModel(key: e, value: e))
                  .toList();
              List<ItemModel> companyItems = gnState
                  .generals.companyMajor
                  .map((e) => ItemModel(key: e, value: e))
                  .toList();
              List<ItemModel> locationItems = gnState.generals.cities
                  .map((e) => ItemModel(key: e, value: e))
                  .toList();
              final searchForm =  [
                DynamicModel(
                    'category',
                    key: 'category',
                    items:categoryItems ,
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
                    controller: TextEditingController(),
                items: companyItems),
                DynamicModel(
                    'location',
                    key: 'location',
                    width: Responsive.isMobile(context) ? screenWidth : 300,
                    FormType.dropdown,
                    validators: [
                      DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                    ],
                    controller: TextEditingController(),
                items: locationItems),
              ];
              return DynamicFormWidget(
                key: const Key('search'),
                dynamicFormsList: searchForm,
                formKey: _formKey,
                useResponsiveUi: true,
              );
            }
            return const SizedBox();
          },
        ),
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

  Widget _desktopWidgetBuilder(BuildContext context) {
    double widthItem = (screenWidth / 5 - 50);
    return Wrap(
      direction: Axis.horizontal,
      spacing: (spacer * 2),
      children: <Widget>[
        BlocBuilder<GeneralCubit, GeneralState>(
          builder: (context, gnState) {
            if (gnState is GeneralFetchedState) {
              List<ItemModel> categoryItems = gnState
                  .generals.jobCategory
                  .map((e) => ItemModel(key: e, value: e))
                  .toList();
              List<ItemModel> companyItems = gnState
                  .generals.companyMajor
                  .map((e) => ItemModel(key: e, value: e))
                  .toList();
              List<ItemModel> locationItems = gnState.generals.cities
                  .map((e) => ItemModel(key: e, value: e))
                  .toList();
              final searchForm = [
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
                    items: categoryItems,
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
                    items: companyItems,
                    validators: [
                      DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                    ],
                    controller: TextEditingController()),
                DynamicModel(
                    'location',
                    key: 'location',
                    width: Responsive.isMobile(context) ? screenWidth : 300,
                    FormType.dropdown,
                    items: locationItems,
                    validators: [
                      DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                    ],
                    controller: TextEditingController()),
                DynamicModel(
                    'search',
                    key: 'search',
                    FormType.subDynForm,
                    subFormHeader:  SizedBox(
                        height: 35,
                        width: Responsive.isMobile(context) ? screenWidth : 300,
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
                    subFormFooter: SizedBox(height: 0,),
                    validators: [
                      DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
                    ],
                    controller: TextEditingController(),
                subDynamicModel: searchWidegt),
              ];
              return DynamicFormWidget(
                key: const Key('search'),
                dynamicFormsList: searchForm,
                formKey: _formKey,
                useResponsiveUi: true,
              );
            }
            return const SizedBox();
          },
        ),

      ],
    );
  }
}
