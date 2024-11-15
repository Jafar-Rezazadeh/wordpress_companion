import 'package:json_annotation/json_annotation.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';

import '../../../../core/core_export.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel extends PostEntity {
  const PostModel({
    required super.id,
    required super.date,
    required super.guid,
    required super.modified,
    required super.slug,
    required super.status,
    required super.type,
    required super.link,
    required super.title,
    required super.content,
    required super.excerpt,
    required super.author,
    required super.authorName,
    required super.featuredMedia,
    required super.featureMediaLink,
    required super.commentStatus,
    required super.categories,
    required super.tags,
  });

  @override
  @JsonKey(includeToJson: false)
  int get id => super.id;

  @override
  @JsonKey(includeToJson: false)
  DateTime get date => super.date;

  @override
  @JsonKey(readValue: _guidReadValue, includeToJson: false)
  String get guid => super.guid;
  static _guidReadValue(Map<dynamic, dynamic> json, String key) =>
      json[key]["raw"];

  @override
  @JsonKey(includeToJson: false)
  DateTime get modified => super.modified;

  @override
  @JsonKey(includeToJson: false)
  String get type => super.type;

  @override
  @JsonKey(includeToJson: false)
  String get link => super.link;

  @override
  @JsonKey(includeToJson: false)
  int get author => super.author;

  @override
  @JsonKey(readValue: _titleReadValue)
  String get title => super.title;
  static _titleReadValue(Map<dynamic, dynamic> json, String key) =>
      json[key]["raw"];

  @override
  @JsonKey(readValue: _contentReadValue)
  String get content => super.content;
  static _contentReadValue(Map<dynamic, dynamic> json, String key) =>
      json[key]["raw"];

  @override
  @JsonKey(readValue: _excerptReadValue)
  String get excerpt => super.excerpt;
  static _excerptReadValue(Map<dynamic, dynamic> json, String key) =>
      json[key]["raw"];

  @override
  @JsonKey(readValue: _authorNameReadValue, includeToJson: false)
  String get authorName => super.authorName;
  static _authorNameReadValue(Map<dynamic, dynamic> json, String key) =>
      json["_embedded"]["author"]?[0]?["name"];

  @override
  @JsonKey(name: "featured_media")
  int get featuredMedia => super.featuredMedia;

  @override
  @JsonKey(
      readValue: _featureMediaLinkReadValue,
      includeToJson: false,
      defaultValue: "")
  String get featureMediaLink => super.featureMediaLink;
  static _featureMediaLinkReadValue(Map<dynamic, dynamic> json, String key) =>
      json["_embedded"]["wp:featuredmedia"]?[0]?["source_url"];

  @override
  @JsonKey(name: "comment_status", includeToJson: false)
  String get commentStatus => super.commentStatus;

  factory PostModel.fromJson(dynamic json) => _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  static Map<String, dynamic> toJsonFromParams(PostParams postParams) {
    return PostModel(
      id: 0,
      date: DateTime(1),
      guid: "",
      modified: DateTime(1),
      slug: postParams.slug,
      status: postParams.status,
      type: "",
      link: "",
      title: postParams.title,
      content: postParams.content,
      excerpt: postParams.excerpt,
      author: 0,
      authorName: "",
      featuredMedia: postParams.featuredImage,
      featureMediaLink: "",
      commentStatus: "",
      categories: postParams.categories,
      tags: postParams.tags,
    ).toJson();
  }
}
