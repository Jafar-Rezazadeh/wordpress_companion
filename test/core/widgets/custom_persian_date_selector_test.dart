import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart'
    hide DatePickerDialog;
import 'package:wordpress_companion/core/widgets/custom_persian_date_selector.dart';

void main() {
  testWidgets("should show the given label", (tester) async {
    //arrange
    await tester.pumpWidget(
      ScreenUtilInit(
        child: MaterialApp(
          home: Material(
            child: CustomPersianDateSelector(
              label: "test label",
              onSelected: (value) {},
            ),
          ),
        ),
      ),
    );

    //assert
    expect(find.text("test label"), findsOneWidget);
  });
  testWidgets(
      "should set the given initial value to the date picker button text",
      (tester) async {
    //arrange
    final initialDate = DateTime(2024, 1, 1);
    await tester.pumpWidget(
      ScreenUtilInit(
        child: MaterialApp(
          home: Material(
            child: CustomPersianDateSelector(
              label: "test",
              initialDate: initialDate,
              onSelected: (value) {},
            ),
          ),
        ),
      ),
    );

    //act
    final formattedInitialDate = find.text(
      Jalali.fromDateTime(initialDate).formatCompactDate(),
    );

    //assert
    expect(formattedInitialDate, findsOneWidget);
  });

  testWidgets("should open datePickerDialog when button is tapped",
      (tester) async {
    //arrange
    await tester.pumpWidget(
      ScreenUtilInit(
        child: MaterialApp(
          home: Material(
            child: CustomPersianDateSelector(
              label: "test",
              onSelected: (value) {},
            ),
          ),
        ),
      ),
    );

    //verification
    expect(find.byType(FilledButton), findsOneWidget);

    //act
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    //assert
    expect(find.byType(Dialog), findsOneWidget);
  });

  testWidgets("should invoke the on selected callback when after dialog closed",
      (tester) async {
    //arrange
    bool isInvoked = false;
    final initialDate = DateTime(2024, 1, 1);
    await tester.pumpWidget(
      ScreenUtilInit(
        child: MaterialApp(
          home: Material(
            child: CustomPersianDateSelector(
              label: "test",
              initialDate: initialDate,
              onSelected: (value) {
                isInvoked = true;
              },
            ),
          ),
        ),
      ),
    );

    //verification
    expect(find.byType(FilledButton), findsOneWidget);

    //act
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(0, 0));
    await tester.pumpAndSettle();

    //assert
    expect(isInvoked, true);
  });
}
