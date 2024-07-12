import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/user-login/user_login_exports.dart';

class AuthenticateUser implements UseCase<bool, UserAuthenticationParams> {
  final UserAuthenticationRepository _userAuthenticationRepository;

  AuthenticateUser({required UserAuthenticationRepository userAuthenticationRepository})
      : _userAuthenticationRepository = userAuthenticationRepository;
  @override
  Future<Either<Failure, bool>> call(UserAuthenticationParams params) async {
    return _userAuthenticationRepository.authenticateUser(params);
  }
}

typedef UserAuthenticationParams = ({
  String name,
  String applicationPassword,
  String domain,
});
