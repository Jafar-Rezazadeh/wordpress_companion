import 'package:json_annotation/json_annotation.dart';
import 'package:wordpress_companion/features/site_settings/site_settings_exports.dart';

part 'site_settings_model.g.dart';

@JsonSerializable()
class SiteSettingsModel extends SiteSettingsEntity {
  const SiteSettingsModel({
    required super.title,
    required super.description,
    required super.url,
    required super.email,
    required super.timeZone,
    required super.dateFormat,
    required super.timeFormat,
    required super.startOfWeek,
    required super.language,
    required super.useSmilies,
    required super.defaultCategory,
    required super.defaultPostFormat,
    required super.postsPerPage,
    required super.showOnFront,
    required super.pageOnFront,
    required super.pageForPosts,
    required super.defaultPingStatus,
    required super.defaultCommentStatus,
    required super.siteLogo,
    required super.siteIcon,
  });

  factory SiteSettingsModel.fromJson(dynamic json) =>
      _$SiteSettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SiteSettingsModelToJson(this);
}
