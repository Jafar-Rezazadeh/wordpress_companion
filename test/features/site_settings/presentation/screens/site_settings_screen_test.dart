import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/site_settings/presentation/screens/site_settings_screen.dart';

void main() {
  group("on save -", () {
    group("email input -", () {
      testWidgets("should email request focus when the value of it is invalid",
          (tester) async {
        //arrange
        await tester.pumpWidget(
          const ScreenUtilInit(
            child: MaterialApp(
              home: Material(
                child: SiteSettingsScreen(),
              ),
            ),
          ),
        );

        //act
        await tester.enterText(find.byKey(const Key("email_input")), "test");
        final emailInputAfterTextEntered = tester.widget<CustomFormInputField>(
          find.byKey(const Key("email_input")),
        );
        emailInputAfterTextEntered.focusNode?.unfocus();
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key("save_site_settings_button")));
        await tester.pumpAndSettle();
        final emailInput = tester.widget<CustomFormInputField>(
          find.byKey(const Key("email_input")),
        );

        //assert
        expect(emailInput.focusNode?.hasFocus, true);
      });

      testWidgets(
          "should Not focus pn email input when when its value is valid",
          (tester) async {
        //arrange
        await tester.pumpWidget(
          const ScreenUtilInit(
            child: MaterialApp(
              home: Material(
                child: SiteSettingsScreen(),
              ),
            ),
          ),
        );

        //act
        await tester.enterText(
            find.byKey(const Key("email_input")), "test@gmail.com");
        final emailInputAfterTextEntered = tester.widget<CustomFormInputField>(
          find.byKey(const Key("email_input")),
        );
        emailInputAfterTextEntered.focusNode?.unfocus();
        await tester.pumpAndSettle();

        expect(emailInputAfterTextEntered.focusNode?.hasFocus, false);

        await tester.tap(find.byKey(const Key("save_site_settings_button")));
        await tester.pumpAndSettle();

        //assert
        final emailInputAfterSave = tester.widget<CustomFormInputField>(
          find.byKey(const Key("email_input")),
        );
        expect(emailInputAfterSave.focusNode?.hasFocus, false);
      });
    });
  });
}
