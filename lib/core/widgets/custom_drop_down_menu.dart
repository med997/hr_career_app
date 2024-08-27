

 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_career_platform/core/model/dynamic_model.dart';


Widget buildCustomDropDownMenu( DynamicModel dynModel ,){
  List<DropdownMenuEntry> dropdownItem =
  dynModel.items.map((e) =>
      DropdownMenuEntry(value: e.key, label: e.value),).toList();

  return  DropdownMenu(
    width: dynModel.width ,
     trailingIcon: Transform.translate(
       offset: const Offset(3, -7),
       child: const Icon(Icons.keyboard_arrow_down),
     ),
     label: Text(dynModel.controlName),
     dropdownMenuEntries: dropdownItem,
     onSelected: (value) {
       dynModel.value = value;
       print(dynModel.value);
     } ,
 );
 }