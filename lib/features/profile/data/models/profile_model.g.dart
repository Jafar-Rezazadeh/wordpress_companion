// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      userName: json['username'] as String? ?? '',
      name: json['name'] as String? ?? '',
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      url: json['url'] as String? ?? '',
      description: json['description'] as String? ?? '',
      link: json['link'] as String? ?? '',
      locale: json['locale'] as String? ?? '',
      nickName: json['nickname'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      registeredDate: json['registered_date'] == null
          ? ProfileModel._defaultDate()
          : ProfileModel._registeredDateFromJson(json['registered_date']),
      avatarUrls: ProfileModel._avatarFromJson(json['avatar_urls']),
      roles: (json['roles'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$UserRoleEnumMap, e))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'url': instance.url,
      'description': instance.description,
      'nickname': instance.nickName,
      'slug': instance.slug,
    };

const _$UserRoleEnumMap = {
  UserRole.subscriber: 'subscriber',
  UserRole.contributor: 'contributor',
  UserRole.author: 'author',
  UserRole.editor: 'editor',
  UserRole.administrator: 'administrator',
};
