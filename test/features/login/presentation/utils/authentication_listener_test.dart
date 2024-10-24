import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/core/router/go_router_config.dart';
import 'package:wordpress_companion/features/login/login_exports.dart';

void main() {
  group("when -", () {
    testWidgets("should do nothing when state is initial", (tester) async {
      //arrange
      await tester.pumpWidget(
        _makeTestWidget(
          const AuthenticationState.initial(),
        ),
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
        _makeTestWidget(
          const AuthenticationState.authenticating(),
        ),
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
        _makeTestWidget(
          AuthenticationState.authenticationFailed(
            InternalFailure(message: "message", stackTrace: StackTrace.current),
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
        "should (hide the loaderOverlay) and (goNamed route mainScree) and (show an snack bar) when state is authenticated",
        (tester) async {
      //arrange
      await tester.pumpWidget(
        _makeTestWidget(
          AuthenticationState.authenticated(
            const LoginCredentialsEntity(
                userName: "name",
                applicationPassword: "pass",
                domain: "domain",
                rememberMe: true),
          ),
        ),
      );
      await tester.pumpAndSettle();

      //act
      final dummyElement = tester.element(find.byKey(const Key("main_screen")));

      //assert
      expect(dummyElement.loaderOverlay.visible, false);
      expect(find.byKey(const Key("main_screen")), findsOneWidget);
      expect(find.byKey(const Key("dummy_element")), findsNothing);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets(
        "should (hide the loaderOverlay) and (show A snackBar) when state is notValidUser",
        (tester) async {
      //arrange
      await tester.pumpWidget(
        _makeTestWidget(const AuthenticationState.notValidUser()),
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

Widget _makeTestWidget(AuthenticationState state) {
  return MaterialApp.router(
    routerConfig: GoRouter(
      initialLocation: "/login",
      routes: [
        GoRoute(
          path: "/login",
          name: "/login",
          builder: (context, _) {
            return _loginScreenSimulation(state);
          },
        ),
        GoRoute(
          path: mainScreenRoute,
          name: mainScreenRoute,
          builder: (context, state) => Scaffold(
            body: Container(
              key: const Key("main_screen"),
            ),
          ),
        )
      ],
    ),
  );
}

LoaderOverlay _loginScreenSimulation(AuthenticationState state) {
  return LoaderOverlay(
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
  );
}
