import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:wordpress_companion/core/errors/failures.dart';

import 'package:wordpress_companion/features/user-login/user_login_exports.dart';

class MockWordpressRemoteDataSource extends Mock implements WordpressRemoteDataSource {}

class MockLocalUserLoginDataSource extends Mock implements LocalUserLoginDataSource {}

class FakeAppFailure extends Fake implements AppFailure {}

void main() {
  late MockWordpressRemoteDataSource mockWordpressRemoteDataSource;
  late MockLocalUserLoginDataSource mockLocalUserLoginDataSource;
  late UserLoginRepositoryImpl userLoginRepositoryImpl;
  const UserCredentialsParams fakeParams =
      (name: "test", applicationPassword: "test1234", domain: "https://example.com");

  setUp(
    () {
      mockLocalUserLoginDataSource = MockLocalUserLoginDataSource();
      mockWordpressRemoteDataSource = MockWordpressRemoteDataSource();
      userLoginRepositoryImpl = UserLoginRepositoryImpl(
        wordpressRemoteDataSource: mockWordpressRemoteDataSource,
        localUserLoginDataSource: mockLocalUserLoginDataSource,
      );
    },
  );

  group("authenticateUser -", () {
    test(
      "should return (left(ServerFailure)) when DioException is thrown",
      () async {
        //arrange

        when(
          () => mockWordpressRemoteDataSource.authenticateUser(fakeParams),
        ).thenAnswer((invocation) async => throw DioException(requestOptions: RequestOptions()));

        //act
        final result = await userLoginRepositoryImpl.authenticateUser(fakeParams);
        final failure = result.fold((l) => l, (r) => null);

        //assert
        expect(result.isLeft(), true);
        expect(failure, isA<ServerFailure>());
      },
    );

    test(
      "should return (UnknownFailure) when any other exception is thrown",
      () async {
        //arrange
        when(
          () => mockWordpressRemoteDataSource.authenticateUser(fakeParams),
        ).thenAnswer((invocation) async => throw Exception());

        //act
        final result = await userLoginRepositoryImpl.authenticateUser(fakeParams);
        final failure = result.fold((l) => l, (r) => null);

        //assert
        expect(result.isLeft(), true);
        expect(failure, isA<UnknownFailure>());
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
        final result = await userLoginRepositoryImpl.authenticateUser(fakeParams);
        final isValidUser = result.fold((l) => null, (r) => r);

        //assert
        expect(result.isRight(), true);
        expect(isValidUser, true);
      },
    );
  });

  group("saveCredentials -", () {
    test(
      "should return (AppFailure) when any exception is thrown",
      () async {
        //arrange
        when(
          () => mockLocalUserLoginDataSource.saveCredentials(fakeParams),
        ).thenAnswer((invocation) async => throw Exception());

        //act
        final result = await userLoginRepositoryImpl.saveCredentials(fakeParams);
        final failure = result.fold((l) => l, (r) => null);

        //assert
        expect(result.isLeft(), true);
        expect(failure, isA<AppFailure>());
      },
    );
    test(
      "should return (userCredentialsEntity) when saveCredentials is successful",
      () async {
        //arrange
        when(
          () => mockLocalUserLoginDataSource.saveCredentials(fakeParams),
        ).thenAnswer(
          (invocation) async => const UserCredentialsModel(
            userName: "test",
            applicationPassword: "test1234",
            domain: "https://example.com",
          ),
        );

        //act
        final result = await userLoginRepositoryImpl.saveCredentials(fakeParams);
        final userCredentials = result.fold((l) => null, (r) => r);

        //assert
        expect(result.isRight(), true);
        expect(userCredentials, isA<UserCredentialsEntity>());
      },
    );
  });
}
