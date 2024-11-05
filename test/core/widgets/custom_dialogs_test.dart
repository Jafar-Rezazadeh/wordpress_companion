import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/widgets/custom_dialogs.dart';

void main() {
  final dialogFinder = find.byKey(const Key("are_you_sure_dialog"));
  final confirmButtonFinder = find.byKey(const Key("confirm_button"));
  final cancelButtonFinder = find.byKey(const Key("cancel_button"));
  final dialogOpenerButtonFinder = find.text("press me");
  group("showAreYouSureDialog -", () {
    testWidgets("should show a dialog with values when called", (tester) async {
      //arrange
      await tester.pumpWidget(_testWidget(() {}));

      //act
      await tester.tap(find.text("press me"));
      await tester.pumpAndSettle();

      //assert
      expect(dialogFinder, findsOneWidget);
    });

    testWidgets("should invoke the onConfirm when confirm_button is tapped",
        (tester) async {
      //arrange
      bool onConfirmInvoked = false;
      onConfirm() {
        onConfirmInvoked = true;
      }

      await tester.pumpWidget(_testWidget(onConfirm));

      //verification
      await tester.tap(dialogOpenerButtonFinder);
      await tester.pumpAndSettle();
      expect(dialogFinder, findsOneWidget);

      //act
      await tester.tap(confirmButtonFinder);
      await tester.pumpAndSettle();

      //assert
      expect(onConfirmInvoked, true);
    });

    testWidgets("should close the dialog when cancelButton is tapped ",
        (tester) async {
      //arrange
      await tester.pumpWidget(_testWidget(() {}));

      //verification
      await tester.tap(dialogOpenerButtonFinder);
      await tester.pumpAndSettle();
      expect(dialogFinder, findsOneWidget);

      //act
      await tester.tap(cancelButtonFinder);
      await tester.pumpAndSettle();

      //assert
      expect(dialogFinder, findsNothing);
    });
    testWidgets("should close the dialog when confirmButton is tapped ",
        (tester) async {
      //arrange
      await tester.pumpWidget(_testWidget(() {}));

      //verification
      await tester.tap(dialogOpenerButtonFinder);
      await tester.pumpAndSettle();
      expect(dialogFinder, findsOneWidget);

      //act
      await tester.tap(confirmButtonFinder);
      await tester.pumpAndSettle();

      //assert
      expect(dialogFinder, findsNothing);
    });
  });
}

MaterialApp _testWidget(Null Function() onConfirm) {
  return MaterialApp(
    home: Scaffold(
      body: Builder(
        builder: (context) {
          return FilledButton(
            onPressed: () {
              CustomDialogs.showAreYouSureDialog(
                context: context,
                content: "content",
                title: "title",
                onConfirm: onConfirm,
              );
            },
            child: const Text("press me"),
          );
        },
      ),
    ),
  );
}
