import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/features/site_settings/presentation/widgets/start_of_week_input.dart';

void main() {
  testWidgets("should show the correct widget tree ", (tester) async {
    //arrange
    await tester.pumpWidget(
      MaterialApp(
        home: Material(child: StartOfWeekInput(onSelect: (value) {})),
      ),
    );

    //assert
    expect(find.byType(DropdownButton2<int>), findsOneWidget);
  });

  testWidgets(
      "should return the expected weekDay as int when dropdown item is selected",
      (tester) async {
    //arrange
    int? selectedValue;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: StartOfWeekInput(onSelect: (value) => selectedValue = value),
        ),
      ),
    );

    //verification
    expect(find.byType(DropdownButton2<int>), findsOneWidget);

    //act
    await tester.tap(find.byType(DropdownButton2<int>));
    await tester.pumpAndSettle();
    await tester.tap(find.text("یکشنبه"));
    await tester.pumpAndSettle();

    //assert
    expect(selectedValue, 0);
  });
}
