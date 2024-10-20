import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/site_settings/site_settings_exports.dart';

class MockSiteSettingsRepository extends Mock
    implements SiteSettingsRepository {}

class FakeUpdateParams extends Fake implements UpdateSiteSettingsParams {}

class FakeSiteSettingsEntity extends Fake implements SiteSettingsEntity {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockSiteSettingsRepository mockSiteSettingsRepository;
  late UpdateSiteSettings updateSiteSettings;

  setUpAll(() {
    registerFallbackValue(FakeUpdateParams());
  });

  setUp(() {
    mockSiteSettingsRepository = MockSiteSettingsRepository();
    updateSiteSettings = UpdateSiteSettings(
      siteSettingsRepository: mockSiteSettingsRepository,
    );
  });

  group("useCase itself", () {
    test("should return updated setting as (SiteSettingsEntity) when success",
        () async {
      //arrange
      when(
        () => mockSiteSettingsRepository.updateSettings(any()),
      ).thenAnswer((_) async => right(FakeSiteSettingsEntity()));

      //act
      final result = await updateSiteSettings.call(FakeUpdateParams());
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<SiteSettingsEntity>());
    });

    test("should return kind of (Failure) when fails to update", () async {
      //arrange
      when(
        () => mockSiteSettingsRepository.updateSettings(any()),
      ).thenAnswer((_) async => left(FakeFailure()));

      //act
      final result = await updateSiteSettings.call(FakeUpdateParams());
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<Failure>());
    });
  });

  group("useCase params object", () {
    test("should include the expected properties to props ", () {
      //arrange
      const params = UpdateSiteSettingsParams(
        title: "title",
        description: "description",
        siteIcon: 0,
        url: "url",
        email: "email",
        language: "language",
        timeZone: "timeZone",
        dateFormat: "dateFormat",
        timeFormat: "timeFormat",
        startOfWeek: "startOfWeek",
      );

      //act
      final props = params.props;

      //assert
      expect(
        props,
        containsAll([
          "title",
          "description",
          0,
          "url",
          "email",
          "language",
          "timeZone",
          "dateFormat",
          "timeFormat",
          "startOfWeek",
        ]),
      );
    });

    test("should be same if props are same ", () {
      //arrange
      const params1 = UpdateSiteSettingsParams(
        title: "title",
        description: "description",
        siteIcon: 0,
        url: "url",
        email: "email",
        language: "language",
        timeZone: "timeZone",
        dateFormat: "dateFormat",
        timeFormat: "timeFormat",
        startOfWeek: "startOfWeek",
      );
      const params2 = UpdateSiteSettingsParams(
        title: "title",
        description: "description",
        siteIcon: 0,
        url: "url",
        email: "email",
        language: "language",
        timeZone: "timeZone",
        dateFormat: "dateFormat",
        timeFormat: "timeFormat",
        startOfWeek: "startOfWeek",
      );

      //assert
      expect(params1 == params2, true);
    });
  });
}
