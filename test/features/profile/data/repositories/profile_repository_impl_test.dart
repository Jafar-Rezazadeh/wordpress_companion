import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:wordpress_companion/features/profile/profile_exports.dart';

class MockProfileRemoteDataSource extends Mock
    implements ProfileRemoteDataSource {}

class FakeProfileModel extends Fake implements ProfileModel {}

class FakeUpdateMyProfileParams extends Fake implements UpdateMyProfileParams {}

void main() {
  late MockProfileRemoteDataSource mockProfileRemoteDataSource;
  late ProfileRepositoryImpl profileRepositoryImpl;

  setUp(() {
    mockProfileRemoteDataSource = MockProfileRemoteDataSource();
    profileRepositoryImpl = ProfileRepositoryImpl(
      profileRemoteDataSource: mockProfileRemoteDataSource,
    );
  });

  setUpAll(() {
    registerFallbackValue(FakeUpdateMyProfileParams());
  });

  group("getMyProfile -", () {
    test("should return right(ProfileEntity) when success to get data",
        () async {
      //arrange
      when(
        () => mockProfileRemoteDataSource.getMyProfile(),
      ).thenAnswer((_) async => FakeProfileModel());

      //act
      final result = await profileRepositoryImpl.getMyProfile();
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<ProfileEntity>());
    });

    test("should return (ServerFailure) when DioException thrown", () async {
      //arrange
      when(
        () => mockProfileRemoteDataSource.getMyProfile(),
      ).thenThrow(DioException(requestOptions: RequestOptions()));

      //act
      final result = await profileRepositoryImpl.getMyProfile();
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<ServerFailure>());
    });

    test("should return (InternalFailure) when eny other object thrown",
        () async {
      //arrange
      when(
        () => mockProfileRemoteDataSource.getMyProfile(),
      ).thenThrow(TypeError());

      //act
      final result = await profileRepositoryImpl.getMyProfile();
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<InternalFailure>());
    });
  });

  group("updateMyProfile -", () {
    test("should return updated data as (ProfileEntity) when update success",
        () async {
      //arrange
      when(
        () => mockProfileRemoteDataSource.updateMyProfile(any()),
      ).thenAnswer((_) async => FakeProfileModel());

      //act
      final result = await profileRepositoryImpl
          .updateMyProfile(FakeUpdateMyProfileParams());
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<ProfileEntity>());
    });

    test("should return (ServerFailure) when DioException thrown", () async {
      //arrange
      when(
        () => mockProfileRemoteDataSource.updateMyProfile(any()),
      ).thenThrow(DioException(requestOptions: RequestOptions()));

      //act
      final result = await profileRepositoryImpl.updateMyProfile(
        FakeUpdateMyProfileParams(),
      );
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<ServerFailure>());
    });
  });
}
