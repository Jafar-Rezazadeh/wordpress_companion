import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/core_export.dart';

void main() {
  group("PrefixIcon Animation -", () {
    testWidgets("should animation is NOT playing when widget initialized",
        (tester) async {
      //arrange
      await _pumpTestWidget(tester);
      await tester.pumpAndSettle();

      //act
      final animateWidget = _findAnimateWidget(tester);

      //assert
      expect(animateWidget.target, 0);
    });

    testWidgets(
        "should animation is playing when some text entered into textField",
        (tester) async {
      //arrange
      await _pumpTestWidget(tester);
      await tester.pumpAndSettle();
      //act
      await tester.enterText(find.byType(TextField), "test");
      await tester.pump(Durations.short1);

      final animateWidget = _findAnimateWidget(tester);

      //assert
      expect(animateWidget.target, 1);
    });

    testWidgets("should stop animation when prefixIcon is tapped",
        (tester) async {
      //arrange
      await _pumpTestWidget(tester);
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), "test");
      await tester.pump(Durations.short1);

      //verification
      final animateWidgetBefore = _findAnimateWidget(tester);
      expect(animateWidgetBefore.target, 1);

      //act
      await tester.tap(find.byKey(const Key("prefix_button")));
      await tester.pumpAndSettle();

      final animateWidgetAfter = _findAnimateWidget(tester);

      //assert
      expect(animateWidgetAfter.target, 0);
    });

    testWidgets("should stop animation when suffixIcon is tapped",
        (tester) async {
      //arrange
      await _pumpTestWidget(tester);
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), "test");
      await tester.pump(Durations.short1);

      //verification
      final animateWidgetBefore = _findAnimateWidget(tester);
      expect(animateWidgetBefore.target, 1);

      //act
      await tester.tap(find.byKey(const Key("suffix_button")));
      await tester.pumpAndSettle();

      final animateWidgetAfter = _findAnimateWidget(tester);

      //assert
      expect(animateWidgetAfter.target, 0);
    });

    testWidgets("should stop animation when TextField value is empty",
        (tester) async {
      //arrange
      await _pumpTestWidget(tester);
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), "test");
      await tester.pump(Durations.short1);

      //verification
      final animateWidgetBefore = _findAnimateWidget(tester);
      expect(animateWidgetBefore.target, 1);

      //act
      await tester.enterText(find.byType(TextField), "");
      await tester.pumpAndSettle();

      //assert
      final animateWidgetAfter = _findAnimateWidget(tester);
      expect(animateWidgetAfter.target, 0);
    });
  });

  group("TextField Focus -", () {
    testWidgets("should unfocus the textField when prefixIcon is tapped",
        (tester) async {
      //arrange
      await _pumpTestWidget(tester);
      await tester.pumpAndSettle();

      //verification
      await tester.enterText(find.byType(TextField), "test");
      await tester.pump(Durations.short1);

      final textFieldBefore = tester.widget<TextField>(find.byType(TextField));
      expect(textFieldBefore.focusNode?.hasFocus, true);

      //act
      await tester.tap(find.byKey(const Key("prefix_button")));
      await tester.pump();

      //assert
      final textFieldAfter = tester.widget<TextField>(find.byType(TextField));
      expect(textFieldAfter.focusNode?.hasFocus, false);
    });

    testWidgets("should unfocus the textField when suffixIcon is tapped",
        (tester) async {
      //arrange
      await _pumpTestWidget(tester);
      await tester.pumpAndSettle();

      //verification
      await tester.enterText(find.byType(TextField), "test");
      await tester.pump(Durations.short1);

      final textFieldBefore = tester.widget<TextField>(find.byType(TextField));
      expect(textFieldBefore.focusNode?.hasFocus, true);

      //act
      await tester.tap(find.byKey(const Key("suffix_button")));
      await tester.pump();

      //assert
      final textFieldAfter = tester.widget<TextField>(find.byType(TextField));
      expect(textFieldAfter.focusNode?.hasFocus, false);
    });
  });

  group("user interactions -", () {
    testWidgets(
        "should set the value of textField to onSubmit method when user tapped on prefixIcon",
        (tester) async {
      //arrange
      String? text;
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: CustomSearchInput(
              onSubmit: (value) => text = value,
              onClear: () {},
            ),
          ),
        ),
      );

      //verification
      expect(text, null);

      expect(find.byKey(const Key("prefix_button")), findsOneWidget);

      //act
      await tester.enterText(find.byType(TextField), "test");
      await tester.pump(Durations.short1);
      await tester.tap(find.byKey(const Key("prefix_button")));
      await tester.pumpAndSettle();

      //assert
      expect(text, "test");
    });

    testWidgets("should invoke the onClear when user tapped on suffixIcon",
        (tester) async {
      //arrange
      String? text;
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: CustomSearchInput(
              onSubmit: (value) {},
              onClear: () => text = "clear",
            ),
          ),
        ),
      );

      //verification
      expect(text, null);
      await tester.enterText(find.byType(TextField), "test");
      await tester.pump(Durations.short1);
      expect(find.byKey(const Key("suffix_button")), findsOneWidget);

      //act
      await tester.tap(find.byKey(const Key("suffix_button")));
      await tester.pumpAndSettle();

      //assert
      expect(text, "clear");
    });
  });
}

Future<void> _pumpTestWidget(WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Material(
        child: CustomSearchInput(
          onSubmit: (value) {},
          onClear: () {},
        ),
      ),
    ),
  );
}

Animate _findAnimateWidget(WidgetTester tester) =>
    tester.widget<Animate>(find.byType(Animate));
