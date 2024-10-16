import 'package:wordpress_companion/features/profile/profile_exports.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getMyProfile();
  Future<ProfileModel> updateMyProfile(UpdateMyProfileParams params);
}
