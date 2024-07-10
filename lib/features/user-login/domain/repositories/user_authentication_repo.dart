import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/features/user-login/domain/usecases/authenticate_user.dart';

import '../../../../core/errors/failures.dart';

abstract class UserAuthenticationRepository {
  Future<Either<Failure, bool>> authenticateUser(UserAuthenticationParams params);
}
