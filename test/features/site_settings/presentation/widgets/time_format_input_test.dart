import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/widgets/grouped_radio_button.dart';
import 'package:wordpress_companion/features/site_settings/site_settings_exports.dart';

void main() {
  testWidgets("should render correct widget tree ", (tester) async {
    //arrange
    await tester.pumpWidget(
      ScreenUtilInit(
        child: MaterialApp(
          home: Material(
            child: TimeFormatInput(onChanged: (_) {}),
          ),
        ),
      ),
    );

    //assert
    expect(find.byType(GroupedRadioButton<String>), findsOneWidget);
  });
  testWidgets(
      "should add the initialValue to TextFormField if it is not one of the predefined values",
      (tester) async {
    //arrange
    await tester.pumpWidget(
      ScreenUtilInit(
        child: MaterialApp(
          home: Material(
            child: TimeFormatInput(
              initialValue: "test",
              onChanged: (_) {},
            ),
          ),
        ),
      ),
    );

    //act
    final textFormField = tester.widget<TextFormField>(
      find.byType(TextFormField),
    );

    //assert
    expect(find.text("test"), findsOneWidget);
    expect(textFormField.initialValue, "test");
  });

  testWidgets(
      "should return the expected value when tap on a certain radio button",
      (tester) async {
    //arrange
    String? selectedValue;
    await tester.pumpWidget(
      ScreenUtilInit(
        child: MaterialApp(
          home: Material(
            child: TimeFormatInput(onChanged: (value) => selectedValue = value),
          ),
        ),
      ),
    );

    //verification
    expect(find.byType(GroupedRadioButton<String>), findsOneWidget);

    //act
    await tester.tap(find.text("g:i a"));
    await tester.pump();

    //assert
    expect(selectedValue, "g:i a");
  });
}
