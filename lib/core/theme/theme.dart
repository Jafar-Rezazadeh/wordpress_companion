import 'package:flutter/material.dart';
import 'color_pallet.dart';

class CustomTheme {
  lightTheme() => ThemeData(
        fontFamily: "Vazir",
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: ColorPallet.midBlue,
          onPrimary: ColorPallet.white,
          secondary: ColorPallet.lightBlue,
          onSecondary: ColorPallet.blue,
          error: ColorPallet.crimson,
          onError: ColorPallet.white,
          surface: ColorPallet.white,
          onSurface: ColorPallet.text,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(),
      );
}
