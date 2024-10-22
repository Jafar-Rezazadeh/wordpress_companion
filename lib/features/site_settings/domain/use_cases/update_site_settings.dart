import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/contracts/use_case.dart';
import '../../../../core/errors/failures.dart';
import '../../site_settings_exports.dart';

class UpdateSiteSettings
    implements UseCase<SiteSettingsEntity, UpdateSiteSettingsParams> {
  final SiteSettingsRepository _siteSettingsRepository;

  UpdateSiteSettings({
    required SiteSettingsRepository siteSettingsRepository,
  }) : _siteSettingsRepository = siteSettingsRepository;

  @override
  Future<Either<Failure, SiteSettingsEntity>> call(
      UpdateSiteSettingsParams params) {
    return _siteSettingsRepository.updateSettings(params);
  }
}

class UpdateSiteSettingsParams extends Equatable {
  final String title;
  final String description;
  final int siteIcon;
  final String url;
  final String email;
  final String timeZone;
  final String dateFormat;
  final String timeFormat;
  final int startOfWeek;

  const UpdateSiteSettingsParams({
    required this.title,
    required this.description,
    required this.siteIcon,
    required this.url,
    required this.email,
    required this.timeZone,
    required this.dateFormat,
    required this.timeFormat,
    required this.startOfWeek,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        siteIcon,
        url,
        email,
        timeZone,
        dateFormat,
        timeFormat,
        startOfWeek,
      ];
}
