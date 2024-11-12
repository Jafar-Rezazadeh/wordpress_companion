import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/core/widgets/custom_bottom_sheet.dart';

void main() {
  group("showFailureBottomSheet", () {
    testWidgets("should show a failure_bottom_sheet when called",
        (tester) async {
      //arrange
      await tester.pumpWidget(
        ScreenUtilInit(
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return FilledButton(
                    onPressed: () {
                      CustomBottomSheets.showFailureBottomSheet(
                        context: context,
                        failure: InternalFailure(
                          message: "message",
                          stackTrace: StackTrace.fromString("stackTraceString"),
                        ),
                      );
                    },
                    child: const Text("test"),
                  );
                },
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      //act
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      //assert
      expect(find.byKey(const Key("failure_bottom_sheet")), findsOneWidget);
    });
  });

  group("showFilterBottomSheet -", () {
    testWidgets("should show a filter_bottom_sheet when called",
        (tester) async {
      //arrange
      await tester.pumpWidget(
        _TestFilterBottomSheet(
          onApply: () {},
          onClear: () {},
        ),
      );

      //act
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      //assert
      expect(find.byKey(const Key("filter_bottom_sheet")), findsOneWidget);
    });

    testWidgets(
        "should invoke the onApply method when user tapped on applyFilter button",
        (tester) async {
      //arrange
      bool invoked = false;
      onApply() {
        invoked = true;
      }

      await tester.pumpWidget(
        _TestFilterBottomSheet(onApply: onApply, onClear: () {}),
      );

      //verification
      await tester.tap(find.byKey(const Key("show_filter_bottom_sheet")));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key("apply_filter_button")), findsOneWidget);

      //act
      await tester.tap(find.byKey(const Key("apply_filter_button")));
      await tester.pumpAndSettle();

      //assert
      expect(invoked, true);
    });

    testWidgets(
        "should invoke the onClear method when user tapped on clearFilter button",
        (tester) async {
      //arrange
      bool invoked = false;
      onClear() {
        invoked = true;
      }

      await tester.pumpWidget(
        _TestFilterBottomSheet(onApply: () {}, onClear: onClear),
      );

      //verification
      await tester.tap(find.byKey(const Key("show_filter_bottom_sheet")));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key("clear_filter_button")), findsOneWidget);

      //act
      await tester.tap(find.byKey(const Key("clear_filter_button")));
      await tester.pumpAndSettle();

      //assert
      expect(invoked, true);
    });

    testWidgets("should pop the filter_bottom_sheet when onApply invoked",
        (tester) async {
      //arrange
      await tester.pumpWidget(
        _TestFilterBottomSheet(
          onApply: () {},
          onClear: () {},
        ),
      );

      //verification
      await tester.tap(find.byKey(const Key("show_filter_bottom_sheet")));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key("filter_bottom_sheet")), findsOneWidget);
      expect(find.byKey(const Key("apply_filter_button")), findsOneWidget);

      //act
      await tester.tap(find.byKey(const Key("apply_filter_button")));
      await tester.pumpAndSettle();

      //assert
      expect(find.byKey(const Key("filter_bottom_sheet")), findsNothing);
    });

    testWidgets("should pop the filter_bottom_sheet when onClear invoked",
        (tester) async {
      //arrange
      await tester.pumpWidget(
        _TestFilterBottomSheet(
          onApply: () {},
          onClear: () {},
        ),
      );

      //verification
      await tester.tap(find.byKey(const Key("show_filter_bottom_sheet")));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key("filter_bottom_sheet")), findsOneWidget);
      expect(find.byKey(const Key("clear_filter_button")), findsOneWidget);

      //act
      await tester.tap(find.byKey(const Key("clear_filter_button")));
      await tester.pumpAndSettle();

      //assert
      expect(find.byKey(const Key("filter_bottom_sheet")), findsNothing);
    });
  });
}

class _TestFilterBottomSheet extends StatelessWidget {
  final Function() onApply;
  final Function() onClear;

  const _TestFilterBottomSheet({
    required this.onApply,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return FilledButton(
                key: const Key("show_filter_bottom_sheet"),
                onPressed: () {
                  CustomBottomSheets.showFilterBottomSheet(
                    context: context,
                    onApply: onApply,
                    onClear: onClear,
                    children: const [],
                  );
                },
                child: const Text("test"),
              );
            },
          ),
        ),
      ),
    );
  }
}
