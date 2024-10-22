import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../profile_exports.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;

  ProfileRepositoryImpl({
    required ProfileRemoteDataSource profileRemoteDataSource,
  }) : _profileRemoteDataSource = profileRemoteDataSource;

  @override
  Future<Either<Failure, ProfileEntity>> getMyProfile() async {
    try {
      final result = await _profileRemoteDataSource.getMyProfile();

      return right(result);
    } catch (e) {
      return left(FailureFactory.createFailure(e));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateMyProfile(
      UpdateMyProfileParams params) async {
    try {
      final result = await _profileRemoteDataSource.updateMyProfile(params);

      return right(result);
    } catch (e) {
      return left(FailureFactory.createFailure(e));
    }
  }
}
