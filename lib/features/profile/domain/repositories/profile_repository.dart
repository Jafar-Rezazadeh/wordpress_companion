import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../profile_exports.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getMyProfile();
  Future<Either<Failure, ProfileEntity>> updateMyProfile(
    UpdateMyProfileParams params,
  );
}
