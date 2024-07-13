import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/user-login/user_login_exports.dart';

class SaveUserCredentials implements UseCase<UserCredentialsEntity, UserCredentialsParams> {
  final UserLoginRepository _userLoginRepository;

  SaveUserCredentials({required UserLoginRepository userLoginRepository})
      : _userLoginRepository = userLoginRepository;
  @override
  Future<Either<Failure, UserCredentialsEntity>> call(UserCredentialsParams params) async {
    return await _userLoginRepository.saveCredentials(params);
  }
}
