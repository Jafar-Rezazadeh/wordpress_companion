import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/site_settings/site_settings_exports.dart';

class MockSiteSettingsDataSource extends Mock
    implements SiteSettingsDataSource {}

class FakeSiteSettingsModel extends Fake implements SiteSettingsModel {}

class FakeUpdateSiteSettingsParams extends Fake
    implements UpdateSiteSettingsParams {}

void main() {
  late MockSiteSettingsDataSource mockSiteSettingsDataSource;
  late SiteSettingsRepositoryImpl siteSettingsRepositoryImpl;

  setUpAll(() {
    registerFallbackValue(FakeUpdateSiteSettingsParams());
  });

  setUp(() {
    mockSiteSettingsDataSource = MockSiteSettingsDataSource();
    siteSettingsRepositoryImpl = SiteSettingsRepositoryImpl(
      siteSettingsDataSource: mockSiteSettingsDataSource,
    );
  });

  group("getSettings -", () {
    test("should return (SiteSettingsEntity) when success to get settings",
        () async {
      //arrange
      when(
        () => mockSiteSettingsDataSource.getSettings(),
      ).thenAnswer((_) async => FakeSiteSettingsModel());

      //act
      final result = await siteSettingsRepositoryImpl.getSettings();
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<SiteSettingsEntity>());
    });

    test("should return (ServerFailure) when DioException in thrown", () async {
      //arrange
      when(
        () => mockSiteSettingsDataSource.getSettings(),
      ).thenAnswer(
        (_) async => throw DioException(requestOptions: RequestOptions()),
      );

      //act
      final result = await siteSettingsRepositoryImpl.getSettings();
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<ServerFailure>());
    });

    test(
        "should return (InternalFailure) when any object except DioException in thrown",
        () async {
      //arrange
      when(
        () => mockSiteSettingsDataSource.getSettings(),
      ).thenAnswer((_) => throw Exception());

      //act
      final result = await siteSettingsRepositoryImpl.getSettings();
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<InternalFailure>());
    });
  });

  group("updateSettings -", () {
    test(
        "should return updated settings as (SiteSettingsEntity) when success to update",
        () async {
      //arrange
      when(
        () => mockSiteSettingsDataSource.updateSettings(any()),
      ).thenAnswer((_) async => FakeSiteSettingsModel());

      //act
      final result = await siteSettingsRepositoryImpl.updateSettings(
        FakeUpdateSiteSettingsParams(),
      );
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<SiteSettingsEntity>());
    });

    test("should return (ServerFailure) when DioException in thrown", () async {
      //arrange
      when(
        () => mockSiteSettingsDataSource.updateSettings(any()),
      ).thenAnswer((_) => throw DioException(requestOptions: RequestOptions()));

      //act
      final result = await siteSettingsRepositoryImpl.updateSettings(
        FakeUpdateSiteSettingsParams(),
      );
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<ServerFailure>());
    });

    test(
        "should return (InternalFailure) when any object except DioException is thrown ",
        () async {
      //arrange
      when(
        () => mockSiteSettingsDataSource.updateSettings(any()),
      ).thenAnswer((_) => throw TypeError());

      //act
      final result = await siteSettingsRepositoryImpl.updateSettings(
        FakeUpdateSiteSettingsParams(),
      );
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<InternalFailure>());
    });
  });
}
