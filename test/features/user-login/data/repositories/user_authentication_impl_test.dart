import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/data/wordpress_remote_data_source/wordpress_remote_data_source.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/user-login/data/repositories/user_authentication_repo_impl.dart';
import 'package:wordpress_companion/features/user-login/domain/usecases/authenticate_user.dart';

class MockWordpressRemoteDataSource extends Mock implements WordpressRemoteDataSource {}

void main() {
  late UserAuthenticationRepositoryImpl userAuthenticationRepositoryImpl;
  late MockWordpressRemoteDataSource mockWordpressRemoteDataSource;
  const UserAuthenticationParams fakeParams =
      (name: "test", applicationPassword: "test1234", domain: "https://example.com");

  setUp(
    () {
      mockWordpressRemoteDataSource = MockWordpressRemoteDataSource();
      userAuthenticationRepositoryImpl = UserAuthenticationRepositoryImpl(
        wordpressRemoteDataSource: mockWordpressRemoteDataSource,
      );
    },
  );

  group(
    "authenticateUser -",
    () {
      test(
        "should return (left(ServerFailure)) when DioException is thrown",
        () async {
          //arrange

          when(
            () => mockWordpressRemoteDataSource.authenticateUser(fakeParams),
          ).thenAnswer((invocation) async => throw DioException(requestOptions: RequestOptions()));

          //act
          final result = await userAuthenticationRepositoryImpl.authenticateUser(fakeParams);
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
          final result = await userAuthenticationRepositoryImpl.authenticateUser(fakeParams);
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
          final result = await userAuthenticationRepositoryImpl.authenticateUser(fakeParams);
          final isValidUser = result.fold((l) => null, (r) => r);

          //assert
          expect(result.isRight(), true);
          expect(isValidUser, true);
        },
      );
    },
  );
}
