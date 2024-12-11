import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';
import 'package:wordpress_companion/features/categories/presentation/pages/categories_page.dart';

class MockCategoriesCubit extends MockCubit<CategoriesState>
    implements CategoriesCubit {}

void main() {
  late CategoriesCubit categoriesCubit;
  const fakeCategory = CategoryEntity(
    id: 2,
    count: 3,
    description: "description",
    link: "link",
    name: "name",
    slug: "slug",
    parent: 0,
  );
  const fakeCategoryChild = CategoryEntity(
    id: 3,
    count: 3,
    description: "description",
    link: "link",
    name: "name",
    slug: "slug",
    parent: 2,
  );

  setUpAll(() {
    registerFallbackValue(GetAllCategoriesParams());
  });

  setUp(() {
    categoriesCubit = MockCategoriesCubit();
    when(
      () => categoriesCubit.state,
    ).thenAnswer((_) => const CategoriesState.initial());
  });
  testWidget() {
    return ScreenUtilInit(
      child: BlocProvider(
        create: (context) => categoriesCubit,
        child: GetMaterialApp(
          getPages: [
            GetPage(
              name: createOrEditCategoryRoute,
              page: () => const CreateOrEditCategoryScreen(),
            ),
          ],
          home: const CategoriesPage(),
        ),
      ),
    );
  }

  group("floatingActionButton -", () {
    testWidgets(
        "should go to CreateOrEditCategoryScreen when add_category tapped",
        (tester) async {
      //arrange
      await tester.pumpWidget(testWidget());
      await tester.pumpAndSettle();

      //verification
      final addCategoryFinder = find.byKey(const Key("add_category"));
      expect(addCategoryFinder, findsOneWidget);

      //act
      await tester.tap(addCategoryFinder);
      await tester.pumpAndSettle();

      //assert
      expect(find.byType(CreateOrEditCategoryScreen), findsOneWidget);
    });
  });

  group("pageHeader -", () {
    group("searchInput -", () {
      testWidgets(
          "should call getAllCategories of categoriesCubit with search value when submit",
          (tester) async {
        //arrange
        await tester.pumpWidget(testWidget());
        await tester.pumpAndSettle();

        //verification
        expect(find.byType(CustomSearchInput), findsOneWidget);

        //act
        tester
            .widget<CustomSearchInput>(find.byType(CustomSearchInput))
            .onSubmit("hello");

        //assert
        verify(
          () => categoriesCubit.getAllCategories(
            any(
              that: isA<GetAllCategoriesParams>().having(
                (params) => params.search == "hello",
                "contain correct search value ",
                true,
              ),
            ),
          ),
        );
      });

      testWidgets(
          "should call getAllCategories of categoriesCubit with search value equal to NULL when onClear",
          (tester) async {
        //arrange
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider(
              create: (context) => categoriesCubit,
              child: const CategoriesPage(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        //verification
        expect(find.byType(CustomSearchInput), findsOneWidget);

        //act
        tester
            .widget<CustomSearchInput>(find.byType(CustomSearchInput))
            .onSubmit("hello");

        tester
            .widget<CustomSearchInput>(find.byType(CustomSearchInput))
            .onClear();

        verifyInOrder([
          () => categoriesCubit.getAllCategories(
                any(
                  that: isA<GetAllCategoriesParams>().having(
                    (params) => params.search == null,
                    "initial call",
                    true,
                  ),
                ),
              ),
          () => categoriesCubit.getAllCategories(
                any(
                  that: isA<GetAllCategoriesParams>().having(
                    (params) => params.search == null,
                    "onClear call",
                    true,
                  ),
                ),
              ),
        ]);
      });
    });

    group("filterButton -", () {
      testWidgets("should open filter_bottom_sheet when FilterButton tapped",
          (tester) async {
        //arrange
        await tester.pumpWidget(testWidget());
        await tester.pumpAndSettle();

        //verification
        expect(find.byType(FilterButton), findsOneWidget);

        //act
        await _openFilterBottomSheet(tester);

        //assert
        expect(find.byKey(const Key("filter_bottom_sheet")), findsOneWidget);
      });

      testWidgets(
          "should call getAllCategories of categoriesCubit when onApplyInvoked",
          (tester) async {
        //arrange
        await tester.pumpWidget(testWidget());
        await tester.pumpAndSettle();

        //verification
        await _openFilterBottomSheet(tester);
        expect(find.byKey(const Key("apply_filter_button")), findsOneWidget);

        //act
        await tester.tap(find.byKey(const Key("apply_filter_button")));

        //assert
        verifyInOrder([
          () => categoriesCubit.getAllCategories(any()), // init call
          () => categoriesCubit.getAllCategories(any()), // onApply call
        ]);
      });

      testWidgets("should setOrderBy params when onChanged of orderby_filter ",
          (tester) async {
        //arrange
        await tester.pumpWidget(testWidget());
        await tester.pumpAndSettle();

        //verification
        await _openFilterBottomSheet(tester);
        expect(find.byKey(const Key("orderby_filter")), findsOneWidget);

        //act
        _onChangeOrderByDropDown(tester, CategoryOrderByEnum.slug);

        //assert
        verify(
          () => categoriesCubit.getAllCategories(
            any(
              that: isA<GetAllCategoriesParams>().having(
                (params) => params.orderby == CategoryOrderByEnum.slug,
                "has correct orderby",
                true,
              ),
            ),
          ),
        );
      });

      testWidgets(
          "should call getAllCategories of categoriesCubit with null orderBy when clear_filter_button tapped",
          (tester) async {
        //arrange
        await tester.pumpWidget(testWidget());
        await tester.pumpAndSettle();

        //verification
        await _openFilterBottomSheet(tester);
        _onChangeOrderByDropDown(tester, CategoryOrderByEnum.count);
        expect(find.byKey(const Key("clear_filter_button")), findsOneWidget);

        //act
        await tester.tap(find.byKey(const Key("clear_filter_button")));
        await tester.pumpAndSettle();

        //assert
        verifyInOrder([
          () => categoriesCubit.getAllCategories(
                any(
                  that: isA<GetAllCategoriesParams>().having(
                      (params) => params.orderby == null,
                      "is orderby null",
                      true),
                ),
              ), // init call

          () => categoriesCubit.getAllCategories(
                any(
                  that: isA<GetAllCategoriesParams>().having(
                      (params) => params.orderby == null,
                      "is orderby null",
                      true),
                ),
              ), // onClear call
        ]);
      });
    });
  });

  group("_categoriesStateListener -", () {
    testWidgets("should LoadingWidget when state is loading", (tester) async {
      //arrange
      whenListen(
        categoriesCubit,
        Stream.fromIterable([
          const CategoriesState.loading(),
        ]),
      );
      await tester.pumpWidget(testWidget());
      await tester.pump(Durations.short1);

      //assert
      expect(find.byType(LoadingWidget), findsOneWidget);
    });
    testWidgets("should show list of category_node when params is Null",
        (tester) async {
      //arrange
      whenListen(
        categoriesCubit,
        Stream.fromIterable([
          const CategoriesState.loaded([fakeCategory, fakeCategoryChild])
        ]),
      );
      await tester.pumpWidget(testWidget());
      await tester.pumpAndSettle();

      //assert
      expect(
        find.byKey(Key("category_node_${fakeCategory.id}")),
        findsOneWidget,
      );
      expect(find.byType(CategoryItemWidget), findsWidgets);
    });

    testWidgets("should call getAllCategories when state is needRefresh ",
        (tester) async {
      //arrange
      whenListen(
        categoriesCubit,
        Stream.fromIterable([
          const CategoriesState.needRefresh(),
        ]),
      );
      await tester.pumpWidget(testWidget());
      await tester.pumpAndSettle();

      //assert
      verifyInOrder([
        () => categoriesCubit.getAllCategories(any()), // init call
        () => categoriesCubit.getAllCategories(any()), // needRefresh state call
      ]);
    });

    testWidgets("should show failure_bottom_sheet when state is error",
        (tester) async {
      //arrange
      whenListen(
        categoriesCubit,
        Stream.fromIterable([
          CategoriesState.error(InternalFailure(
            message: "message",
            stackTrace: StackTrace.fromString("stackTraceString"),
          ))
        ]),
      );
      await tester.pumpWidget(testWidget());
      await tester.pumpAndSettle();

      //assert
      expect(find.byKey(const Key("failure_bottom_sheet")), findsOneWidget);
    });
  });

  group("categoriesListView -", () {
    testWidgets("should call getAllCategories listView onRefresh",
        (tester) async {
      //arrange
      await tester.pumpWidget(testWidget());
      await tester.pumpAndSettle();

      //verification
      expect(find.byType(RefreshIndicator), findsOneWidget);

      //act
      await tester
          .widget<RefreshIndicator>(find.byType(RefreshIndicator))
          .onRefresh();

      //assert
      verifyInOrder([
        () => categoriesCubit.getAllCategories(any()), // init call
        () => categoriesCubit.getAllCategories(any()), // onRefresh call
      ]);
    });
  });
}

void _onChangeOrderByDropDown(
    WidgetTester tester, CategoryOrderByEnum orderby) {
  final orderByDropDown =
      tester.widget<CustomDropDownButton<CategoryOrderByEnum?>>(
    find.byWidgetPredicate(
      (widget) => widget is CustomDropDownButton<CategoryOrderByEnum?>,
    ),
  );

  orderByDropDown.onChanged(orderby);
}

Future<void> _openFilterBottomSheet(WidgetTester tester) async {
  await tester.tap(find.byType(FilterButton));
  await tester.pumpAndSettle();
}
