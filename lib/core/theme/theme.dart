import 'package:flutter/material.dart';
import 'package:wordpress_companion/core/theme/color_pallet.dart';

class CustomTheme {
  lightTheme() {
    return ThemeData(
      fontFamily: "Vazir",
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: ColorPallet.lightBlue,
        onPrimary: ColorPallet.white,
        secondary: ColorPallet.lightBlue,
        onSecondary: ColorPallet.blue,
        error: ColorPallet.crimson,
        onError: ColorPallet.white,
        surface: ColorPallet.white,
        onSurface: ColorPallet.text,
      ),
    );
  }
}
