import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/login/login_exports.dart';

import '../entities/user_entity.dart';

abstract class UserService {
  // TODO:make Implementation of UserService
  Future<Either<Failure, UserEntity>> getUserInfo(LoginCredentialsEntity params);
}
