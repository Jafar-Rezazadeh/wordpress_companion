import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/core/utils/encoder.dart';
import 'package:wordpress_companion/core/utils/global_dio_headers_handler.dart';
import 'package:wordpress_companion/features/login/login_exports.dart';

class MockAuthenticateUser extends Mock implements AuthenticateUser {}

class MockSaveUserCredentials extends Mock implements SaveUserCredentials {}

class MockClearCachedCredentials extends Mock
    implements ClearCachedCredentials {}

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
  late MockClearCachedCredentials mockClearCachedCredentials;
  late AuthenticationCubit authenticationCubit;
  const LoginCredentialsParams fakeUserCredentialsParams = (
    name: "test",
    applicationPassword: "test1234",
    domain: "https://example.com",
    rememberMe: true
  );
  final GetIt getIt = GetIt.instance;

  setUpAll(() {
    registerFallbackValue(NoParams());
    registerFallbackValue(fakeUserCredentialsParams);
    getIt.registerLazySingleton(() => Dio());
  });

  setUp(
    () {
      mockAuthenticateUser = MockAuthenticateUser();
      mockSaveUserCredentials = MockSaveUserCredentials();
      mockClearCachedCredentials = MockClearCachedCredentials();
      authenticationCubit = AuthenticationCubit(
        authenticateUser: mockAuthenticateUser,
        saveUserCredentials: mockSaveUserCredentials,
        clearCachedCredentials: mockClearCachedCredentials,
        globalDioHeadersHandler: GlobalDioHeadersHandler(getItInstance: getIt),
      );
    },
  );

  test(
    "should emit (EnterCredentials) on initial state",
    () {
      //assert
      expect(
        authenticationCubit.state,
        isA<AuthenticationState>().having(
          (state) => state.whenOrNull(initial: () => true),
          "is enterCredentials init state",
          true,
        ),
      );
    },
  );
  group("loginAndSave -", () {
    blocTest<AuthenticationCubit, AuthenticationState>(
      'emits [authenticating, Authenticated] when userAuthentication is successful and user is valid',
      setUp: () {
        when(
          () => mockAuthenticateUser.call(fakeUserCredentialsParams),
        ).thenAnswer((invocation) async => right(true));
        when(
          () => mockSaveUserCredentials.call(fakeUserCredentialsParams),
        ).thenAnswer((invocation) async => right(FakeUserCredentialsEntity()));
      },
      build: () => authenticationCubit,
      act: (cubit) => cubit.loginAndSave(fakeUserCredentialsParams),
      expect: () => [
        isA<AuthenticationState>().having(
          (state) => state.whenOrNull(authenticating: () => true),
          "is authenticating state",
          true,
        ),
        isA<AuthenticationState>().having(
          (state) => state.whenOrNull(authenticated: (_) => true),
          "is Authenticated state",
          true,
        )
      ],
      verify: (_) {
        verify(() => mockSaveUserCredentials.call(any())).called(1);
      },
    );

    test("should call the clearCachedCredentials when remember me is false",
        () async {
      //arrange
      const LoginCredentialsParams params = (
        name: "test",
        applicationPassword: "test1234",
        domain: "https://example.com",
        rememberMe: false,
      );

      when(
        () => mockAuthenticateUser.call(any()),
      ).thenAnswer((invocation) async => right(true));
      when(
        () => mockClearCachedCredentials.call(any()),
      ).thenAnswer((invocation) async => right(null));

      //act
      await authenticationCubit.loginAndSave(params);

      //assert
      verify(
        () => mockClearCachedCredentials.call(any()),
      ).called(1);
    });

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
        authenticationCubit.loginAndSave(fakeUserCredentialsParams);

        //assert
        expect(
            getIt.get<Dio>().options.baseUrl, fakeUserCredentialsParams.domain);
        expect(
          getIt.get<Dio>().options.headers["Authorization"],
          CustomEncoder.base64Encode(
            name: fakeUserCredentialsParams.name,
            password: fakeUserCredentialsParams.applicationPassword,
          ),
        );
      },
    );
    blocTest<AuthenticationCubit, AuthenticationState>(
      'emits [authenticating, NotValidUser] when user IsNotValidUser',
      setUp: () {
        when(
          () => mockAuthenticateUser.call(fakeUserCredentialsParams),
        ).thenAnswer((invocation) async => right(false));
        when(
          () => mockSaveUserCredentials.call(fakeUserCredentialsParams),
        ).thenAnswer((invocation) async => right(FakeUserCredentialsEntity()));
      },
      build: () => authenticationCubit,
      act: (cubit) => cubit.loginAndSave(fakeUserCredentialsParams),
      expect: () => [
        isA<AuthenticationState>().having(
          (state) => state.whenOrNull(authenticating: () => true),
          "is authenticating state",
          true,
        ),
        isA<AuthenticationState>().having(
          (state) => state.whenOrNull(notValidUser: () => true),
          "is NotValidUser state",
          true,
        )
      ],
      verify: (_) {
        verifyNever(() => mockSaveUserCredentials.call(any()));
      },
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'emits [authenticating, authenticationFailed] when failed to login',
      setUp: () {
        when(
          () => mockAuthenticateUser.call(fakeUserCredentialsParams),
        ).thenAnswer((invocation) async => left(FakeFailure()));
      },
      build: () => authenticationCubit,
      act: (cubit) => cubit.loginAndSave(fakeUserCredentialsParams),
      expect: () => [
        isA<AuthenticationState>().having(
          (state) => state.whenOrNull(authenticating: () => true),
          "is authenticating state",
          true,
        ),
        isA<AuthenticationState>().having(
          (state) => state.whenOrNull(authenticationFailed: (_) => true),
          "is authenticationFailed state",
          true,
        )
      ],
    );
  });
}
