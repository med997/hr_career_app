

 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Widget buildCustomDropDownMenu(String label ,
    List<DropdownMenuEntry>  dataList, {double? width}){
 return  DropdownMenu(
    width: width ?? 350,
     trailingIcon: Transform.translate(
       offset: const Offset(3, -7),
       child: const Icon(Icons.keyboard_arrow_down),
     ),
     label: Text(label),
     dropdownMenuEntries: dataList
 );
 }