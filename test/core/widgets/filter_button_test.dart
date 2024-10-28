import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/core_export.dart';

void main() {
  group("on tap -", () {
    testWidgets(
        'should invoke the given onPressed callback when user taps on the button',
        (tester) async {
      //arrange
      int someValueChangeOnCallBack = 0;
      onPressed() {
        someValueChangeOnCallBack++;
      }

      await tester.pumpWidget(
        ScreenUtilInit(
          child: MaterialApp(
            home: Material(
              child: FilterButton(
                onPressed: onPressed,
              ),
            ),
          ),
        ),
      );

      //act
      await tester.tap(find.byType(FilterButton));
      await tester.pump();

      //assert
      expect(someValueChangeOnCallBack, 1);
    });
  });

  group("badge -", () {
    testWidgets("should Not show the badge when numberOfFilters is null",
        (tester) async {
      //arrange
      await tester.pumpWidget(
        const ScreenUtilInit(
          child: MaterialApp(
            home: Material(
              child: FilterButton(
                numberOfAppliedFilters: null,
              ),
            ),
          ),
        ),
      );

      //assert
      expect(find.byType(Badge), findsNothing);
    });

    testWidgets("should Show the badge when numberOfFilters is not null ",
        (tester) async {
      //arrange
      await tester.pumpWidget(
        const ScreenUtilInit(
          child: MaterialApp(
            home: Material(
              child: FilterButton(
                numberOfAppliedFilters: 5,
              ),
            ),
          ),
        ),
      );

      //assert
      expect(find.byType(Badge), findsOneWidget);
      expect(find.text("5"), findsOneWidget);
    });
  });
}
