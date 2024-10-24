import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/site_settings/site_settings_exports.dart';

class MockGetSiteSettings extends Mock implements GetSiteSettings {}

class MockUpdateSiteSettings extends Mock implements UpdateSiteSettings {}

class FakeSiteSettingsEntity extends Fake implements SiteSettingsEntity {}

class FakeFailure extends Fake implements Failure {}

class FakeUpdateSiteSettingsParams extends Fake
    implements UpdateSiteSettingsParams {}

void main() {
  late MockGetSiteSettings mockGetSiteSettings;
  late MockUpdateSiteSettings mockUpdateSiteSettings;
  late SiteSettingsCubit siteSettingsCubit;

  setUpAll(() {
    registerFallbackValue(NoParams());
    registerFallbackValue(FakeUpdateSiteSettingsParams());
  });

  setUp(() {
    mockGetSiteSettings = MockGetSiteSettings();
    mockUpdateSiteSettings = MockUpdateSiteSettings();
    siteSettingsCubit = SiteSettingsCubit(
      getSiteSettings: mockGetSiteSettings,
      updateSiteSettings: mockUpdateSiteSettings,
    );
  });

  group("loadSettings -", () {
    blocTest<SiteSettingsCubit, SiteSettingsState>(
      'emits [loading, loaded] when successful to get data',
      setUp: () {
        when(
          () => mockGetSiteSettings.call(any()),
        ).thenAnswer((_) async => right(FakeSiteSettingsEntity()));
      },
      build: () => siteSettingsCubit,
      act: (cubit) => cubit.loadSettings(),
      expect: () => [
        isA<SiteSettingsState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<SiteSettingsState>().having(
          (state) => state.whenOrNull(loaded: (_) => true),
          "is loaded state",
          true,
        ),
      ],
      verify: (_) => verify(() => mockGetSiteSettings.call(any())).called(1),
    );

    blocTest<SiteSettingsCubit, SiteSettingsState>(
      'emits [loading, error] when an error occurred',
      setUp: () {
        when(
          () => mockGetSiteSettings.call(any()),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => siteSettingsCubit,
      act: (cubit) => cubit.loadSettings(),
      expect: () => [
        isA<SiteSettingsState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<SiteSettingsState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          "is error state",
          true,
        ),
      ],
      verify: (_) => verify(() => mockGetSiteSettings.call(any())).called(1),
    );
  });

  group("updateSettings -", () {
    blocTest<SiteSettingsCubit, SiteSettingsState>(
      'emits [updating, updated] when success to update',
      setUp: () {
        when(
          () => mockUpdateSiteSettings.call(any()),
        ).thenAnswer((_) async => right(FakeSiteSettingsEntity()));
      },
      build: () => siteSettingsCubit,
      act: (cubit) => cubit.updateSettings(FakeUpdateSiteSettingsParams()),
      expect: () => [
        isA<SiteSettingsState>().having(
          (state) => state.whenOrNull(updating: () => true),
          "is updating state",
          true,
        ),
        isA<SiteSettingsState>().having(
          (state) => state.whenOrNull(updated: (_) => true),
          "is updated state",
          true,
        )
      ],
      verify: (_) => verify(() => mockUpdateSiteSettings.call(any())).called(1),
    );

    blocTest<SiteSettingsCubit, SiteSettingsState>(
      'emits [updating, error] when fails to update',
      setUp: () {
        when(
          () => mockUpdateSiteSettings.call(any()),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => siteSettingsCubit,
      act: (cubit) => cubit.updateSettings(FakeUpdateSiteSettingsParams()),
      expect: () => [
        isA<SiteSettingsState>().having(
          (state) => state.whenOrNull(updating: () => true),
          "is updating state",
          true,
        ),
        isA<SiteSettingsState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          "is error state",
          true,
        ),
      ],
      verify: (_) => verify(() => mockUpdateSiteSettings.call(any())).called(1),
    );
  });
}
