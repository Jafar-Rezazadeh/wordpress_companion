import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/site_settings/site_settings_exports.dart';

class GetSiteSettings implements UseCase<SiteSettingsEntity, NoParams> {
  final SiteSettingsRepository _siteSettingsRepository;

  GetSiteSettings({
    required SiteSettingsRepository siteSettingsRepository,
  }) : _siteSettingsRepository = siteSettingsRepository;
  @override
  Future<Either<Failure, SiteSettingsEntity>> call(NoParams params) {
    return _siteSettingsRepository.getSettings();
  }
}
