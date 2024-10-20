import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/entities/profile_avatar.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/profile/profile_exports.dart';

class MockGetMyProfile extends Mock implements GetMyProfile {}

class DummyProfileEntity extends Fake implements ProfileEntity {
  @override
  ProfileAvatarUrlsEntity get avatarUrls => const ProfileAvatarUrlsModel(
        size24px: "size24px",
        size48px: "size48px",
        size96px: "size96px",
      );
}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockGetMyProfile mockGetMyProfile;
  late ProfileServiceImpl profileServiceImpl;

  setUpAll(() {
    registerFallbackValue(NoParams());
  });

  setUp(() {
    mockGetMyProfile = MockGetMyProfile();
    profileServiceImpl = ProfileServiceImpl(getMyProfile: mockGetMyProfile);
  });

  group("getProfileAvatar -", () {
    test("should return (ProfileAvatar) when success to get data", () async {
      //arrange
      when(
        () => mockGetMyProfile.call(any()),
      ).thenAnswer((_) async => right(DummyProfileEntity()));

      //act
      final result = await profileServiceImpl.getProfileAvatar();
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), isTrue);
      expect(rightValue, isA<ProfileAvatar>());
      expect(rightValue?.size24px, DummyProfileEntity().avatarUrls.size24px);
      expect(rightValue?.size48px, DummyProfileEntity().avatarUrls.size48px);
      expect(rightValue?.size96px, DummyProfileEntity().avatarUrls.size96px);
    });

    test("should return Kind Of (Failure) when fails", () async {
      //arrange
      when(
        () => mockGetMyProfile.call(any()),
      ).thenAnswer((invocation) async => left(FakeFailure()));

      //act
      final result = await profileServiceImpl.getProfileAvatar();
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<Failure>());
    });
  });
}
