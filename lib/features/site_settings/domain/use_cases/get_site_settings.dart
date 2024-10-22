import 'package:dartz/dartz.dart';
import '../../../../core/contracts/use_case.dart';
import '../../../../core/errors/failures.dart';
import '../../site_settings_exports.dart';

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
