import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/site_settings/site_settings_exports.dart';

abstract class SiteSettingsRepository {
  Future<Either<Failure, SiteSettingsEntity>> getSettings();
  Future<Either<Failure, SiteSettingsEntity>> updateSettings(
      UpdateSiteSettingsParams params);
}
