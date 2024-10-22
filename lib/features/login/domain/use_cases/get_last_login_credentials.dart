import 'package:dartz/dartz.dart';
import '../../../../core/contracts/use_case.dart';
import '../../../../core/errors/failures.dart';
import '../../login_exports.dart';

class GetLastLoginCredentials
    implements UseCase<LoginCredentialsEntity, NoParams> {
  final LoginRepository _userLoginRepository;

  GetLastLoginCredentials({required LoginRepository userLoginRepository})
      : _userLoginRepository = userLoginRepository;
  @override
  Future<Either<Failure, LoginCredentialsEntity>> call(NoParams params) async {
    return await _userLoginRepository.getLastLoginCredentials();
  }
}
