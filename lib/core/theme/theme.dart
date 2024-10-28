import 'package:flutter/material.dart';
import 'package:wordpress_companion/core/constants/constants.dart';
import 'color_pallet.dart';

class CustomTheme {
  lightTheme() => ThemeData(
        fontFamily: "Vazir",
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: ColorPallet.lightBlue,
          onPrimary: ColorPallet.white,
          secondary: ColorPallet.midBlue,
          onSecondary: ColorPallet.blue,
          error: ColorPallet.crimson,
          onError: ColorPallet.white,
          surface: ColorPallet.white,
          onSurface: ColorPallet.text,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(),
        expansionTileTheme: _expansionTileThemeData(),
        filledButtonTheme: _filledButtonThemeData(),
      );

  FilledButtonThemeData _filledButtonThemeData() {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: ColorPallet.lightBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(mediumCornerRadius),
        ),
      ),
    );
  }

  ExpansionTileThemeData _expansionTileThemeData() {
    return ExpansionTileThemeData(
      tilePadding:
          const EdgeInsets.symmetric(horizontal: edgeToEdgePaddingHorizontal),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(smallCornerRadius),
        side: BorderSide(color: ColorPallet.border),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(smallCornerRadius),
        side: BorderSide(color: ColorPallet.border),
      ),
      childrenPadding: const EdgeInsets.symmetric(
        horizontal: edgeToEdgePaddingHorizontal + 5,
        vertical: 10,
      ),
    );
  }
}
