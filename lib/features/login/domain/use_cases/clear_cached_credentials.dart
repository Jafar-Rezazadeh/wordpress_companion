import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/login/login_exports.dart';

class ClearCachedCredentials implements UseCase<void, NoParams> {
  final LoginRepository _loginRepository;

  ClearCachedCredentials({
    required LoginRepository loginRepository,
  }) : _loginRepository = loginRepository;
  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return _loginRepository.clearCachedCredentials();
  }
}
