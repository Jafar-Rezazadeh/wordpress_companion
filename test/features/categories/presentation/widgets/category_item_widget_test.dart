import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';

class MockCategoriesCubit extends MockCubit<CategoriesState>
    implements CategoriesCubit {}

void main() {
  late CategoriesCubit categoryCubit;
  const fakeCategory = CategoryEntity(
    id: 1,
    count: 3,
    description: "description",
    link: "link",
    name: "name",
    slug: "slug",
    parent: 0,
  );
  setUp(() {
    categoryCubit = MockCategoriesCubit();

    when(
      () => categoryCubit.state,
    ).thenAnswer((_) => const CategoriesState.initial());
  });

  MaterialApp testWidget() {
    return MaterialApp.router(
      routerConfig: GoRouter(routes: [
        ShellRoute(
          builder: (context, state, child) => BlocProvider(
            create: (context) => categoryCubit,
            child: ScreenUtilInit(child: child),
          ),
          routes: [
            GoRoute(
                path: "/",
                builder: (context, state) =>
                    const CategoryItemWidget(category: fakeCategory, depth: 0),
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
          ],
        ),
      ]),
    );
  }

  group("onTap -", () {
    testWidgets("should go to createOrEditCategoryRoute ", (tester) async {
      //arrange
      await tester.pumpWidget(testWidget());

      //verification
      final listTileFinder = find.byType(ListTile);
      expect(listTileFinder, findsOneWidget);

      //act
      await tester.tap(listTileFinder);
      await tester.pumpAndSettle();

      //assert
      expect(find.byType(CreateOrEditCategoryScreen), findsOneWidget);
    });

    testWidgets("should send the category to createOrEditCategoryScreen ",
        (tester) async {
      //arrange
      await tester.pumpWidget(testWidget());

      //act
      final listTileFinder = find.byType(ListTile);
      await tester.tap(listTileFinder);
      await tester.pumpAndSettle();

      //assert
      final screen = tester.widget<CreateOrEditCategoryScreen>(
          find.byType(CreateOrEditCategoryScreen));
      expect(screen.category, isNot(null));
    });
  });
}