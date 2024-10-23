import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/features/site_settings/presentation/widgets/date_format_input.dart';

void main() {
  testWidgets(
      "should add the initialValue to TextFormField when it is not one of the predefined values",
      (tester) async {
    //arrange
    await tester.pumpWidget(
      ScreenUtilInit(
        child: MaterialApp(
          home: Material(
            child: DateFormatInput(
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
}
