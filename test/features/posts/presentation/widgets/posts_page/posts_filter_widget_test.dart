import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/posts/presentation/login_holders/utils/get_posts_filters.dart';
import 'package:wordpress_companion/features/posts/presentation/widgets/posts_page/posts_filter_widget.dart';

void main() {
  testWidgets(
      "should set the numberOfAppliedFilters on filter button when based on not null filters",
      (tester) async {
    //arrange
    final filters = GetPostsFilters();

    filters
      ..setAfter("2022-01-01")
      ..setBefore("2022-01-01")
      ..setStatus([PostStatusEnum.pending]);

    await _makeTestWidget(tester, filters);

    //verification
    expect(find.byType(FilterButton), findsOneWidget);

    //act
    final numberOfAppliedFilters = tester
        .widget<FilterButton>(find.byType(FilterButton))
        .numberOfAppliedFilters;

    //assert
    expect(numberOfAppliedFilters, 3);
  });

  group("statusFilter -", () {
    testWidgets(
        "should set dropdownValue to filter.status.first when length of filter.status is 1",
        (tester) async {
      //arrange
      final filters = GetPostsFilters();
      filters.setStatus([PostStatusEnum.pending]);

      await _makeTestWidget(tester, filters);

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

      await _makeTestWidget(tester, filters);
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

      await _makeTestWidget(tester, filters);
      await _openFilterBottomSheet(tester);

      //verification
      final statusDropDownFinder =
          find.byType(CustomDropDownButton<PostStatusEnum>);
      final dateExpansionFinder =
          find.byKey(const Key("date_filter_expansion"));
      final afterDateInput = find.byKey(const Key("after_date_input"));
      final beforeDateInput = find.byKey(const Key("before_date_input"));

      expect(statusDropDownFinder, findsOneWidget);
      expect(dateExpansionFinder, findsOneWidget);

      await tester.tap(dateExpansionFinder);
      await tester.pumpAndSettle();

      //
      expect(afterDateInput, findsOneWidget);
      expect(beforeDateInput, findsOneWidget);

      //act
      await tester
          .widget<CustomDropDownButton<PostStatusEnum>>(statusDropDownFinder)
          .onChanged(PostStatusEnum.pending);
      await tester
          .widget<CustomPersianDateSelector>(afterDateInput)
          .onSelected(DateTime(1));
      await tester
          .widget<CustomPersianDateSelector>(beforeDateInput)
          .onSelected(DateTime(1));

      await tester.tap(find.byKey(const Key("apply_filter_button")));
      await tester.pumpAndSettle();

      //assert
      expect(filters.status, [PostStatusEnum.pending]);
      expect(filters.after, DateTime(1).toIso8601String());
      expect(filters.before, DateTime(1).toIso8601String());
    });
  });
}

Future<void> _openFilterBottomSheet(WidgetTester tester) async {
  expect(find.byType(FilterButton), findsOneWidget);
  await tester.tap(find.byType(FilterButton));

  await tester.pumpAndSettle();
}

Future<void> _makeTestWidget(WidgetTester tester, GetPostsFilters filters) {
  return tester.pumpWidget(
    ScreenUtilInit(
      child: MaterialApp(
        home: Material(
          child: PostsFilterWidget(
            filters: filters,
            onApply: () {},
            onClear: () {},
          ),
        ),
      ),
    ),
  );
}
