import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';
import 'package:wordpress_companion/features/categories/presentation/screens/create_or_edit_category_screen.dart';
import 'package:wordpress_companion/features/categories/presentation/widgets/category_item_widget.dart';

void main() {
  const fakeCategory = CategoryEntity(
    id: 1,
    count: 3,
    description: "description",
    link: "link",
    name: "name",
    slug: "slug",
    parent: 0,
  );

  group("onTap -", () {
    testWidgets("should go to createOrEditCategoryRoute ", (tester) async {
      //arrange
      await tester.pumpWidget(_testWidget(fakeCategory));

      //verification
      expect(find.byKey(const Key("edit_category")), findsOneWidget);

      //act
      await tester.tap(find.byKey(const Key("edit_category")));
      await tester.pumpAndSettle();

      //assert
      expect(find.byType(CreateOrEditCategoryScreen), findsOneWidget);
    });

    testWidgets("should send the category to createOrEditCategoryScreen ",
        (tester) async {
      //arrange
      await tester.pumpWidget(_testWidget(fakeCategory));

      //verification

      //act
      await tester.tap(find.byKey(const Key("edit_category")));
      await tester.pumpAndSettle();

      //assert
      final screen = tester.widget<CreateOrEditCategoryScreen>(
          find.byType(CreateOrEditCategoryScreen));
      expect(screen.category, isNot(null));
    });
  });
}

MaterialApp _testWidget(CategoryEntity fakeCategory) {
  return MaterialApp.router(
    routerConfig: GoRouter(routes: [
      GoRoute(
          path: "/",
          builder: (context, state) =>
              CategoryItemWidget(category: fakeCategory, depth: 0),
          routes: [
            GoRoute(
              name: createOrEditCategoryRoute,
              path: createOrEditCategoryRoute,
              builder: (context, state) {
                final category = state.extra as CategoryEntity?;
                return CreateOrEditCategoryScreen(category: category);
              },
            )
          ])
    ]),
  );
}
