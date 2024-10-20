import 'package:wordpress_companion/features/site_settings/site_settings_exports.dart';

abstract class SiteSettingsDataSource {
  Future<SiteSettingsModel> getSettings();
  Future<SiteSettingsModel> updateSettings(UpdateSiteSettingsParams params);
}
