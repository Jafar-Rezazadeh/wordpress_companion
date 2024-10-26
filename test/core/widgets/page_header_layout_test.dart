import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/widgets/page_header_layout.dart';

void main() {
  testWidgets("should have 2 place holder when left and right widget is null  ",
      (tester) async {
    //arrange
    await tester.pumpWidget(
      const MaterialApp(home: PageHeaderLayout()),
    );

    //act
    final placeHolderFinder = find.byType(Placeholder);

    //assert
    expect(placeHolderFinder, findsExactly(2));
  });

  testWidgets("should expected widgets for left and right when is assigned",
      (tester) async {
    //arrange
    await tester.pumpWidget(
      const MaterialApp(
        home: PageHeaderLayout(
          leftWidget: Text("left"),
          rightWidget: Text("right"),
        ),
      ),
    );

    //assert
    expect(find.text("left"), findsOneWidget);
    expect(find.text("right"), findsOneWidget);
  });
}
