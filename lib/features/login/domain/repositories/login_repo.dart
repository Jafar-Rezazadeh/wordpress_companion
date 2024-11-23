import 'package:dartz/dartz.dart';

import '../../login_exports.dart';

import '../../../../core/errors/failures.dart';

abstract class LoginRepository {
  Future<Either<Failure, bool>> authenticateUser(LoginCredentialsParams params);
  Future<Either<Failure, LoginCredentialsEntity>> saveCredentials(
      LoginCredentialsParams params);
  Future<Either<Failure, LoginCredentialsEntity>> getLastLoginCredentials();
  Future<Either<Failure, void>> clearCachedCredentials();
}
