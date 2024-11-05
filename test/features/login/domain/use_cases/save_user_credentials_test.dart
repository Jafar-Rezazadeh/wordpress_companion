import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/login/login_exports.dart';

class MockUserAuthenticationRepository extends Mock
    implements LoginRepository {}

class FakeAppFailure extends Fake implements InternalFailure {}

class FakeUserCredentialsEntity extends Fake
    implements LoginCredentialsEntity {}

void main() {
  late SaveUserCredentials saveUserCredentials;
  late MockUserAuthenticationRepository mockUserAuthenticationRepository;
  const LoginCredentialsParams fakeCredentialsParams =
      (name: "", applicationPassword: "", domain: "", rememberMe: true);

  setUp(
    () {
      mockUserAuthenticationRepository = MockUserAuthenticationRepository();
      saveUserCredentials = SaveUserCredentials(
          loginRepository: mockUserAuthenticationRepository);
    },
  );

  test(
    "should return (AppFailure) when saving Credentials fails",
    () async {
      //arrange
      when(
        () => mockUserAuthenticationRepository
            .saveCredentials(fakeCredentialsParams),
      ).thenAnswer(
        (invocation) async => left(FakeAppFailure()),
      );

      //act
      final result = await saveUserCredentials.call(fakeCredentialsParams);
      final failure = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(failure, isA<InternalFailure>());
    },
  );

  test(
    "should return (UserCredentialsEntity) when saving Credentials succeeds",
    () async {
      //arrange
      when(
        () => mockUserAuthenticationRepository
            .saveCredentials(fakeCredentialsParams),
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
