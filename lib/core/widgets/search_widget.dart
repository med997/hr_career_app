import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_career_platform/core/app_localizations.dart';
import 'package:hr_career_platform/core/app_theme.dart';
import 'package:hr_career_platform/core/cubit/dynamic_form_cubit.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';
import 'package:hr_career_platform/core/util/enums.dart';
import 'package:hr_career_platform/core/util/responsive.dart';
import 'package:hr_career_platform/core/widgets/app_bar_function.dart';
import 'package:hr_career_platform/core/widgets/custom_drop_down_menu.dart';
import 'package:hr_career_platform/core/widgets/dyn_form_widget.dart';

import '../../features/general/domain/entities/general.dart';
import '../../features/general/presentation/bloc/general_cubit.dart';
import '../../features/job/presentation/bloc/job_search_cubit.dart';
import '../util/validator.dart';

class SearchWidget extends StatelessWidget {
  final double spacer = 4.0;
  late double screenWidth;
  double defaultWidth = 300;
  final _formKey = GlobalKey<FormState>();
  List<DynamicModel> searchForm = [];
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Responsive(
        mobile: _mobileWidgetBuilder(context),
        tablet: _desktopWidgetBuilder(context),
        desktop: _desktopWidgetBuilder(context));
  }
  Widget _mobileWidgetBuilder( BuildContext context) {
   double width =  Responsive.isMobile(context)  ? (defaultWidth / 0.8) : screenWidth ;
    General? generals = context.read<GeneralCubit>().general;
    List<ItemModel> nationalityItems = [];
    List<ItemModel> categoryItems = [];
    List<ItemModel> cityItems = [];
    if (generals != null) {
      nationalityItems =
          generals.nationality.map((e) => ItemModel(key: e, value: e)).toList();
      categoryItems = generals.jobCategory
          .map((e) => ItemModel(key: e, value: e))
          .toList();
      cityItems =
          generals.cities.map((e) => ItemModel(key: e, value: e)).toList();
    }
    final List<DynamicModel> searchFormMobile =  [
      DynamicModel(
          padding: 8,
          'category',
          key: 'category',
          items:categoryItems ,
          width: width,
          FormType.dropdown,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controller: TextEditingController()),
      DynamicModel(
        padding: 8,
          'city',
          key: 'city',
          width: width,
          FormType.dropdown,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controller: TextEditingController(),
          items: cityItems),
      DynamicModel(
        padding: 8,
          'nationality',
          key: 'nationality',
          width:width ,
          FormType.dropdown,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controller: TextEditingController(),
          items: nationalityItems),
    ];
    return ExpansionTile(
      childrenPadding: const EdgeInsets.symmetric(vertical: 8.0),
      title: SizedBox(
        width: 200,
        child: SearchBar(
          controller: _searchController,
          constraints: BoxConstraints.tight(const Size.fromHeight(35)),
          elevation: const WidgetStatePropertyAll(0.0),
          hintText:  "search_msg".tr(),
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            _searchAction(context);
          },
          leading: const Icon(
            Icons.search,
            color: primaryTransparent,
          ),
        ),
      ),
      children: [
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
                 child: DynamicFormWidget(
                  key: const Key('search'),
                  dynamicFormsList: searchFormMobile,
                  formKey: _formKey,
                    submitBtn: SizedBox(
                        width: width,
                        height: 35,
                        child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            color: primaryColor,
                            onPressed: () {
                             _searchAction(context);
                            }, child: const Text(
                          'search',
                          style: TextStyle(color: Colors.white),
                        ))) ,
                  useResponsiveUi: true,
                               ),
               ),

      ],
    );
  }

  Widget _desktopWidgetBuilder(BuildContext context) {
    double width =  300 ;
    if(Responsive.isDesktop(context))
      width = MediaQuery.of(context).size.width * 0.2 ;
    if(Responsive.isTablet(context))
      width = MediaQuery.of(context).size.width * 0.2 ;
    General? generals = context.read<GeneralCubit>().general;
    List<ItemModel> nationalityItems = [];
    List<ItemModel> categoryItems = [];
    List<ItemModel> companyItems = [];
    List<ItemModel> cityItems = [];
    if (generals != null) {
      nationalityItems =
          generals.nationality.map((e) => ItemModel(key: e, value: e)).toList();
      categoryItems = generals.jobCategory
          .map((e) => ItemModel(key: e, value: e))
          .toList();
      companyItems =
          generals.companyMajor.map((e) => ItemModel(key: e, value: e)).toList();
      cityItems =
          generals.cities.map((e) => ItemModel(key: e, value: e)).toList();
    }
   final List<DynamicModel> searchFormDesk = [
      DynamicModel(
          'search',
          key: 'search',
          FormType.text,
          width: width,
          icons: Icon(
            Icons.search,
            size: 16,
            color: primaryColor.withOpacity(0.8),
          ),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controller: _searchController),
      DynamicModel(
          'category',
          key: 'category',
          items: categoryItems,
          width: width,
          FormType.dropdown,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controller: TextEditingController()),
      DynamicModel(
          'company',
          key: 'company',
          width: width,
          FormType.dropdown,
          items: companyItems,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controller: TextEditingController()),
      DynamicModel(
          'city',
          key: 'city',
          width: width,
          FormType.dropdown,
          items: cityItems,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controller: TextEditingController()),
      DynamicModel(
          'nationality',
          key: 'nationality',
          width: width,
          FormType.dropdown,
          items: nationalityItems,
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controller: TextEditingController()),
      DynamicModel(
          'searchForm',
          key: 'searchForm',
          FormType.subDynForm,
          width: width,
          subFormHeader:  MaterialButton(
              onPressed: () {
                _searchAction(context);
              },
              height: 43,
              minWidth: width,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: primaryColor,
              child: Text(
                'search'.tr(),
                style: const TextStyle(color: Colors.white),
              )),
          subFormFooter: SizedBox(),
          validators: [
            DynamicFormValidator(ValidatorType.notEmpty, 'isRequired')
          ],
          controller: TextEditingController(),
          subDynamicModel: searchForm),
    ];
    return DynamicFormWidget(
     key: const Key('search'),
     dynamicFormsList: searchFormDesk,
     formKey: _formKey,
     useResponsiveUi: true,
                  );
  }

  void _searchAction(BuildContext context) {
    final value = context
        .read<DynamicFormCubit>()
        .getCurrentValue();
    value['searchVal']=_searchController.value.text;
    context.read<JobSearchCubit>().searchJob(value);
  }
}
