import '../../profile_exports.dart';

class ProfileAvatarUrlsModel extends ProfileAvatarUrlsEntity {
  const ProfileAvatarUrlsModel({
    required super.size24px,
    required super.size48px,
    required super.size96px,
  });

  factory ProfileAvatarUrlsModel.fromJson(json) {
    return ProfileAvatarUrlsModel(
      size24px: json['24'] as String? ?? "",
      size48px: json['48'] as String? ?? "",
      size96px: json['96'] as String? ?? "",
    );
  }
}
