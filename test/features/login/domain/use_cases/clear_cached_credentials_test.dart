import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/login/login_exports.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockLoginRepository mockLoginRepository;
  late ClearCachedCredentials clearCachedCredentials;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    clearCachedCredentials =
        ClearCachedCredentials(loginRepository: mockLoginRepository);
  });

  test("should return (void) when cleaning success", () async {
    //arrange
    when(
      () => mockLoginRepository.clearCachedCredentials(),
    ).thenAnswer((invocation) async => right(null));

    //act
    final result = await clearCachedCredentials(NoParams());

    //assert
    expect(result.isRight(), true);
  });

  test("should return kind of (Failure) when fails to clear", () async {
    //arrange
    when(
      () => mockLoginRepository.clearCachedCredentials(),
    ).thenAnswer((invocation) async => left(FakeFailure()));

    //act
    final result = await clearCachedCredentials(NoParams());
    final leftValue = result.fold((l) => l, (r) => null);

    //assert
    expect(result.isLeft(), true);
    expect(leftValue, isA<Failure>());
  });
}
