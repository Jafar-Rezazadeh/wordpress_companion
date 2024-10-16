import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/login/login_exports.dart';

class AuthenticateUser implements UseCase<bool, LoginCredentialsParams> {
  final LoginRepository _userAuthenticationRepository;

  AuthenticateUser({required LoginRepository userLoginRepository})
      : _userAuthenticationRepository = userLoginRepository;
  @override
  Future<Either<Failure, bool>> call(LoginCredentialsParams params) async {
    return _userAuthenticationRepository.authenticateUser(params);
  }
}

typedef LoginCredentialsParams = ({
  String name,
  String applicationPassword,
  String domain,
  bool rememberMe,
});
