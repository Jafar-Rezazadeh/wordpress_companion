import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/profile/profile_exports.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

class FakeProfileEntity extends Fake implements ProfileEntity {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockProfileRepository mockProfileRepository;
  late GetMyProfile getMyProfile;

  setUp(() {
    mockProfileRepository = MockProfileRepository();
    getMyProfile = GetMyProfile(profileRepository: mockProfileRepository);
  });

  test("should return right(ProfileEntity) when success", () async {
    //arrange
    when(
      () => mockProfileRepository.getMyProfile(),
    ).thenAnswer((_) async => right(FakeProfileEntity()));

    //act
    final result = await getMyProfile.call(NoParams());
    final rightValue = result.fold((l) => null, (r) => r);

    //assert
    expect(result.isRight(), true);
    expect(rightValue, isA<ProfileEntity>());
  });

  test("should return left(kind of Failure) when fails", () async {
    //arrange
    when(
      () => mockProfileRepository.getMyProfile(),
    ).thenAnswer((_) async => left(FakeFailure()));

    //act
    final result = await getMyProfile.call(NoParams());
    final leftValue = result.fold((l) => l, (r) => null);

    //assert
    expect(result.isLeft(), true);
    expect(leftValue, isA<Failure>());
  });
}
