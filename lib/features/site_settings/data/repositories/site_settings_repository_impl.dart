import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../site_settings_exports.dart';

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
    } catch (e, s) {
      return left(FailureFactory.createFailure(e, s));
    }
  }

  @override
  Future<Either<Failure, SiteSettingsEntity>> updateSettings(
      UpdateSiteSettingsParams params) async {
    try {
      final result = await _siteSettingsDataSource.updateSettings(params);

      return right(result);
    } catch (e, s) {
      return left(FailureFactory.createFailure(e, s));
    }
  }
}
