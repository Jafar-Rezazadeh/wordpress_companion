import 'package:get_it/get_it.dart';
import 'package:wordpress_companion/features/site_settings/site_settings_exports.dart';

initSiteSettingsInjections(GetIt getIt) {
  // data sources
  final siteSettingsDataSource = SiteSettingsDataSourceImpl(dio: getIt());

  // repositories
  final siteSettingsRepository = SiteSettingsRepositoryImpl(
    siteSettingsDataSource: siteSettingsDataSource,
  );

  // cubits
  getIt.registerFactory(
    () => SiteSettingsCubit(
      getSiteSettings: GetSiteSettings(
        siteSettingsRepository: siteSettingsRepository,
      ),
      updateSiteSettings: UpdateSiteSettings(
        siteSettingsRepository: siteSettingsRepository,
      ),
    ),
  );

  getIt.registerFactory(() => ImageListCubit(mediaService: getIt()));
}
