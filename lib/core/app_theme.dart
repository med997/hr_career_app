import 'package:flutter/material.dart';

const primaryColor = Color(0xff356899);
const primaryTransparent = Color(0x33356899);
const secondaryColor = Color(0xff51eec2);
const bgColor = Color(0xfffafcfd);


final appTheme = ThemeData(
  scaffoldBackgroundColor: bgColor,
  fontFamily: 'almarai',
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
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
    textSelectionTheme: TextSelectionThemeData(selectionColor: primaryColor),
    navigationBarTheme: const NavigationBarThemeData(
        indicatorColor: primaryTransparent,
        height: 70,
        backgroundColor: bgColor,

        shadowColor: bgColor,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected),
    colorScheme: ColorScheme.light(
      primary: primaryColor,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: secondaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: primaryColor),
        iconColor: secondaryColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: secondaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(8),
        )));
