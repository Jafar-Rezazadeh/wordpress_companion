import 'package:flutter/material.dart';

lightTheme() => ThemeData(
      colorSchemeSeed: const Color.fromRGBO(31, 49, 157, 1),
      fontFamily: "Vazir",
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: const Color.fromRGBO(31, 49, 157, 1),
        ),
      ),
    );
