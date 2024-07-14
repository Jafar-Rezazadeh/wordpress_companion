import 'package:dartz/dartz.dart';

import 'package:wordpress_companion/features/user-login/user_login_exports.dart';

import '../../../../core/errors/failures.dart';

abstract class UserLoginRepository {
  Future<Either<Failure, bool>> authenticateUser(UserCredentialsParams params);
  Future<Either<Failure, UserCredentialsEntity>> saveCredentials(UserCredentialsParams params);
  Future<Either<Failure, UserCredentialsEntity>> getLastLoginCredentials();
}
