import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/core_export.dart';

void main() {
  testWidgets("should set the given initial value to dropdown ",
      (tester) async {
    //arrange
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CustomDropDownButton<String>(
            initialValue: "hello",
            onChanged: (value) {},
          ),
        ),
      ),
    );

    //verification
    final dropdownFinder = find.byType(DropdownButton2<String>);
    expect(dropdownFinder, findsOneWidget);

    //act
    final dropdownButton = tester.widget<DropdownButton2>(dropdownFinder);

    //assert
    expect(dropdownButton.value, "hello");
  });
  testWidgets(
      "should invoke the onChanged callback when dropdown value is changed",
      (tester) async {
    //arrange
    bool isInvoked = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CustomDropDownButton<String>(
            initialValue: "hello",
            onChanged: (value) {
              isInvoked = true;
            },
            items: const [
              DropdownMenuItem(value: "hello", child: Text("hello")),
              DropdownMenuItem(value: "hey", child: Text("hey")),
            ],
          ),
        ),
      ),
    );

    //verification
    final dropdownFinder = find.byType(DropdownButton2<String>);
    expect(dropdownFinder, findsOneWidget);

    //act
    await tester.tap(dropdownFinder);
    await tester.pumpAndSettle();
    await tester.tap(find.text("hey").last);

    //assert
    expect(isInvoked, true);
  });
}
