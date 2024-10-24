part of 'site_settings_cubit.dart';

@freezed
class SiteSettingsState with _$SiteSettingsState {
  const factory SiteSettingsState.initial() = _Initial;
  const factory SiteSettingsState.loading() = _Loading;
  const factory SiteSettingsState.loaded(SiteSettingsEntity settings) = _Loaded;
  const factory SiteSettingsState.updating() = _Updating;
  const factory SiteSettingsState.updated(
    SiteSettingsEntity settings,
  ) = _Updated;
  const factory SiteSettingsState.error(Failure failure) = _Error;
}
