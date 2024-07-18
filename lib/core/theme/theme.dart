import 'package:flutter/material.dart';

lightTheme() => ThemeData(
      colorSchemeSeed: const Color.fromRGBO(31, 49, 157, 1),
      fontFamily: "Vazir",
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: const Color.fromRGBO(31, 49, 157, 1),
        ),
      ),
      expansionTileTheme: ExpansionTileThemeData(
        childrenPadding: const EdgeInsets.all(10),
        collapsedShape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black45),
          borderRadius: BorderRadius.circular(10),
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black45),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      scaffoldBackgroundColor: Color.lerp(Colors.white, Colors.black, 0.04),
      textTheme: const TextTheme(
        bodySmall: TextStyle(
          color: Colors.black54,
        ),
      ),
    );
