import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/services/profile_service.dart';
import '../profile_exports.dart';

import '../../../core/contracts/use_case.dart';

class ProfileServiceImpl implements ProfileService {
  final GetMyProfile _getMyProfile;

  ProfileServiceImpl({
    required GetMyProfile getMyProfile,
  }) : _getMyProfile = getMyProfile;

  @override
  Future<Either<Failure, ProfileEntity>> getMyProfile() {
    return _getMyProfile(NoParams());
  }
}
