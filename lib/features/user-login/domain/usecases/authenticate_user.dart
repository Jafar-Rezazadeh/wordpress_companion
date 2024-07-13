import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/user-login/user_login_exports.dart';

class AuthenticateUser implements UseCase<bool, UserCredentialsParams> {
  final UserLoginRepository _userAuthenticationRepository;

  AuthenticateUser({required UserLoginRepository userLoginRepository})
      : _userAuthenticationRepository = userLoginRepository;
  @override
  Future<Either<Failure, bool>> call(UserCredentialsParams params) async {
    return _userAuthenticationRepository.authenticateUser(params);
  }
}

typedef UserCredentialsParams = ({
  String name,
  String applicationPassword,
  String domain,
  bool rememberMe,
});
