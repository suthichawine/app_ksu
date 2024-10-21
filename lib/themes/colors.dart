// ignore_for_file: prefer_const_constructors

import 'package:app_ksu/themes/styles.dart';
import 'package:flutter/material.dart';

class AppTheme {

  // Custom text theme
  static final customTextTheme = TextTheme(
    bodyMedium: TextStyle(
      fontSize: 16,
    ),
    bodyLarge: TextStyle(
      fontSize: 24,
    ),
  );

  // Light theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    fontFamily: 'NotoSansThai',
    primaryColor: primary,
    primaryColorDark: primaryDark,
    primaryColorLight: primaryLight,
    hoverColor: divider,
    hintColor: accent,
    colorScheme: const ColorScheme.light(primary: primary),
    iconTheme: const IconThemeData(color: primaryText),
    scaffoldBackgroundColor: Colors.blue[50],
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: icons,
        fontFamily: 'NotoSansThai',
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      backgroundColor: Color.fromARGB(255, 103, 163, 219),
      foregroundColor: icons,
      iconTheme: IconThemeData(color: icons),
    ),
  );

  // dark theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: false,
    fontFamily: 'NotoSansThai',
    primaryColor: primary,
    primaryColorDark: primaryDark,
    primaryColorLight: primaryLight,
    hoverColor: divider,
    hintColor: accent,
    colorScheme: const ColorScheme.dark(primary: icons),
    iconTheme: const IconThemeData(color: icons),
    scaffoldBackgroundColor: primaryText,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: icons,
        fontFamily: 'NotoSansThai',
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      backgroundColor: primaryText,
      foregroundColor: icons,
      iconTheme: IconThemeData(color: icons),
    ),
  );

}