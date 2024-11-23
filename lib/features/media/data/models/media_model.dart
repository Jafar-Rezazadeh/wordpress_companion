import 'package:json_annotation/json_annotation.dart';

import '../../media_exports.dart';
import 'media_details_model.dart';

part 'media_model.g.dart';

@JsonSerializable(createToJson: false)
class MediaModel extends MediaEntity {
  const MediaModel({
    required super.id,
    required super.date,
    required super.guid,
    required super.modified,
    required super.slug,
    required super.status,
    required super.type,
    required super.link,
    required super.title,
    required super.author,
    required super.featuredMedia,
    required super.commentStatus,
    required super.pingStatus,
    required super.template,
    required super.permalinkTemplate,
    required super.generatedSlug,
    required super.classList,
    required super.description,
    required super.caption,
    required super.altText,
    required super.mediaType,
    required super.mimeType,
    required super.mediaDetails,
    required super.post,
    required super.sourceUrl,
    required super.authorName,
  });

  @override
  @JsonKey(fromJson: _guidFromJson)
  String get guid => super.guid;
  static String _guidFromJson(dynamic json) => json['raw'];

  @override
  @JsonKey(fromJson: _titleFromJson)
  String get title => super.title;
  static String _titleFromJson(dynamic json) => json['raw'];

  @override
  @JsonKey(fromJson: _captionFromJson)
  String get caption => super.caption;
  static String _captionFromJson(dynamic json) => json['raw'];

  @override
  @JsonKey(fromJson: _descriptionFromJson)
  String get description => super.description;
  static String _descriptionFromJson(dynamic json) => json['raw'];

  @override
  @JsonKey(name: "featured_media")
  int get featuredMedia => super.featuredMedia;

  @override
  @JsonKey(name: "comment_status")
  String get commentStatus => super.commentStatus;

  @override
  @JsonKey(name: "ping_status")
  String get pingStatus => super.pingStatus;

  @override
  @JsonKey(name: "permalink_template")
  String get permalinkTemplate => super.permalinkTemplate;

  @override
  @JsonKey(name: "generated_slug")
  String get generatedSlug => super.generatedSlug;

  @override
  @JsonKey(name: "class_list", defaultValue: [])
  List<String> get classList => super.classList;

  @override
  @JsonKey(name: "alt_text")
  String get altText => super.altText;

  @override
  @JsonKey(name: "media_type")
  String get mediaType => super.mediaType;

  @override
  @JsonKey(name: "mime_type")
  String get mimeType => super.mimeType;

  @override
  @JsonKey(name: "media_details", fromJson: _mediaDetailsFromJson)
  MediaDetailsEntity get mediaDetails => super.mediaDetails;

  static MediaDetailsEntity _mediaDetailsFromJson(dynamic json) =>
      MediaDetailsModel.fromJson(json);

  @override
  @JsonKey(name: "source_url")
  String get sourceUrl => super.sourceUrl;

  @override
  @JsonKey(readValue: _readAuthorName)
  String? get authorName => super.authorName;

  static _readAuthorName(Map<dynamic, dynamic> json, String? key) {
    return json['_embedded']?['author']?[0]?['name'];
  }

  //

  factory MediaModel.fromJson(dynamic json) => _$MediaModelFromJson(json);

  Map<String, dynamic> toJson() => {
        "alt_text": altText,
        "caption": caption,
        "title": title,
        "description": description,
      };

  static fromParamsToJson(UpdateMediaParams params) {
    return {
      "alt_text": params.altText,
      "caption": params.caption,
      "title": params.title,
      "description": params.description,
    };
  }
}
