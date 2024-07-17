import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/constants/constants.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/core/utils/injected_dio_options_handler.dart';
import 'package:wordpress_companion/features/user-login/user_login_exports.dart';

class MockAuthenticateUser extends Mock implements AuthenticateUser {}

class MockSaveUserCredentials extends Mock implements SaveUserCredentials {}

class MockGetLastLoginCredentials extends Mock implements GetLastLoginCredentials {}

class FakeFailure extends Fake implements Failure {
  @override
  String get message => "error message";
}

class FakeUserCredentialsEntity extends Fake implements LoginCredentialsEntity {
  @override
  String get userName => "test";

  @override
  String get applicationPassword => "test1234";

  @override
  String get domain => "https://example.com";
}

void main() {
  late MockAuthenticateUser mockAuthenticateUser;
  late MockSaveUserCredentials mockSaveUserCredentials;
  late MockGetLastLoginCredentials mockGetLastLoginCredentials;
  late LoginCubit loginCubit;
  const LoginCredentialsParams fakeUserCredentialsParams = (
    name: "test",
    applicationPassword: "test1234",
    domain: "https://example.com",
    rememberMe: true
  );
  final GetIt getIt = GetIt.instance;

  setUpAll(() {
    registerFallbackValue(NoParams());
    getIt.registerLazySingleton(() => Dio());
  });

  setUp(
    () {
      mockAuthenticateUser = MockAuthenticateUser();
      mockSaveUserCredentials = MockSaveUserCredentials();
      mockGetLastLoginCredentials = MockGetLastLoginCredentials();
      loginCubit = LoginCubit(
        authenticateUser: mockAuthenticateUser,
        saveUserCredentials: mockSaveUserCredentials,
        getLastLoginCredentials: mockGetLastLoginCredentials,
        injectedDioOptionsHandler: InjectedDioOptionsHandler(getItInstance: getIt),
      );
    },
  );

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
  group(
    "login -",
    () {
      blocTest<LoginCubit, LoginState>(
        'emits [loggingIn, loginSuccess] when userAuthentication is successful and user is valid',
        setUp: () {
          when(
            () => mockAuthenticateUser.call(fakeUserCredentialsParams),
          ).thenAnswer((invocation) async => right(true));
          when(
            () => mockSaveUserCredentials.call(fakeUserCredentialsParams),
          ).thenAnswer((invocation) async => right(FakeUserCredentialsEntity()));
        },
        build: () => loginCubit,
        act: (cubit) => cubit.loginAndSave(fakeUserCredentialsParams),
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

      test(
        "should set (injected dio options by getIt) when userAuthentication is successful and user is valid",
        () {
          //arrange
          when(
            () => mockAuthenticateUser.call(fakeUserCredentialsParams),
          ).thenAnswer((invocation) async => right(true));
          when(
            () => mockSaveUserCredentials.call(fakeUserCredentialsParams),
          ).thenAnswer((invocation) async => right(FakeUserCredentialsEntity()));

          //act
          loginCubit.loginAndSave(fakeUserCredentialsParams);

          //assert
          expect(getIt.get<Dio>().options.baseUrl, fakeUserCredentialsParams.domain);
          expect(
            getIt.get<Dio>().options.headers["Authorization"],
            makeBase64Encode(
              name: fakeUserCredentialsParams.name,
              password: fakeUserCredentialsParams.applicationPassword,
            ),
          );
        },
      );
      blocTest<LoginCubit, LoginState>(
        'emits [loggingIn, NotValidUser] when user IsNotValidUser',
        setUp: () {
          when(
            () => mockAuthenticateUser.call(fakeUserCredentialsParams),
          ).thenAnswer((invocation) async => right(false));
          when(
            () => mockSaveUserCredentials.call(fakeUserCredentialsParams),
          ).thenAnswer((invocation) async => right(FakeUserCredentialsEntity()));
        },
        build: () => loginCubit,
        act: (cubit) => cubit.loginAndSave(fakeUserCredentialsParams),
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
            () => mockAuthenticateUser.call(fakeUserCredentialsParams),
          ).thenAnswer((invocation) async => left(FakeFailure()));
        },
        build: () => loginCubit,
        act: (cubit) => cubit.loginAndSave(fakeUserCredentialsParams),
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

  group("getLastLoginCredentials -", () {
    test(
      "should return (UserCredentialsEntity) when success",
      () async {
        //arrange
        when(
          () => mockGetLastLoginCredentials.call(any()),
        ).thenAnswer(
          (invocation) async => right(FakeUserCredentialsEntity()),
        );

        //act
        final result = await loginCubit.getLastLoginCredentials();

        //assert
        expect(result, isA<LoginCredentialsEntity>());
      },
    );

    test(
      "should set (injected dio options by getIt) when success",
      () {
        //arrange
        when(
          () => mockGetLastLoginCredentials.call(any()),
        ).thenAnswer((invocation) async => right(FakeUserCredentialsEntity()));

        //act
        loginCubit.getLastLoginCredentials();

        //assert
        expect(getIt.get<Dio>().options.baseUrl, FakeUserCredentialsEntity().domain);
        expect(
          getIt.get<Dio>().options.headers["Authorization"],
          makeBase64Encode(
            name: FakeUserCredentialsEntity().userName,
            password: FakeUserCredentialsEntity().applicationPassword,
          ),
        );
      },
    );

    test(
      "should return (null) when failed to get last login credentials",
      () async {
        //arrange
        when(
          () => mockGetLastLoginCredentials.call(any()),
        ).thenAnswer((invocation) async => left(FakeFailure()));

        //act
        final result = await loginCubit.getLastLoginCredentials();

        //assert
        expect(result, null);
      },
    );
  });
}
