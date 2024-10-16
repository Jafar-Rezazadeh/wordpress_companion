import 'package:json_annotation/json_annotation.dart';
import '../../profile_exports.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.userName,
    required super.name,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.url,
    required super.description,
    required super.link,
    required super.locale,
    required super.nickName,
    required super.slug,
    required super.registeredDate,
    required super.avatarUrls,
  });

  @override
  @JsonKey(name: "avatar_urls", includeToJson: false, fromJson: _avatarFromJson)
  ProfileAvatarUrlsEntity get avatarUrls => super.avatarUrls;

  static ProfileAvatarUrlsEntity _avatarFromJson(dynamic json) {
    return ProfileAvatarUrlsModel.fromJson(json);
  }

  @override
  @JsonKey(
    defaultValue: _defaultDate,
    name: "registered_date",
    includeToJson: false,
    fromJson: _registeredDateFromJson,
  )
  DateTime get registeredDate => super.registeredDate;
  static _defaultDate() => DateTime(1);

  static DateTime _registeredDateFromJson(dynamic value) =>
      DateTime.tryParse(value) ?? DateTime(1);

  factory ProfileModel.fromJson(dynamic json) => _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
