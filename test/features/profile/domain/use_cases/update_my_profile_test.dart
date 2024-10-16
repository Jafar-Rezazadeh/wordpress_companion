import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/profile/domain/use_cases/update_my_profile.dart';
import 'package:wordpress_companion/features/profile/profile_exports.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

class FakeUpdateMyProfileParams extends Fake implements UpdateMyProfileParams {}

class FakeProfileEntity extends Fake implements ProfileEntity {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockProfileRepository mockProfileRepository;
  late UpdateMyProfile updateMyProfile;

  setUp(() {
    mockProfileRepository = MockProfileRepository();
    updateMyProfile = UpdateMyProfile(profileRepository: mockProfileRepository);
  });
  setUpAll(() {
    registerFallbackValue(FakeUpdateMyProfileParams());
  });

  test("should return updated profile as right(ProfileEntity) when success",
      () async {
    //arrange
    when(
      () => mockProfileRepository.updateMyProfile(any()),
    ).thenAnswer((_) async => right(FakeProfileEntity()));

    //act
    final result = await updateMyProfile(FakeUpdateMyProfileParams());
    final rightValue = result.fold((l) => null, (r) => r);

    //assert
    expect(result.isRight(), true);
    expect(rightValue, isA<ProfileEntity>());
  });

  test("should return left(kind of Failure) when fails", () async {
    //arrange
    when(
      () => mockProfileRepository.updateMyProfile(any()),
    ).thenAnswer((_) async => left(FakeFailure()));

    //act
    final result = await updateMyProfile(FakeUpdateMyProfileParams());
    final leftValue = result.fold((l) => l, (r) => null);

    //assert
    expect(result.isLeft(), true);
    expect(leftValue, isA<Failure>());
  });
}
