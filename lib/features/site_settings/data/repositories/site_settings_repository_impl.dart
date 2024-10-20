import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/site_settings/site_settings_exports.dart';

class SiteSettingsRepositoryImpl implements SiteSettingsRepository {
  final SiteSettingsDataSource _siteSettingsDataSource;

  SiteSettingsRepositoryImpl({
    required SiteSettingsDataSource siteSettingsDataSource,
  }) : _siteSettingsDataSource = siteSettingsDataSource;

  @override
  Future<Either<Failure, SiteSettingsEntity>> getSettings() async {
    try {
      final result = await _siteSettingsDataSource.getSettings();

      return right(result);
    } catch (e) {
      return left(FailureFactory.createFailure(e));
    }
  }

  @override
  Future<Either<Failure, SiteSettingsEntity>> updateSettings(
      UpdateSiteSettingsParams params) async {
    try {
      final result = await _siteSettingsDataSource.updateSettings(params);

      return right(result);
    } catch (e) {
      return left(FailureFactory.createFailure(e));
    }
  }
}
