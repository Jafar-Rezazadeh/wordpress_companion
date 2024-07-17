import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/user-login/user_login_exports.dart';

class SaveUserCredentials implements UseCase<LoginCredentialsEntity, LoginCredentialsParams> {
  final UserLoginRepository _userLoginRepository;

  SaveUserCredentials({required UserLoginRepository userLoginRepository})
      : _userLoginRepository = userLoginRepository;
  @override
  Future<Either<Failure, LoginCredentialsEntity>> call(LoginCredentialsParams params) async {
    return await _userLoginRepository.saveCredentials(params);
  }
}
