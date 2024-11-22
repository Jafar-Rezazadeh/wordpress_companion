import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/categories/application/widgets/category_selector_widget.dart';
import 'package:wordpress_companion/features/categories/domain/entities/category_entity.dart';
import 'package:wordpress_companion/features/categories/application/categories_cubit/categories_cubit.dart';
import 'package:wordpress_companion/features/posts/presentation/login_holders/utils/get_posts_filters.dart';
import 'package:wordpress_companion/features/posts/presentation/widgets/posts_page/posts_filter_widget.dart';

class FakeCategoryEntity extends Fake implements CategoryEntity {
  @override
  int get id => 10;
}

class MockCategoriesCubit extends MockCubit<CategoriesState>
    implements CategoriesCubit {}

void main() {
  late CategoriesCubit categoriesCubit;

  final statusDropDownFinder = find.byType(
    CustomDropDownButton<PostStatusEnum>,
  );
  final dateExpansionFinder = find.byKey(
    const Key("date_filter_expansion"),
  );
  final categorySelectorExpansion = find.byKey(
    const Key("category_selector_expansion"),
  );
  final afterDateInput = find.byKey(const Key("after_date_input"));
  final beforeDateInput = find.byKey(const Key("before_date_input"));

  setUp(() {
    categoriesCubit = MockCategoriesCubit();
    when(
      () => categoriesCubit.state,
    ).thenAnswer((_) => const CategoriesState.initial());
  });

  Future<void> makeTestWidget(
    WidgetTester tester,
    GetPostsFilters filters, {
    Function()? onClear,
  }) {
    return tester.pumpWidget(
      BlocProvider<CategoriesCubit>(
        create: (context) => categoriesCubit,
        child: ScreenUtilInit(
          child: MaterialApp(
            home: Material(
              child: PostsFilterWidget(
                filters: filters,
                onApply: () {},
                onClear: onClear ?? () {},
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> verifyAllInputs(WidgetTester tester) async {
    expect(statusDropDownFinder, findsOneWidget);
    expect(dateExpansionFinder, findsOneWidget);
    expect(categorySelectorExpansion, findsOneWidget);

    await tester.tap(dateExpansionFinder);
    await tester.tap(categorySelectorExpansion);
    await tester.pumpAndSettle();

    expect(afterDateInput, findsOneWidget);
    expect(beforeDateInput, findsOneWidget);
    expect(find.byType(CategorySelectorWidget), findsOneWidget);
  }

  Future<void> addFiltersViaInputs(WidgetTester tester) async {
    await tester
        .widget<CustomDropDownButton<PostStatusEnum>>(statusDropDownFinder)
        .onChanged(PostStatusEnum.pending);
    await tester
        .widget<CustomPersianDateSelector>(afterDateInput)
        .onSelected(DateTime(1));
    await tester
        .widget<CustomPersianDateSelector>(beforeDateInput)
        .onSelected(DateTime(1));

    await tester
        .widget<CategorySelectorWidget>(find.byType(CategorySelectorWidget))
        .onSelect([FakeCategoryEntity()]);
  }

  testWidgets(
      "should set the numberOfAppliedFilters on filter button when based on not null filters",
      (tester) async {
    //arrange
    final filters = GetPostsFilters();

    filters
      ..setAfter("2022-01-01")
      ..setBefore("2022-01-01")
      ..setStatus([PostStatusEnum.pending])
      ..setCategories([12]);

    await makeTestWidget(tester, filters);

    //verification
    expect(find.byType(FilterButton), findsOneWidget);

    //act
    final numberOfAppliedFilters = tester
        .widget<FilterButton>(find.byType(FilterButton))
        .numberOfAppliedFilters;

    //assert
    expect(numberOfAppliedFilters, 4);
  });

  group("statusFilter -", () {
    testWidgets(
        "should set dropdownValue to filter.status.first when length of filter.status is 1",
        (tester) async {
      //arrange
      final filters = GetPostsFilters();
      filters.setStatus([PostStatusEnum.pending]);

      await makeTestWidget(tester, filters);

      await _openFilterBottomSheet(tester);

      //verification
      expect(find.byType(CustomDropDownButton<PostStatusEnum>), findsOneWidget);

      //act
      final customDropDownButton =
          tester.widget<CustomDropDownButton<PostStatusEnum>>(
        find.byType(CustomDropDownButton<PostStatusEnum>),
      );

      //assert
      expect(customDropDownButton.initialValue, PostStatusEnum.pending);
    });

    testWidgets("should set dropdownValue to null when filters.status is not 1",
        (tester) async {
      //arrange
      final filters = GetPostsFilters();
      filters.setStatus(PostStatusEnum.values);

      await makeTestWidget(tester, filters);
      await _openFilterBottomSheet(tester);

      //verification
      final statusDropDownFinder =
          find.byType(CustomDropDownButton<PostStatusEnum>);
      expect(statusDropDownFinder, findsOneWidget);

      //act
      final customDropDownButton =
          tester.widget<CustomDropDownButton<PostStatusEnum>>(
        statusDropDownFinder,
      );

      //assert
      expect(customDropDownButton.initialValue, null);
    });
  });

  group("onApply -", () {
    testWidgets("should set filters to filter on apply", (tester) async {
      //arrange
      final filters = GetPostsFilters();

      await makeTestWidget(tester, filters);
      await _openFilterBottomSheet(tester);

      //verification

      await verifyAllInputs(tester);

      //act
      await addFiltersViaInputs(tester);

      await tester.tap(find.byKey(const Key("apply_filter_button")));
      await tester.pumpAndSettle();

      //assert
      expect(filters.status, [PostStatusEnum.pending]);
      expect(filters.after, DateTime(1).toIso8601String());
      expect(filters.before, DateTime(1).toIso8601String());
      expect(filters.categories, [FakeCategoryEntity().id]);
    });
  });

  group("onClear -", () {
    testWidgets("should call the onClear when clear_filter_button tapped",
        (tester) async {
      //arrange
      final filters = GetPostsFilters();

      bool isInvoked = false;
      await makeTestWidget(tester, filters, onClear: () => isInvoked = true);
      await _openFilterBottomSheet(tester);

      //act
      await tester.tap(find.byKey(const Key("clear_filter_button")));
      await tester.pumpAndSettle();

      //assert
      expect(isInvoked, true);
    });
  });
}

Future<void> _openFilterBottomSheet(WidgetTester tester) async {
  expect(find.byType(FilterButton), findsOneWidget);
  await tester.tap(find.byType(FilterButton));

  await tester.pumpAndSettle();
}
