import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/widgets/pushed_page_app_bar.dart';

void main() {
  group("size -", () {
    testWidgets(
        "should the height be equal to AppBar().preferredSize.height when there is not (bottomActionWidgets or bottomLeadingWidgets)",
        (tester) async {
      //arrange
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            appBar: PushedPageAppBar(context: context),
          ),
        ),
      ));

      //verification
      expect(find.byType(PushedPageAppBar), findsOneWidget);

      //act
      final appBarFinder = find.byType(PushedPageAppBar);
      final appBar = tester.widget<PushedPageAppBar>(appBarFinder);

      //assert
      expect(appBar.preferredSize.height, AppBar().preferredSize.height);
    });

    testWidgets(
        "should the height be (AppBar().preferredSize.height + bottomHeightSize) when one of the (bottomActionWidgets or bottomLeadingWidgets) is not empty",
        (tester) async {
      //arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              appBar: PushedPageAppBar(
                context: context,
                bottomHeightSize: 30,
                bottomLeadingWidgets: [Container()],
              ),
            ),
          ),
        ),
      );

      //verification
      expect(find.byType(PushedPageAppBar), findsOneWidget);

      //act
      final appBarFinder = find.byType(PushedPageAppBar);
      final appBar = tester.widget<PushedPageAppBar>(appBarFinder);

      //assert
      expect(
        appBar.preferredSize.height,
        (AppBar().preferredSize.height + 30),
      );
    });
  });

  group("bottom -", () {
    testWidgets(
        "should bottom of abbBar be not null when one of the (bottomActionWidgets or bottomLeadingWidgets) is not empty",
        (tester) async {
      //arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              appBar: PushedPageAppBar(
                context: context,
                bottomActionWidgets: [Container()],
              ),
            ),
          ),
        ),
      );

      //verification
      expect(find.byType(PushedPageAppBar), findsOneWidget);

      //act
      final appBar = tester.widget<AppBar>(
        find.descendant(
          of: find.byType(PushedPageAppBar),
          matching: find.byType(AppBar),
        ),
      );

      //assert
      expect(appBar.bottom, isNotNull);
    });

    testWidgets(
        "should bottom of appBar be Null when both (bottomActionWidgets and bottomLeadingWidgets) is empty",
        (tester) async {
      //arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              appBar: PushedPageAppBar(context: context),
            ),
          ),
        ),
      );

      //verification
      expect(find.byType(PushedPageAppBar), findsOneWidget);

      //act
      final appBar = tester.widget<AppBar>(
        find.descendant(
          of: find.byType(PushedPageAppBar),
          matching: find.byType(AppBar),
        ),
      );

      //assert
      expect(appBar.bottom, isNull);
    });
  });
}
