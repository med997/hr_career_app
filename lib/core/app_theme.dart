import 'package:flutter/material.dart';

const primaryColor = Color(0xff356899);
const primaryTransparent = Color(0x33356899);
const successColor = Color(0xFF3DD26D);
const secondaryColor = Color(0xff51eec2);
const bgColor = Color(0xfffafcfd);


final appTheme = ThemeData(
  scaffoldBackgroundColor: bgColor,
  fontFamily: 'almarai',
    inputDecorationTheme: InputDecorationTheme(

        floatingLabelStyle: TextStyle(color: primaryColor ,fontSize: 14),
        prefixStyle: TextStyle(fontSize: 12),
        iconColor: secondaryColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

        labelStyle: TextStyle(fontSize: 14),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(8),
        )),

    dropdownMenuTheme:  DropdownMenuThemeData(
        inputDecorationTheme:  InputDecorationTheme(

         contentPadding: EdgeInsets.symmetric(horizontal: 8),
          constraints: BoxConstraints.tightFor(height: 35),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
        ),

      textStyle: TextStyle(fontSize: 14),

    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: bgColor,
      elevation: 0.0,
      centerTitle: true,
    ),
    useMaterial3: false,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    navigationRailTheme: const NavigationRailThemeData(
        backgroundColor: bgColor,
        useIndicator: false,
        selectedIconTheme: IconThemeData(color: primaryColor)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: bgColor,
      showSelectedLabels: false,
      type: BottomNavigationBarType.shifting,

      showUnselectedLabels: false,
      selectedLabelStyle: TextStyle(color: primaryColor),
      selectedItemColor: primaryColor,
    ),
    textSelectionTheme: const TextSelectionThemeData(selectionColor: primaryColor),
    navigationBarTheme: const NavigationBarThemeData(
        indicatorColor: primaryTransparent,
        height: 70,
        backgroundColor: bgColor,

        shadowColor: bgColor,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected),
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: primaryColor),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: secondaryColor,
    ),
  );
