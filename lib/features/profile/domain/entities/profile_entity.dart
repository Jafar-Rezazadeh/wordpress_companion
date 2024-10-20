import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wordpress_companion/core/constants/enums.dart';

import '../../profile_exports.dart';

class ProfileEntity extends Equatable {
  @JsonKey(defaultValue: 0, includeToJson: false)
  final int id;

  @JsonKey(defaultValue: "", name: "username", includeToJson: false)
  final String userName;

  @JsonKey(defaultValue: "")
  final String name;

  @JsonKey(defaultValue: "", name: "first_name")
  final String firstName;

  @JsonKey(defaultValue: "", name: "last_name")
  final String lastName;

  @JsonKey(defaultValue: "")
  final String email;

  @JsonKey(defaultValue: "")
  final String url;

  @JsonKey(defaultValue: "")
  final String description;

  @JsonKey(defaultValue: "", includeToJson: false)
  final String link;

  @JsonKey(defaultValue: "", includeToJson: false)
  final String locale;

  @JsonKey(defaultValue: "", name: "nickname")
  final String nickName;

  @JsonKey(defaultValue: "")
  final String slug;

  @JsonKey(defaultValue: [], includeToJson: false)
  final List<UserRole> roles;

  // implemented in model
  final ProfileAvatarUrlsEntity avatarUrls;
  final DateTime registeredDate;

  const ProfileEntity({
    required this.id,
    required this.userName,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.url,
    required this.description,
    required this.link,
    required this.locale,
    required this.nickName,
    required this.slug,
    required this.registeredDate,
    required this.avatarUrls,
    required this.roles,
  });

  @override
  List<Object?> get props => [id];
}
