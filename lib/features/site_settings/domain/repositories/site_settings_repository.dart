import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../site_settings_exports.dart';

abstract class SiteSettingsRepository {
  Future<Either<Failure, SiteSettingsEntity>> getSettings();
  Future<Either<Failure, SiteSettingsEntity>> updateSettings(
      UpdateSiteSettingsParams params);
}
