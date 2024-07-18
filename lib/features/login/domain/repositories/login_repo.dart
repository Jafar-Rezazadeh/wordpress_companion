import 'package:dartz/dartz.dart';

import 'package:wordpress_companion/features/login/login_exports.dart';

import '../../../../core/errors/failures.dart';

abstract class LoginRepository {
  Future<Either<Failure, bool>> authenticateUser(LoginCredentialsParams params);
  Future<Either<Failure, LoginCredentialsEntity>> saveCredentials(LoginCredentialsParams params);
  Future<Either<Failure, LoginCredentialsEntity>> getLastLoginCredentials();
}
