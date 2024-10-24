// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaModel _$MediaModelFromJson(Map<String, dynamic> json) => MediaModel(
      id: (json['id'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
      guid: MediaModel._guidFromJson(json['guid']),
      modified: DateTime.parse(json['modified'] as String),
      slug: json['slug'] as String,
      status: json['status'] as String,
      type: json['type'] as String,
      link: json['link'] as String,
      title: MediaModel._titleFromJson(json['title']),
      author: (json['author'] as num).toInt(),
      featuredMedia: (json['featured_media'] as num).toInt(),
      commentStatus: json['comment_status'] as String,
      pingStatus: json['ping_status'] as String,
      template: json['template'] as String,
      permalinkTemplate: json['permalink_template'] as String,
      generatedSlug: json['generated_slug'] as String,
      classList: (json['class_list'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      description: MediaModel._descriptionFromJson(json['description']),
      caption: MediaModel._captionFromJson(json['caption']),
      altText: json['alt_text'] as String,
      mediaType: json['media_type'] as String,
      mimeType: json['mime_type'] as String,
      mediaDetails: MediaModel._mediaDetailsFromJson(json['media_details']),
      post: (json['post'] as num?)?.toInt(),
      sourceUrl: json['source_url'] as String,
    );
