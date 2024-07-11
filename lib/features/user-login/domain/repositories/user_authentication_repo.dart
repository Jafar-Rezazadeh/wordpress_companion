import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/features/user-login/user_login_exports.dart';

import '../../../../core/errors/failures.dart';

abstract class UserAuthenticationRepository {
  Future<Either<Failure, bool>> authenticateUser(UserAuthenticationParams params);
}
