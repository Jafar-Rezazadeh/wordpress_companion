// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SiteSettingsModel _$SiteSettingsModelFromJson(Map<String, dynamic> json) =>
    SiteSettingsModel(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      url: json['url'] as String? ?? '',
      email: json['email'] as String? ?? '',
      timeZone: json['timezone'] as String? ?? '',
      dateFormat: json['date_format'] as String? ?? '',
      timeFormat: json['time_format'] as String? ?? '',
      startOfWeek: (json['start_of_week'] as num?)?.toInt() ?? 1,
      language: json['language'] as String? ?? '',
      useSmilies: json['use_smilies'] as bool? ?? false,
      defaultCategory: (json['default_category'] as num?)?.toInt() ?? 1,
      defaultPostFormat: json['default_post_format'] as String? ?? '',
      postsPerPage: (json['posts_per_page'] as num?)?.toInt() ?? 0,
      showOnFront: json['show_on_front'] as String? ?? '',
      pageOnFront: (json['page_on_front'] as num?)?.toInt() ?? 0,
      pageForPosts: (json['page_for_posts'] as num?)?.toInt() ?? 0,
      defaultPingStatus: json['default_ping_status'] as String? ?? '',
      defaultCommentStatus: json['default_comment_status'] as String? ?? '',
      siteLogo: json['site_logo'] as String?,
      siteIcon: (json['site_icon'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$SiteSettingsModelToJson(SiteSettingsModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'email': instance.email,
      'language': instance.language,
      'timezone': instance.timeZone,
      'date_format': instance.dateFormat,
      'time_format': instance.timeFormat,
      'start_of_week': instance.startOfWeek,
      'site_icon': instance.siteIcon,
    };
