import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/user-login/user_login_exports.dart';

class GetLastLoginCredentials implements UseCase<LoginCredentialsEntity, NoParams> {
  final UserLoginRepository _userLoginRepository;

  GetLastLoginCredentials({required UserLoginRepository userLoginRepository})
      : _userLoginRepository = userLoginRepository;
  @override
  Future<Either<Failure, LoginCredentialsEntity>> call(NoParams params) async {
    return await _userLoginRepository.getLastLoginCredentials();
  }
}
