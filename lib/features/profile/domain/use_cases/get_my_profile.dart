import 'package:dartz/dartz.dart';
import '../../../../core/contracts/use_case.dart';
import '../../../../core/errors/failures.dart';

import '../../profile_exports.dart';

class GetMyProfile implements UseCase<ProfileEntity, NoParams> {
  final ProfileRepository _profileRepository;

  GetMyProfile({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository;

  @override
  Future<Either<Failure, ProfileEntity>> call(NoParams params) {
    return _profileRepository.getMyProfile();
  }
}
