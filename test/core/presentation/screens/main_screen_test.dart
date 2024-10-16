import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/presentation/screens/main_screen.dart';

void main() {
  group("page control -", () {
    testWidgets(
        "should show the correct page base on use interact with bottomNavBar when ",
        (tester) async {
      //arrange
      await tester.pumpWidget(
        MaterialApp(
          home: MainScreen(imageProviderTest: FileImage(File(""))),
        ),
      );
      await tester.pumpAndSettle();

      //verification
      final postsPageFinder = find.byKey(const Key("posts_page"));
      final categoriesPageFinder = find.byKey(const Key("categories_page"));

      expect(find.byType(PageView), findsOneWidget);
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(postsPageFinder, findsOneWidget);

      final bottomNavBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      final pageView = tester.widget<PageView>(find.byType(PageView));

      expect(pageView.controller?.page, 0.0);

      //act
      bottomNavBar.onTap!(1);
      await tester.pumpAndSettle();

      //assert
      expect(postsPageFinder, findsNothing);
      expect(categoriesPageFinder, findsOneWidget);
      expect(pageView.controller?.page, 1.0);
    });

    testWidgets(
        "should update the bottomNavBar when user changes the page using pageViewer",
        (tester) async {
      //arrange
      BottomNavigationBar bottomNavBar;
      await tester.pumpWidget(
        MaterialApp(
          home: MainScreen(imageProviderTest: FileImage(File(""))),
        ),
      );
      await tester.pumpAndSettle();

      //verification
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.byType(PageView), findsOneWidget);
      bottomNavBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      final pageView = tester.widget<PageView>(find.byType(PageView));

      expect(bottomNavBar.currentIndex, 0);

      //act
      pageView.onPageChanged!(2);

      await tester.pumpAndSettle();

      bottomNavBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );

      //assert
      expect(bottomNavBar.currentIndex, 2);
    });
  });
}
