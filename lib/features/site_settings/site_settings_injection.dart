import 'package:get_it/get_it.dart';
import 'package:wordpress_companion/features/site_settings/site_settings_exports.dart';

initSiteSettingsInjections(GetIt getIt) {
  // data sources
  getIt.registerLazySingleton<SiteSettingsDataSource>(
    () => SiteSettingsDataSourceImpl(dio: getIt()),
  );

  // repositories
  getIt.registerLazySingleton<SiteSettingsRepository>(
    () => SiteSettingsRepositoryImpl(siteSettingsDataSource: getIt()),
  );

  // cubit
  getIt.registerFactory(
    () => SiteSettingsCubit(
      getSiteSettings: GetSiteSettings(siteSettingsRepository: getIt()),
      updateSiteSettings: UpdateSiteSettings(siteSettingsRepository: getIt()),
    ),
  );
}
