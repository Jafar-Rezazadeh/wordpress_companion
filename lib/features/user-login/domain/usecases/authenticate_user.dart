import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';

import '../repositories/user_authentication_repo.dart';

class AuthenticateUser implements UseCase<bool, UserAuthenticationParams> {
  final UserAuthenticationRepository _userAuthentication;

  AuthenticateUser({required UserAuthenticationRepository userAuthentication})
      : _userAuthentication = userAuthentication;
  @override
  Future<Either<Failure, bool>> call(UserAuthenticationParams params) async {
    return _userAuthentication.authenticateUser(params);
  }
}

typedef UserAuthenticationParams = ({
  String name,
  String applicationPassword,
  String domain,
});
