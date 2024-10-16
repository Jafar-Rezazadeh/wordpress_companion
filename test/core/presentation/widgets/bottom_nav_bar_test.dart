import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/presentation/widgets/bottom_nav_bar.dart';

void main() {
  testWidgets("should show active icon when user tap on item", (tester) async {
    int selectedIndex = 0;

    //arrange
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Container(),
          bottomNavigationBar: CustomizedBottomNavBar(
            currentIndex: selectedIndex,
            onTap: (value) => selectedIndex = value,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // verification
    expect(selectedIndex, 0);
    expect(find.text("پست ها"), findsOneWidget);
    expect(find.text("دسته بندی"), findsOneWidget);

    //act
    await tester.tap(find.text("دسته بندی"));
    await tester.pump();

    //assert
    expect(selectedIndex, 1);
  });
}
