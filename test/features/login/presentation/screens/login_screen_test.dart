import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/core/widgets/custom_input_field.dart';
import 'package:wordpress_companion/core/widgets/failure_widget.dart';
import 'package:wordpress_companion/core/widgets/loading_widget.dart';
import 'package:wordpress_companion/features/login/login_exports.dart';

class MockAuthenticationCubit extends MockCubit<AuthenticationState>
    implements AuthenticationCubit {}

class MockLoginCredentialsCubit extends MockCubit<LoginCredentialsState>
    implements LoginCredentialsCubit {}

class FakeLoginCredentialsEntity extends Fake
    implements LoginCredentialsEntity {}

void main() {
  late AuthenticationCubit authenticationCubit;
  late LoginCredentialsCubit loginCredentialsCubit;

  final navigatorKey = GlobalKey<NavigatorState>();
  final loginScreenWidget = ScreenUtilInit(
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => authenticationCubit,
        ),
        BlocProvider(
          create: (context) => loginCredentialsCubit,
        ),
      ],
      child: MaterialApp(navigatorKey: navigatorKey, home: const LoginScreen()),
    ),
  );

  setUp(() {
    authenticationCubit = MockAuthenticationCubit();
    loginCredentialsCubit = MockLoginCredentialsCubit();
  });

  group("Main Behaviors -", () {
    group("loginCredentialsCubit -", () {
      testWidgets(
          "should show empty Container when LoginCredentials state is initial",
          (tester) async {
        when(
          () => loginCredentialsCubit.state,
        ).thenReturn(const LoginCredentialsState.initial());
        when(() => authenticationCubit.state)
            .thenReturn(const AuthenticationState.initial());
        //act
        await tester.pumpWidget(loginScreenWidget);

        //assert
        expect(find.byType(Container), findsOneWidget);
      });

      testWidgets(
          "should show LoadingWidget when LoginCredentialsState is gettingCredentials ",
          (tester) async {
        //arrange

        when(() => authenticationCubit.state)
            .thenReturn(const AuthenticationState.initial());
        when(
          () => loginCredentialsCubit.state,
        ).thenReturn(const LoginCredentialsState.gettingCredentials());

        //act
        await tester.pumpWidget(loginScreenWidget);

        //assert
        expect(find.byType(LoadingWidget), findsOneWidget);
      });

      testWidgets(
          "should show credentials_contents when loginCredentialsState is credentialsReceived",
          (tester) async {
        //arrange
        when(() => authenticationCubit.state)
            .thenReturn(const AuthenticationState.initial());
        when(
          () => loginCredentialsCubit.state,
        ).thenAnswer(
          (invocation) => LoginCredentialsState.credentialsReceived(
              FakeLoginCredentialsEntity()),
        );

        //act
        await tester.pumpWidget(loginScreenWidget);

        //assert
        expect(find.byKey(const Key("credentials_contents")), findsOne);
      });

      testWidgets(
          "should show FailureWidget when LoginCredentialsState is error",
          (tester) async {
        //arrange
        when(() => authenticationCubit.state)
            .thenReturn(const AuthenticationState.initial());
        when(
          () => loginCredentialsCubit.state,
        ).thenAnswer(
          (_) => LoginCredentialsState.error(
            InternalFailure(
                message: "message",
                stackTrace: StackTrace.fromString("stackTraceString")),
          ),
        );

        //act
        await tester.pumpWidget(loginScreenWidget);

        //assert
        expect(find.byType(FailureWidget), findsOneWidget);
      });
    });
  });

  group("user interaction -", () {
    group("_applicationPasswordInput -", () {
      testWidgets("should show visibility icon at the beginning ",
          (tester) async {
        //arrange
        when(() => authenticationCubit.state).thenReturn(
          const AuthenticationState.initial(),
        );
        when(
          () => loginCredentialsCubit.state,
        ).thenReturn(
          LoginCredentialsState.credentialsReceived(
            FakeLoginCredentialsEntity(),
          ),
        );

        //act
        await tester.pumpWidget(loginScreenWidget);
        final input = tester.widget<CustomInputField>(
          find.byKey(const Key("application_password")),
        );
        final inputSuffixIconData =
            ((input.suffixIcon as IconButton).icon as Icon).icon;

        //assert
        expect(inputSuffixIconData, Icons.visibility);
      });

      testWidgets("should change iconData of suffix when user tap",
          (tester) async {
        //arrange
        when(() => authenticationCubit.state).thenReturn(
          const AuthenticationState.initial(),
        );
        when(() => loginCredentialsCubit.state).thenReturn(
          LoginCredentialsState.credentialsReceived(
            FakeLoginCredentialsEntity(),
          ),
        );

        //act
        await tester.pumpWidget(loginScreenWidget);
        final inputFinder = find.byKey(const Key("application_password"));

        final inputSuffixIconDataBeforeTap =
            _getInputSuffixIconData(tester, inputFinder);

        await tester.tap(find.byType(IconButton));
        await tester.pump();

        final inputSuffixIconDataAfterTap =
            _getInputSuffixIconData(tester, inputFinder);

        // assert
        expect(inputSuffixIconDataBeforeTap, Icons.visibility);
        expect(inputSuffixIconDataAfterTap, Icons.visibility_off);
      });
    });

    group("_appPasswordHelperText", () {
      testWidgets("should show text ", (tester) async {
        //arrange
        when(() => authenticationCubit.state).thenReturn(
          const AuthenticationState.initial(),
        );
        when(() => loginCredentialsCubit.state).thenReturn(
          LoginCredentialsState.credentialsReceived(
            FakeLoginCredentialsEntity(),
          ),
        );

        //act
        await tester.pumpWidget(loginScreenWidget);

        //assert
        expect(
          find.byKey(const Key("app_password_helper_text")),
          findsOneWidget,
        );
      });

      testWidgets("should show a dialog when taped on text", (tester) async {
        //arrange
        when(() => authenticationCubit.state).thenReturn(
          const AuthenticationState.initial(),
        );
        when(() => loginCredentialsCubit.state).thenReturn(
          LoginCredentialsState.credentialsReceived(
            FakeLoginCredentialsEntity(),
          ),
        );

        //act
        await tester.pumpWidget(loginScreenWidget);
        final helperTextFinder =
            find.byKey(const Key("app_password_helper_text"));
        await tester.tap(helperTextFinder);
        await tester.pumpAndSettle();

        //assert
        expect(find.byType(Dialog), findsOneWidget);
      });
    });
  });
}

IconData? _getInputSuffixIconData(WidgetTester tester, Finder inputFinder) {
  final input = tester.widget<CustomInputField>(inputFinder);
  final inputSuffixIconData =
      ((input.suffixIcon as IconButton).icon as Icon).icon;

  return inputSuffixIconData;
}
