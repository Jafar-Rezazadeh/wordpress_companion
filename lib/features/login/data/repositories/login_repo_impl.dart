import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../login_exports.dart';

class UserLoginRepositoryImpl implements LoginRepository {
  final WordpressRemoteDataSource _wordpressRemoteDataSource;
  final LocalLoginDataSource _localUserLoginDataSource;

  UserLoginRepositoryImpl({
    required WordpressRemoteDataSource wordpressRemoteDataSource,
    required LocalLoginDataSource localUserLoginDataSource,
  })  : _wordpressRemoteDataSource = wordpressRemoteDataSource,
        _localUserLoginDataSource = localUserLoginDataSource;

  @override
  Future<Either<Failure, bool>> authenticateUser(
      LoginCredentialsParams params) async {
    try {
      final isValidUser =
          await _wordpressRemoteDataSource.authenticateUser(params);

      return right(isValidUser);
    } catch (e, s) {
      return left(FailureFactory.createFailure(e, s));
    }
  }

  @override
  Future<Either<Failure, LoginCredentialsEntity>> saveCredentials(
      LoginCredentialsParams params) async {
    try {
      final LoginCredentialsEntity userCredentials =
          await _localUserLoginDataSource.saveCredentials(params);

      return right(userCredentials);
    } catch (e, s) {
      return left(FailureFactory.createFailure(e, s));
    }
  }

  @override
  Future<Either<Failure, LoginCredentialsEntity>>
      getLastLoginCredentials() async {
    try {
      final LoginCredentialsEntity userCredentials =
          await _localUserLoginDataSource.getLastCredentials();

      return right(userCredentials);
    } catch (e, s) {
      return left(FailureFactory.createFailure(e, s));
    }
  }

  @override
  Future<Either<Failure, void>> clearCachedCredentials() async {
    try {
      await _localUserLoginDataSource.clearCachedCredentials();

      return right(null);
    } catch (e, s) {
      return left(FailureFactory.createFailure(e, s));
    }
  }
}
