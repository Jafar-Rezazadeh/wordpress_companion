import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/contracts/use_case.dart';
import '../../../../core/errors/failures.dart';
import '../../profile_exports.dart';

class UpdateMyProfile implements UseCase<ProfileEntity, UpdateMyProfileParams> {
  final ProfileRepository _profileRepository;

  UpdateMyProfile({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository;
  @override
  Future<Either<Failure, ProfileEntity>> call(UpdateMyProfileParams params) {
    return _profileRepository.updateMyProfile(params);
  }
}

class UpdateMyProfileParams extends Equatable {
  final String name;
  final String firstName;
  final String lastName;
  final String email;
  final String url;
  final String description;
  final String nickName;
  final String slug;

  const UpdateMyProfileParams({
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.url,
    required this.description,
    required this.nickName,
    required this.slug,
  });

  @override
  List<Object?> get props => [
        name,
        firstName,
        lastName,
        email,
        url,
        description,
        nickName,
        slug,
      ];
}
