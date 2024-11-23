import 'package:dartz/dartz.dart';
import '../../../../core/contracts/use_case.dart';
import '../../../../core/errors/failures.dart';
import '../../login_exports.dart';

class AuthenticateUser implements UseCase<bool, LoginCredentialsParams> {
  final LoginRepository _userAuthenticationRepository;

  AuthenticateUser({required LoginRepository loginRepository})
      : _userAuthenticationRepository = loginRepository;
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
