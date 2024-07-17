import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/user-login/user_login_exports.dart';

class MockUserAuthenticationRepository extends Mock implements UserLoginRepository {}

class FakeAppFailure extends Fake implements AppFailure {}

class FakeUserCredentialsEntity extends Fake implements LoginCredentialsEntity {}

void main() {
  late SaveUserCredentials saveUserCredentials;
  late MockUserAuthenticationRepository mockUserAuthenticationRepository;
  const UserCredentialsParams fakeCredentialsParams =
      (name: "", applicationPassword: "", domain: "", rememberMe: true);

  setUp(
    () {
      mockUserAuthenticationRepository = MockUserAuthenticationRepository();
      saveUserCredentials =
          SaveUserCredentials(userLoginRepository: mockUserAuthenticationRepository);
    },
  );

  test(
    "should return (AppFailure) when saving Credentials fails",
    () async {
      //arrange
      when(
        () => mockUserAuthenticationRepository.saveCredentials(fakeCredentialsParams),
      ).thenAnswer(
        (invocation) async => left(FakeAppFailure()),
      );

      //act
      final result = await saveUserCredentials.call(fakeCredentialsParams);
      final failure = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(failure, isA<AppFailure>());
    },
  );

  test(
    "should return (UserCredentialsEntity) when saving Credentials succeeds",
    () async {
      //arrange
      when(
        () => mockUserAuthenticationRepository.saveCredentials(fakeCredentialsParams),
      ).thenAnswer((invocation) async => right(FakeUserCredentialsEntity()));

      //act
      final result = await saveUserCredentials(fakeCredentialsParams);
      final userCredentials = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(userCredentials, isA<LoginCredentialsEntity>());
    },
  );
}
