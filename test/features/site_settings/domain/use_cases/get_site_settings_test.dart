import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/site_settings/site_settings_exports.dart';

class MockSiteSettingsRepository extends Mock
    implements SiteSettingsRepository {}

class FakeSiteSettingsEntity extends Fake implements SiteSettingsEntity {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late SiteSettingsRepository mockSiteSettingsRepository;
  late GetSiteSettings getSiteSettings;

  setUp(() {
    mockSiteSettingsRepository = MockSiteSettingsRepository();
    getSiteSettings = GetSiteSettings(
      siteSettingsRepository: mockSiteSettingsRepository,
    );
  });

  test("should return (SiteSettingsEntity) when success", () async {
    //arrange
    when(
      () => mockSiteSettingsRepository.getSettings(),
    ).thenAnswer((_) async => right(FakeSiteSettingsEntity()));

    //act
    final result = await getSiteSettings.call(NoParams());
    final rightValue = result.fold((l) => null, (r) => r);

    //assert
    expect(result.isRight(), true);
    expect(rightValue, isA<SiteSettingsEntity>());
  });

  test("should return kind of (Failure) when fails to get settings data",
      () async {
    //arrange
    when(
      () => mockSiteSettingsRepository.getSettings(),
    ).thenAnswer((_) async => left(FakeFailure()));

    //act
    final result = await getSiteSettings.call(NoParams());
    final leftValue = result.fold((l) => l, (r) => null);

    //assert
    expect(result.isLeft(), true);
    expect(leftValue, isA<Failure>());
  });
}
