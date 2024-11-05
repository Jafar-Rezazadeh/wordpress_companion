import 'package:dartz/dartz.dart';
import '../../../../core/contracts/use_case.dart';
import '../../../../core/errors/failures.dart';
import '../../login_exports.dart';

class SaveUserCredentials
    implements UseCase<LoginCredentialsEntity, LoginCredentialsParams> {
  final LoginRepository _userLoginRepository;

  SaveUserCredentials({required LoginRepository loginRepository})
      : _userLoginRepository = loginRepository;
  @override
  Future<Either<Failure, LoginCredentialsEntity>> call(
      LoginCredentialsParams params) async {
    return await _userLoginRepository.saveCredentials(params);
  }
}
