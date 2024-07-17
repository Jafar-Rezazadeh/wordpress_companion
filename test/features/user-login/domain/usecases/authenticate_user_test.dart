import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/user-login/domain/repositories/user_login_repo.dart';
import 'package:wordpress_companion/features/user-login/domain/usecases/authenticate_user.dart';

class MockUserAuthentication extends Mock implements UserLoginRepository {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late AuthenticateUser authenticateUser;
  late MockUserAuthentication mockUserAuthentication;

  const LoginCredentialsParams fakeUserParams = (
    name: "test",
    applicationPassword: "test1234",
    domain: "https://example.com",
    rememberMe: true
  );

  setUp(
    () {
      mockUserAuthentication = MockUserAuthentication();
      authenticateUser = AuthenticateUser(userLoginRepository: mockUserAuthentication);
    },
  );

  test(
    "should return (true) when authentication is successful",
    () async {
      //arrange
      when(
        () => mockUserAuthentication.authenticateUser(fakeUserParams),
      ).thenAnswer((invocation) async => right(true));

      //act
      final result = await authenticateUser.call(fakeUserParams);
      final isValidUser = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(isValidUser, true);
    },
  );

  test(
    "should return (failure) when authentication fails",
    () async {
      //arrange
      when(
        () => mockUserAuthentication.authenticateUser(fakeUserParams),
      ).thenAnswer(
        (invocation) async => left(FakeFailure()),
      );

      //act
      final result = await authenticateUser.call(fakeUserParams);
      final failure = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(failure, isA<Failure>());
    },
  );
}
