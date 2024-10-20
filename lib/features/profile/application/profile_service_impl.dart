import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/entities/profile_avatar.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/core/services/profile_service.dart';
import 'package:wordpress_companion/features/profile/profile_exports.dart';

import '../../../core/contracts/use_case.dart';

class ProfileServiceImpl implements ProfileService {
  final GetMyProfile _getMyProfile;

  ProfileServiceImpl({
    required GetMyProfile getMyProfile,
  }) : _getMyProfile = getMyProfile;
  @override
  Future<Either<Failure, ProfileAvatar>> getProfileAvatar() async {
    final result = await _getMyProfile.call(NoParams());

    return result.fold(
      (failure) => left(failure),
      (profileData) {
        final profileAvatar = ProfileAvatar(
          size24px: profileData.avatarUrls.size24px,
          size48px: profileData.avatarUrls.size48px,
          size96px: profileData.avatarUrls.size96px,
        );

        return right(profileAvatar);
      },
    );
  }
}
