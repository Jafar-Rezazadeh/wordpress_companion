import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/media/presentation/widgets/media_filter_button.dart';

void main() {
  const applyFilterKey = Key("apply_filter_button");
  const clearFilterKey = Key("clear_filter_button");
  const afterDateSelector = Key("after_date_selector");
  const beforeDateSelector = Key("before_date_selector");

  testWidgets("should show filter_bottom_sheet when user tapped",
      (tester) async {
    //arrange
    onApply(MediaFilters filters) {}
    onClear() {}
    await tester.pumpWidget(_testWidget(onApply, onClear));

    //verification
    expect(find.byType(FilterButton), findsOneWidget);

    //act
    await tester.tap(find.byType(FilterButton));
    await tester.pumpAndSettle();

    //assert
    expect(find.byKey(const Key("filter_bottom_sheet")), findsOneWidget);
  });

  testWidgets("should invoke onApply when apply button is tapped",
      (tester) async {
    //arrange
    bool applyInvoked = false;
    onApply(MediaFilters filters) {
      applyInvoked = true;
    }

    onClear() {}
    await tester.pumpWidget(_testWidget(onApply, onClear));

    //act
    await tester.tap(find.byType(FilterButton));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(applyFilterKey));
    await tester.pumpAndSettle();

    //assert
    expect(applyInvoked, true);
  });

  testWidgets("should invoke the clear_filter_button when user tapped on clear",
      (tester) async {
    //arrange
    bool clearInvoked = false;
    onApply(MediaFilters filters) {}
    onClear() {
      clearInvoked = true;
    }

    await tester.pumpWidget(_testWidget(onApply, onClear));

    //act
    await _tapFilterButton(tester);

    await tester.tap(find.byKey(clearFilterKey));
    await tester.pumpAndSettle();

    //assert
    expect(clearInvoked, true);
  });

  group("TypeFilterWidget -", () {
    testWidgets("should set the value to filters when use selects one type",
        (tester) async {
      //arrange
      MediaFilters? selectedFilters;
      await tester.pumpWidget(
        _testWidget(
          (value) {
            selectedFilters = value;
          },
          () {},
        ),
      );

      //act
      await _tapFilterButton(tester);
      await _selectMediaType(tester, MediaType.image);
      await tester.tap(find.byKey(applyFilterKey));

      //assert
      expect(selectedFilters?.type, MediaType.image);
    });
  });

  group("_dateFilterWidget -", () {
    testWidgets("should set the value to filters when user selects dates",
        (tester) async {
      //arrange
      MediaFilters? selectedFilters;
      await tester.pumpWidget(
        _testWidget(
          (value) {
            selectedFilters = value;
          },
          () {},
        ),
      );
      final afterDateSelectorFinder = find.byKey(afterDateSelector);
      final beforeDateSelectorFinder = find.byKey(beforeDateSelector);

      // verification
      await _tapFilterButton(tester);
      await tester.tap(find.byType(ExpansionTile));
      await tester.pumpAndSettle();

      expect(afterDateSelectorFinder, findsOneWidget);
      expect(beforeDateSelectorFinder, findsOneWidget);

      //act
      await _selectDates(
        tester,
        afterDateSelectorFinder,
        beforeDateSelectorFinder,
      );

      await tester.tap(find.byKey(applyFilterKey));
      await tester.pumpAndSettle();

      //assert
      expect(selectedFilters?.after, isNot(null));
      expect(selectedFilters?.before, isNot(null));
    });
  });
}

Future<void> _selectDates(WidgetTester tester, Finder afterDateSelectorFinder,
    Finder beforeDateSelectorFinder) async {
  final afterDate =
      tester.widget<CustomPersianDateSelector>(afterDateSelectorFinder);

  afterDate.onSelected(DateTime(2020, 1, 1));
  await tester.pumpAndSettle();

  final beforeDate =
      tester.widget<CustomPersianDateSelector>(beforeDateSelectorFinder);

  beforeDate.onSelected(DateTime(2020, 1, 5));
}

Future<void> _selectMediaType(WidgetTester tester, MediaType mediaType) async {
  final customDropDownButtonFinder =
      find.byType(CustomDropDownButton<MediaType>);
  expect(customDropDownButtonFinder, findsOneWidget);
  final customDropDownButton = tester.widget<CustomDropDownButton<MediaType>>(
    customDropDownButtonFinder,
  );
  customDropDownButton.onChanged(mediaType);
  await tester.pumpAndSettle();
}

Future<void> _tapFilterButton(WidgetTester tester) async {
  await tester.tap(find.byType(FilterButton));
  await tester.pumpAndSettle();
}

ScreenUtilInit _testWidget(
    Null Function(MediaFilters filters) onApply, Null Function() onClear) {
  return ScreenUtilInit(
    child: MaterialApp(
      home: Material(
        child: MediaFilterButton(
          onApply: onApply,
          onClear: onClear,
        ),
      ),
    ),
  );
}
