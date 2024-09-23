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

class SearchWidget extends StatelessWidget {
  final double spacer = 4.0;
  late double screenWidth;
  late List<DynamicModel> dynamicFormsList;



  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Responsive(
        mobile: _mobileWidgetBuilder(),
        tablet: _desktopWidgetBuilder(),
        desktop: _desktopWidgetBuilder());
  }

  Widget _mobileWidgetBuilder() {
    return ExpansionTile(
      childrenPadding: EdgeInsets.all(4),
      title: SizedBox(
        width: 200,
        child: SearchBar(
          constraints: BoxConstraints.tight(const Size.fromHeight(35)),
          elevation: const WidgetStatePropertyAll(0.0),
          hintText: tr("search_msg"),
          leading: Icon(
            Icons.search,
            color: primaryTransparent,
          ),
        ),
      ),
      children: [
        Padding(
          padding: EdgeInsets.all(spacer),
          child: buildCustomDropDownMenu(  DynamicModel('category',
              key: 'category' ,
              FormType.dropdown, value: null,
              items: [
                ItemModel(key: '1', value: 'Mohammed'),
                ItemModel(key: '2', value: 'Mohammed'),
                ItemModel(key: '3', value: 'Mohammed'),
                ItemModel(key: '4', value: 'Mohammed'),
                ItemModel(key: '5', value: 'Mohammed'),]
          ) ),
        ),
        Padding(
          padding: EdgeInsets.all(spacer),
          child: buildCustomDropDownMenu(
           DynamicModel('company', FormType.dropdown, value: null,
           items: [
             ItemModel(key: '1', value: 'Mohammed'),
             ItemModel(key: '2', value: 'Mohammed'),
             ItemModel(key: '3', value: 'Mohammed'),
             ItemModel(key: '4', value: 'Mohammed'),
             ItemModel(key: '5', value: 'Mohammed'),], key: 'company'
           )

          ),
        ),
        Padding(
          padding: EdgeInsets.all(spacer),
          child: buildCustomDropDownMenu( DynamicModel('location', FormType.dropdown, value: null,
              items: [
                ItemModel(key: '1', value: 'Mohammed'),
                ItemModel(key: '2', value: 'Mohammed'),
                ItemModel(key: '3', value: 'Mohammed'),
                ItemModel(key: '4', value: 'Mohammed'),
                ItemModel(key: '5', value: 'Mohammed'),], key: 'location'
          )
              ),
        ),
        Padding(
          padding: EdgeInsets.all(spacer),
          child: SizedBox(
              width: 350,
              height: 35,
              child: ElevatedButton(onPressed: () {}, child: Text('search'))),
        )
      ],
    );
  }

  Widget _desktopWidgetBuilder() {
    double widthItem = (screenWidth / 5 - 50);
    return Wrap(
      direction: Axis.horizontal,
      spacing: (spacer * 2),
      children: <Widget>[


        BlocProvider(
      create: (context) => DynamicFormCubit()..addAllFields( [
        DynamicModel('Search',
      key: 'Search' ,
      width: widthItem,
      FormType.text,
      icons: Icon(Icons.search,size: 16, color:primaryColor.withOpacity(0.8) ,),
      items: [
        ItemModel(key: '1', value: 'Mohammed'),
        ItemModel(key: '2', value: 'Mohammed'),
        ItemModel(key: '3', value: 'Mohammed'),
        ItemModel(key: '4', value: 'Mohammed'),
        ItemModel(key: '5', value: 'Mohammed'),]
        ),   DynamicModel('category',
      width: widthItem,
      FormType.dropdown,
      value: null,
      items: [
        ItemModel(key: '1', value: 'Mohammed'),
        ItemModel(key: '2', value: 'Mohammed'),
        ItemModel(key: '3', value: 'Mohammed'),
        ItemModel(key: '4', value: 'Mohammed'),
        ItemModel(key: '5', value: 'Mohammed'),], key: 'category'
        ),
        DynamicModel('category',
      width: widthItem,
      FormType.dropdown,
      value: null,
      items: [
        ItemModel(key: '1', value: 'Mohammed'),
        ItemModel(key: '2', value: 'Mohammed'),
        ItemModel(key: '3', value: 'Mohammed'),
        ItemModel(key: '4', value: 'Mohammed'),
        ItemModel(key: '5', value: 'Mohammed'),], key: 'category'
        ),
        DynamicModel('category',
      width: widthItem,
      FormType.dropdown,
      value: null,
      items: [
        ItemModel(key: '1', value: 'Mohammed'),
        ItemModel(key: '2', value: 'Mohammed'),
        ItemModel(key: '3', value: 'Mohammed'),
        ItemModel(key: '4', value: 'Mohammed'),
        ItemModel(key: '5', value: 'Mohammed'),], key: 'category'
        ),
      ]),
      child: DynamicFormWidget(dynamicFormsList:[]
     , formKey: new GlobalKey(), useResponsiveUi: true),
    ),
     Padding(
       padding: const EdgeInsets.symmetric(vertical: 8.0),
       child: SizedBox(
         height: 35,
          width: widthItem,
           child: MaterialButton(onPressed: () {}, height: 35 ,
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
               padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
               color: primaryColor, child: Text('search',style: TextStyle(color: Colors.white),))),
     ),
      ],
    );
  }
}
