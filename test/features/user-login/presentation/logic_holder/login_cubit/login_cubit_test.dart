import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/user-login/user_login_exports.dart';

class MockAuthenticateUser extends Mock implements AuthenticateUser {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late LoginCubit loginCubit;
  late MockAuthenticateUser mockAuthenticateUser;
  const UserCredentialsParams fakeAuthenticationParams =
      (name: "test", applicationPassword: "test1234", domain: "https://example.com");

  setUp(
    () {
      mockAuthenticateUser = MockAuthenticateUser();
      loginCubit = LoginCubit(authenticateUser: mockAuthenticateUser);
    },
  );
  group(
    "login -",
    () {
      test(
        "should emit (EnterCredentials) on initial state",
        () {
          //assert
          expect(
            loginCubit.state,
            isA<LoginState>().having(
              (state) => state.whenOrNull(initial: () => true),
              "is enterCredentials init state",
              true,
            ),
          );
        },
      );

      blocTest<LoginCubit, LoginState>(
        'emits [loggingIn, loginSuccess] when userAuthentication is successful and user is valid',
        setUp: () {
          when(
            () => mockAuthenticateUser.call(fakeAuthenticationParams),
          ).thenAnswer((invocation) async => right(true));
        },
        build: () => loginCubit,
        act: (cubit) => cubit.login(fakeAuthenticationParams),
        expect: () => [
          isA<LoginState>().having(
            (state) => state.whenOrNull(loggingIn: () => true),
            "is loggingIn state",
            true,
          ),
          isA<LoginState>().having(
            (state) => state.whenOrNull(loginSuccess: () => true),
            "is loginSuccess state",
            true,
          )
        ],
      );

      blocTest<LoginCubit, LoginState>(
        'emits [loggingIn, NotValidUser] when user IsNotValidUser',
        setUp: () {
          when(
            () => mockAuthenticateUser.call(fakeAuthenticationParams),
          ).thenAnswer((invocation) async => right(false));
        },
        build: () => loginCubit,
        act: (cubit) => cubit.login(fakeAuthenticationParams),
        expect: () => [
          isA<LoginState>().having(
            (state) => state.whenOrNull(loggingIn: () => true),
            "is LoggingIn state",
            true,
          ),
          isA<LoginState>().having(
            (state) => state.whenOrNull(notValidUser: () => true),
            "is NotValidUser state",
            true,
          )
        ],
      );

      blocTest<LoginCubit, LoginState>(
        'emits [loggingIn, loginFailed] when failed to login',
        setUp: () {
          when(
            () => mockAuthenticateUser.call(fakeAuthenticationParams),
          ).thenAnswer((invocation) async => left(FakeFailure()));
        },
        build: () => loginCubit,
        act: (cubit) => cubit.login(fakeAuthenticationParams),
        expect: () => [
          isA<LoginState>().having(
            (state) => state.whenOrNull(loggingIn: () => true),
            "is LoggingIn state",
            true,
          ),
          isA<LoginState>().having(
            (state) => state.whenOrNull(loginFailed: (_) => true),
            "is LoginFailed state",
            true,
          )
        ],
      );
    },
  );
}
