import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/login/login_exports.dart';

class MockUserLoginRepository extends Mock implements LoginRepository {}

class FakeUserCredentialsEntity extends Fake
    implements LoginCredentialsEntity {}

class FakeAppFailure extends Fake implements InternalFailure {}

void main() {
  late MockUserLoginRepository mockUserLoginRepository;
  late GetLastLoginCredentials getLastLoginCredentials;

  setUp(
    () {
      mockUserLoginRepository = MockUserLoginRepository();
      getLastLoginCredentials =
          GetLastLoginCredentials(userLoginRepository: mockUserLoginRepository);
    },
  );

  test(
    "should return (UserCredentialsEntity) when success to remember Credentials",
    () async {
      //arrange
      when(
        () => mockUserLoginRepository.getLastLoginCredentials(),
      ).thenAnswer((invocation) async => right(FakeUserCredentialsEntity()));

      //act
      final result = await getLastLoginCredentials.call(NoParams());
      final userCredentials = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(userCredentials, isA<LoginCredentialsEntity>());
    },
  );

  test(
    "should return (AppFailure) when failed to remember Credentials",
    () async {
      //arrange
      when(
        () => mockUserLoginRepository.getLastLoginCredentials(),
      ).thenAnswer((invocation) async => left(FakeAppFailure()));

      //act
      final result = await getLastLoginCredentials.call(NoParams());
      final failure = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(failure, isA<InternalFailure>());
    },
  );
}
