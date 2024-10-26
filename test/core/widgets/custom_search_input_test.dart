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

  group("onChanged (TextField) -", () {
    testWidgets(
        "should set the value of text to onChanged method when user interact with TextField",
        (tester) async {
      //arrange
      String? text;
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: CustomSearchInput(
              onChanged: (value) => text = value,
            ),
          ),
        ),
      );

      //verification
      expect(text, null);

      //act
      await tester.enterText(find.byType(TextField), "test");

      //assert
      expect(text, "test");
    });
  });
}

Future<void> _pumpTestWidget(WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Material(
        child: CustomSearchInput(
          onChanged: (value) {},
        ),
      ),
    ),
  );
}

Animate _findAnimateWidget(WidgetTester tester) =>
    tester.widget<Animate>(find.byType(Animate));
