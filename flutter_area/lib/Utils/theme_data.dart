import 'package:flutter/material.dart';

import 'Extensions/color_extensions.dart';

ThemeData themeDataLight(BuildContext context) => ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Epilogue',
    textTheme: TextTheme(
      titleLarge: TextStyle(
          color: Theme.of(context).colorScheme.darkColor1,
          fontSize: 36,
          fontWeight: FontWeight.w600),
      headlineLarge: TextStyle(
          color: Theme.of(context).colorScheme.darkColor1,
          fontSize: 26,
          fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(
          color: Theme.of(context).colorScheme.darkColor1,
          fontSize: 20,
          fontWeight: FontWeight.w500),
      labelMedium: TextStyle(
          color: Theme.of(context).colorScheme.darkTransColor1,
          fontSize: 14,
          fontWeight: FontWeight.w300),
      displayMedium: TextStyle(
          color: Theme.of(context).colorScheme.darkTransColor2,
          fontSize: 13,
          fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(
          color: Theme.of(context).colorScheme.darkTransColor2,
          fontSize: 16,
          fontWeight: FontWeight.w400),
      headlineMedium: TextStyle(
          color: Theme.of(context).colorScheme.darkColor1,
          fontSize: 10,
          fontWeight: FontWeight.w500),
    ));

ThemeData themeDataDark(BuildContext context) => ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Epilogue',
    textTheme: TextTheme(
      titleLarge: TextStyle(
          color: Theme.of(context).colorScheme.lightColor1,
          fontSize: 36,
          fontWeight: FontWeight.w600),
      headlineLarge: TextStyle(
          color: Theme.of(context).colorScheme.lightColor1,
          fontSize: 26,
          fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(
          color: Theme.of(context).colorScheme.lightColor1,
          fontSize: 20,
          fontWeight: FontWeight.w500),
      labelMedium: TextStyle(
          color: Theme.of(context).colorScheme.lightTransColor1,
          fontSize: 14,
          fontWeight: FontWeight.w300),
      displayMedium: TextStyle(
          color: Theme.of(context).colorScheme.lightTransColor2,
          fontSize: 13,
          fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(
          color: Theme.of(context).colorScheme.lightTransColor2,
          fontSize: 16,
          fontWeight: FontWeight.w400),
      headlineMedium: TextStyle(
          color: Theme.of(context).colorScheme.lightColor1,
          fontSize: 10,
          fontWeight: FontWeight.w500),
    ));
