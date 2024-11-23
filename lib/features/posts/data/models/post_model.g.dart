// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      id: (json['id'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
      guid: PostModel._guidReadValue(json, 'guid') as String,
      modified: DateTime.parse(json['modified'] as String),
      slug: json['slug'] as String,
      status: $enumDecode(_$PostStatusEnumEnumMap, json['status']),
      type: json['type'] as String,
      link: json['link'] as String,
      title: PostModel._titleReadValue(json, 'title') as String,
      content: PostModel._contentReadValue(json, 'content') as String,
      excerpt: PostModel._excerptReadValue(json, 'excerpt') as String,
      author: (json['author'] as num).toInt(),
      authorName: PostModel._authorNameReadValue(json, 'authorName') as String,
      featuredMedia: (json['featured_media'] as num).toInt(),
      featureMediaLink:
          PostModel._featureMediaLinkReadValue(json, 'featureMediaLink')
                  as String? ??
              '',
      commentStatus: json['comment_status'] as String,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      tags: (json['tags'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'slug': instance.slug,
      'status': _$PostStatusEnumEnumMap[instance.status]!,
      'categories': instance.categories,
      'tags': instance.tags,
      'title': instance.title,
      'content': instance.content,
      'excerpt': instance.excerpt,
      'featured_media': instance.featuredMedia,
    };

const _$PostStatusEnumEnumMap = {
  PostStatusEnum.publish: 'publish',
  PostStatusEnum.future: 'future',
  PostStatusEnum.draft: 'draft',
  PostStatusEnum.pending: 'pending',
  PostStatusEnum.private: 'private',
  PostStatusEnum.trash: 'trash',
};
