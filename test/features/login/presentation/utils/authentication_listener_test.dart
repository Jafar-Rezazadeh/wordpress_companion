import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/login/login_exports.dart';

void main() {
  group("when -", () {
    testWidgets("should do nothing when state is initial", (tester) async {
      //arrange
      await tester.pumpWidget(
        MaterialApp(home: _testWidget(const AuthenticationState.initial())),
      );

      //act
      final dummyElement = _getDummyElement(tester);

      //assert
      expect(dummyElement.loaderOverlay.visible, false);
    });

    testWidgets(
        "should unfocus the scope and show the loaderOverlay when state is authenticating",
        (tester) async {
      //arrange
      await tester.pumpWidget(
        MaterialApp(
            home: _testWidget(const AuthenticationState.authenticating())),
      );

      //act
      final dummyElement = _getDummyElement(tester);
      final focusNode = FocusScope.of(dummyElement).focusedChild;

      //assert
      expect(focusNode, isNull);
      expect(dummyElement.loaderOverlay.visible, true);
      expect(find.byType(FailureWidget), findsNothing);
    });

    testWidgets(
        "should hide the loaderOverlay and show a bottom sheet when authenticationState is failed",
        (tester) async {
      //arrange
      await tester.pumpWidget(
        MaterialApp(
          home: _testWidget(
            AuthenticationState.authenticationFailed(
              InternalFailure(
                  message: "message", stackTrace: StackTrace.current),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      //act
      final dummyElement = _getDummyElement(tester);

      //assert
      expect(dummyElement.loaderOverlay.visible, false);
      expect(find.byType(FailureWidget), findsOneWidget);
    });

    testWidgets(
        "should (hide the loaderOverlay) and (goNamed route mainScree) when state is authenticated",
        (tester) async {
      //arrange
      final state = AuthenticationState.authenticated(
        const LoginCredentialsEntity(
          userName: "name",
          applicationPassword: "pass",
          domain: "domain",
          rememberMe: true,
        ),
      );

      await tester.pumpWidget(
        GetMaterialApp(
          getPages: [
            GetPage(
              name: mainScreenRoute,
              page: () => Container(key: const Key("main_screen")),
            )
          ],
          home: _testWidget(state),
        ),
      );
      await tester.pumpAndSettle();

      //act
      final dummyElement = tester.element(find.byKey(const Key("main_screen")));

      //assert
      expect(dummyElement.loaderOverlay.visible, false);
      expect(find.byKey(const Key("main_screen")), findsOneWidget);
      expect(find.byKey(const Key("dummy_element")), findsNothing);
    });

    testWidgets(
        "should (hide the loaderOverlay) and (show A snackBar) when state is notValidUser",
        (tester) async {
      //arrange
      await tester.pumpWidget(
        MaterialApp(
          home: _testWidget(const AuthenticationState.notValidUser()),
        ),
      );
      await tester.pumpAndSettle();

      //act
      final dummyElement = _getDummyElement(tester);

      //assert
      expect(dummyElement.loaderOverlay.visible, false);
      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}

Element _getDummyElement(WidgetTester tester) =>
    tester.element(find.byKey(const Key("dummy_element")));

Widget _testWidget(AuthenticationState state) {
  return ScreenUtilInit(
    child: LoaderOverlay(
      child: Scaffold(
        body: Builder(
          builder: (context) {
            AuthenticationStateListener(
              context: context,
              state: state,
            ).when();

            return Container(
              key: const Key("dummy_element"),
            );
          },
        ),
      ),
    ),
  );
}
