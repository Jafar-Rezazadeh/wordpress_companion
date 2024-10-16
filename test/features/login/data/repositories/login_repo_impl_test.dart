import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/dependency_injection.dart';

import 'package:wordpress_companion/features/login/login_exports.dart';

class MockWordpressRemoteDataSource extends Mock
    implements WordpressRemoteDataSource {}

class MockLocalLoginDataSource extends Mock implements LocalLoginDataSource {}

class FakeAppFailure extends Fake implements InternalFailure {}

class FakeUserCredentialsModel extends Fake implements LoginCredentialsModel {
  @override
  String get applicationPassword => "test1234";

  @override
  String get domain => "https://example.com";

  @override
  String get userName => "test";
}

void main() {
  late MockWordpressRemoteDataSource mockWordpressRemoteDataSource;
  late MockLocalLoginDataSource mockLocalLoginDataSource;
  late UserLoginRepositoryImpl loginRepositoryImpl;
  const LoginCredentialsParams fakeParams = (
    name: "test",
    applicationPassword: "test1234",
    domain: "https://example.com",
    rememberMe: true
  );

  setUp(
    () {
      mockLocalLoginDataSource = MockLocalLoginDataSource();
      mockWordpressRemoteDataSource = MockWordpressRemoteDataSource();
      loginRepositoryImpl = UserLoginRepositoryImpl(
        wordpressRemoteDataSource: mockWordpressRemoteDataSource,
        localUserLoginDataSource: mockLocalLoginDataSource,
      );
    },
  );

  setUpAll(() {
    getIt.registerLazySingleton(() => Dio());
  });

  group("authenticateUser -", () {
    test(
      "should return (left(ServerFailure)) when DioException is thrown",
      () async {
        //arrange

        when(
          () => mockWordpressRemoteDataSource.authenticateUser(fakeParams),
        ).thenAnswer((invocation) async =>
            throw DioException(requestOptions: RequestOptions()));

        //act
        final result = await loginRepositoryImpl.authenticateUser(fakeParams);
        final failure = result.fold((l) => l, (r) => null);

        //assert
        expect(result.isLeft(), true);
        expect(failure, isA<ServerFailure>());
      },
    );

    test(
      "should return (InternalFailure) when any other exception is thrown",
      () async {
        //arrange
        when(
          () => mockWordpressRemoteDataSource.authenticateUser(fakeParams),
        ).thenAnswer((invocation) async => throw Exception());

        //act
        final result = await loginRepositoryImpl.authenticateUser(fakeParams);
        final failure = result.fold((l) => l, (r) => null);

        //assert
        expect(result.isLeft(), true);
        expect(failure, isA<InternalFailure>());
      },
    );

    test(
      "should return (true) when authentication success",
      () async {
        //arrange
        when(
          () => mockWordpressRemoteDataSource.authenticateUser(fakeParams),
        ).thenAnswer((invocation) async => true);

        //act
        final result = await loginRepositoryImpl.authenticateUser(fakeParams);
        final isValidUser = result.fold((l) => null, (r) => r);

        //assert
        expect(result.isRight(), true);
        expect(isValidUser, true);
      },
    );
  });

  group("saveCredentials -", () {
    test(
      "should return (InternalFailure) when any exception is thrown",
      () async {
        //arrange
        when(
          () => mockLocalLoginDataSource.saveCredentials(fakeParams),
        ).thenAnswer((invocation) async => throw Exception());

        //act
        final result = await loginRepositoryImpl.saveCredentials(fakeParams);
        final failure = result.fold((l) => l, (r) => null);

        //assert
        expect(result.isLeft(), true);
        expect(failure, isA<InternalFailure>());
      },
    );
    test(
      "should return (userCredentialsEntity) when saveCredentials is successful",
      () async {
        //arrange
        when(
          () => mockLocalLoginDataSource.saveCredentials(fakeParams),
        ).thenAnswer(
          (invocation) async => const LoginCredentialsModel(
            userName: "test",
            applicationPassword: "test1234",
            domain: "https://example.com",
            rememberMe: true,
          ),
        );

        //act
        final result = await loginRepositoryImpl.saveCredentials(fakeParams);
        final userCredentials = result.fold((l) => null, (r) => r);

        //assert
        expect(result.isRight(), true);
        expect(userCredentials, isA<LoginCredentialsEntity>());
      },
    );
  });

  group("getLastLoginCredentials -", () {
    test(
      "should return (UserCredentialsEntity) when getLastLoginCredentials is successful",
      () async {
        //arrange
        when(
          () => mockLocalLoginDataSource.getLastCredentials(),
        ).thenAnswer((invocation) async => FakeUserCredentialsModel());

        //act
        final result = await loginRepositoryImpl.getLastLoginCredentials();
        final userCredentials = result.fold((l) => null, (r) => r);

        //assert
        expect(result.isRight(), true);
        expect(userCredentials, isA<LoginCredentialsEntity>());
      },
    );

    test(
      "should return (AppFailure) when any exception is thrown",
      () async {
        //arrange
        when(
          () => mockLocalLoginDataSource.getLastCredentials(),
        ).thenAnswer((invocation) => throw Exception());

        //act
        final result = await loginRepositoryImpl.getLastLoginCredentials();
        final failure = result.fold((l) => l, (r) => null);

        //assert
        expect(result.isLeft(), true);
        expect(failure, isA<InternalFailure>());
      },
    );
  });

  group("clearCachedCredentials -", () {
    test("should return (void) when success to clear", () async {
      //arrange
      when(
        () => mockLocalLoginDataSource.clearCachedCredentials(),
      ).thenAnswer((invocation) async {});

      //act
      final result = await loginRepositoryImpl.clearCachedCredentials();

      //assert
      expect(result.isRight(), true);
    });

    test("should return (InternalFailure) when any exception is thrown",
        () async {
      //arrange
      when(
        () => mockLocalLoginDataSource.clearCachedCredentials(),
      ).thenThrow(Exception());

      //act
      final result = await loginRepositoryImpl.clearCachedCredentials();
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<Failure>());
    });
  });
}
