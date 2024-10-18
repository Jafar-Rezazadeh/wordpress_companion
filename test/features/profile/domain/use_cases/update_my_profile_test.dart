import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
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

  group("useCase itself -", () {
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
  });

  group("updateMyProfileParams -", () {
    test("should have the expected fields in props", () {
      //arrange
      const updateMyProfileParams = UpdateMyProfileParams(
        displayName: "displayName",
        firstName: "firstName",
        lastName: "lastName",
        email: "email",
        url: "url",
        description: "description",
        nickName: "nickName",
        slug: "slug",
      );
      //act
      final props = updateMyProfileParams.props;

      //assert
      expect(
        props,
        containsAll([
          "displayName",
          "firstName",
          "lastName",
          "email",
          "url",
          "description",
          "nickName",
          "slug",
        ]),
      );
    });

    test(
        "should two instance of (UpdateMyProfileParams) be same when props are the same",
        () {
      //arrange
      const params1 = UpdateMyProfileParams(
        displayName: "displayName",
        firstName: "firstName",
        lastName: "lastName",
        email: "email",
        url: "url",
        description: "description",
        nickName: "nickName",
        slug: "slug",
      );
      const params2 = UpdateMyProfileParams(
        displayName: "displayName",
        firstName: "firstName",
        lastName: "lastName",
        email: "email",
        url: "url",
        description: "description",
        nickName: "nickName",
        slug: "slug",
      );

      //assert
      expect(params1, params2);
    });
  });
}
