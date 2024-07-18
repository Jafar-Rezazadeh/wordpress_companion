import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/login/login_exports.dart';

class SaveUserCredentials implements UseCase<LoginCredentialsEntity, LoginCredentialsParams> {
  final LoginRepository _userLoginRepository;

  SaveUserCredentials({required LoginRepository userLoginRepository})
      : _userLoginRepository = userLoginRepository;
  @override
  Future<Either<Failure, LoginCredentialsEntity>> call(LoginCredentialsParams params) async {
    return await _userLoginRepository.saveCredentials(params);
  }
}
