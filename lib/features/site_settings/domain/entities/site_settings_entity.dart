import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class SiteSettingsEntity extends Equatable {
  @JsonKey(defaultValue: "")
  final String title;

  @JsonKey(defaultValue: "")
  final String description;

  @JsonKey(defaultValue: "")
  final String url;

  @JsonKey(defaultValue: "")
  final String email;

  @JsonKey(defaultValue: "")
  final String language;

  @JsonKey(defaultValue: "", name: "timezone")
  final String timeZone;

  @JsonKey(defaultValue: "", name: "date_format")
  final String dateFormat;

  @JsonKey(defaultValue: "", name: "time_format")
  final String timeFormat;

  @JsonKey(defaultValue: 1, name: "start_of_week")
  final int startOfWeek;

  @JsonKey(defaultValue: 0, name: "site_icon")
  final int siteIcon;

  @JsonKey(defaultValue: false, name: "use_smilies", includeToJson: false)
  final bool useSmilies;

  @JsonKey(defaultValue: 1, name: "default_category", includeToJson: false)
  final int defaultCategory;

  @JsonKey(defaultValue: "", name: "default_post_format", includeToJson: false)
  final String defaultPostFormat;

  @JsonKey(defaultValue: 0, name: "posts_per_page", includeToJson: false)
  final int postsPerPage;

  @JsonKey(defaultValue: "", name: "show_on_front", includeToJson: false)
  final String showOnFront;

  @JsonKey(defaultValue: 0, name: "page_on_front", includeToJson: false)
  final int pageOnFront;

  @JsonKey(defaultValue: 0, name: "page_for_posts", includeToJson: false)
  final int pageForPosts;

  @JsonKey(defaultValue: "", name: "default_ping_status", includeToJson: false)
  final String defaultPingStatus;

  @JsonKey(
      defaultValue: "", name: "default_comment_status", includeToJson: false)
  final String defaultCommentStatus;

  @JsonKey(name: "site_logo", includeToJson: false)
  final String? siteLogo;

  const SiteSettingsEntity({
    required this.title,
    required this.description,
    required this.url,
    required this.email,
    required this.timeZone,
    required this.dateFormat,
    required this.timeFormat,
    required this.startOfWeek,
    required this.language,
    required this.useSmilies,
    required this.defaultCategory,
    required this.defaultPostFormat,
    required this.postsPerPage,
    required this.showOnFront,
    required this.pageOnFront,
    required this.pageForPosts,
    required this.defaultPingStatus,
    required this.defaultCommentStatus,
    required this.siteLogo,
    required this.siteIcon,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        url,
        email,
        timeZone,
        dateFormat,
        timeFormat,
        startOfWeek,
        language,
        siteIcon,
      ];
}
