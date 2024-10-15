import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/core/widgets/custom_input_field.dart';
import 'package:wordpress_companion/core/widgets/failure_widget.dart';
import 'package:wordpress_companion/core/widgets/loading_widget.dart';
import 'package:wordpress_companion/features/login/login_exports.dart';

class MockAuthenticationCubit extends MockCubit<AuthenticationState>
    implements AuthenticationCubit {}

class MockLoginCredentialsCubit extends MockCubit<LoginCredentialsState>
    implements LoginCredentialsCubit {}

class FakeLoginCredentialsState extends Fake implements LoginCredentialsState {}

class FakeLoginCredentialsEntity extends Fake
    implements LoginCredentialsEntity {}

void main() {
  late AuthenticationCubit authenticationCubit;
  late LoginCredentialsCubit loginCredentialsCubit;

  const LoginCredentialsParams loginParams = (
    name: "name",
    applicationPassword: "pass",
    domain: "domain",
    rememberMe: true,
  );
  final navigatorKey = GlobalKey<NavigatorState>();
  late Widget loginScreenWidget;

  setUp(() {
    authenticationCubit = MockAuthenticationCubit();
    loginCredentialsCubit = MockLoginCredentialsCubit();

    //TODO: need to set init state of cubits
    when(
      () => authenticationCubit.state,
    ).thenAnswer((_) => const AuthenticationState.initial());
    when(
      () => loginCredentialsCubit.state,
    ).thenAnswer((_) => const LoginCredentialsState.initial());
    loginScreenWidget = ScreenUtilInit(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationCubit>(
            create: (context) => authenticationCubit,
          ),
          BlocProvider<LoginCredentialsCubit>(
            create: (context) => loginCredentialsCubit,
          ),
        ],
        child: GlobalLoaderOverlay(
          useDefaultLoading: false,
          overlayColor: Colors.transparent,
          overlayWidgetBuilder: (_) => const LoadingWidget(),
          duration: Durations.medium1,
          child: MaterialApp(
            navigatorKey: navigatorKey,
            home: const LoginScreen(),
          ),
        ),
      ),
    );
  });

  setUpAll(() {
    registerFallbackValue(loginParams);
    registerFallbackValue(NoParams());
  });

  group("Main Behaviors -", () {
    group("loginCredentialsCubit -", () {
      testWidgets(
          "should show empty Container when LoginCredentials state is initial",
          (tester) async {
        //act
        await tester.pumpWidget(loginScreenWidget);

        //assert
        expect(find.byType(Container), findsOneWidget);
      });

      testWidgets(
          "should show LoadingWidget when LoginCredentialsState is gettingCredentials ",
          (tester) async {
        //arrange
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

      testWidgets("should  when ", (tester) async {
        //arrange
        whenListen(
            loginCredentialsCubit,
            Stream.fromIterable([
              const LoginCredentialsState.gettingCredentials(),
              const LoginCredentialsState.credentialsReceived(
                LoginCredentialsEntity(
                  userName: "user",
                  applicationPassword: "pass",
                  domain: "domain",
                  rememberMe: true,
                ),
              ),
            ]));

        await tester.pumpWidget(loginScreenWidget);
        await tester.pumpAndSettle();

        //act

        //assert
        expect(find.text("user"), findsOneWidget);
        expect(find.text("pass"), findsOneWidget);
        expect(find.text("domain"), findsOneWidget);
      });
    });
  });

  group("user interaction -", () {
    group("_applicationPasswordInput -", () {
      testWidgets("should show visibility icon at the beginning ",
          (tester) async {
        //arrange

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

    group("_rememberMe -", () {
      testWidgets("should be checked when initialized", (tester) async {
        //arrange

        when(() => loginCredentialsCubit.state).thenReturn(
          LoginCredentialsState.credentialsReceived(
            FakeLoginCredentialsEntity(),
          ),
        );

        //act
        await tester.pumpWidget(loginScreenWidget);
        bool? initialCheckBoxValue = _getCheckBoxValue(tester);

        //assert
        expect(initialCheckBoxValue, true);
      });

      testWidgets("should be checked when use taped", (tester) async {
        //arrange

        when(() => loginCredentialsCubit.state).thenReturn(
          LoginCredentialsState.credentialsReceived(
            FakeLoginCredentialsEntity(),
          ),
        );

        //act
        await tester.pumpWidget(loginScreenWidget);
        bool? initialCheckBoxValue = _getCheckBoxValue(tester);

        await tester.tap(find.byType(Checkbox));
        await tester.pump();

        bool? afterTapValue = _getCheckBoxValue(tester);

        //assert
        expect(initialCheckBoxValue, true);
        expect(afterTapValue, false);
      });
    });

    group("_loginButton -", () {
      testWidgets(
          "should Not Call loginAndSave when one of the inputs is empty",
          (tester) async {
        //arrange
        when(() => loginCredentialsCubit.state).thenReturn(
          LoginCredentialsState.credentialsReceived(
            FakeLoginCredentialsEntity(),
          ),
        );
        when(() => authenticationCubit.loginAndSave(any())).thenAnswer(
          (invocation) async {},
        );

        //act
        await tester.pumpWidget(loginScreenWidget);

        await tester.enterText(find.byType(TextFormField).at(0), "user");
        await tester.enterText(find.byType(TextFormField).at(1), "pass");
        await tester.enterText(find.byType(TextFormField).at(2), "");

        await tester.ensureVisible(find.byKey(const Key('login_button')));
        await tester.tap(find.byKey(const Key("login_button")));
        await tester.pump();

        //assert
        verifyNever(() => authenticationCubit.loginAndSave(any()));
      });
      testWidgets("should call loginAndSave when inputs are valid",
          (tester) async {
        //arrange

        when(() => loginCredentialsCubit.state).thenReturn(
          LoginCredentialsState.credentialsReceived(
            FakeLoginCredentialsEntity(),
          ),
        );
        when(
          () => authenticationCubit.loginAndSave(any()),
        ).thenAnswer((invocation) async {});

        //act
        await tester.pumpWidget(loginScreenWidget);

        await _enterSomeTextToFields(tester);

        await tester.ensureVisible(find.byKey(const Key('login_button')));
        await tester.tap(find.byKey(const Key("login_button")));
        await tester.pump();

        //assert
        verify(
          () => authenticationCubit.loginAndSave(any()),
        ).called(1);
      });
    });
  });
}

Future<void> _enterSomeTextToFields(WidgetTester tester) async {
  await tester.enterText(
    find.byType(TextFormField).at(0),
    "user",
  );
  await tester.enterText(
    find.byType(TextFormField).at(1),
    "user",
  );
  await tester.enterText(
    find.byType(TextFormField).at(2),
    "user",
  );
}

bool? _getCheckBoxValue(WidgetTester tester) {
  final rememberMeCheckBox = tester.widget<Checkbox>(find.byType(Checkbox));
  final checkBoxValue = rememberMeCheckBox.value;
  return checkBoxValue;
}

IconData? _getInputSuffixIconData(WidgetTester tester, Finder inputFinder) {
  final input = tester.widget<CustomInputField>(inputFinder);
  final inputSuffixIconData =
      ((input.suffixIcon as IconButton).icon as Icon).icon;

  return inputSuffixIconData;
}
