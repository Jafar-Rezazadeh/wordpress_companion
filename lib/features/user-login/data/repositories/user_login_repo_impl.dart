import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/user-login/user_login_exports.dart';

class UserLoginRepositoryImpl implements UserLoginRepository {
  final WordpressRemoteDataSource _wordpressRemoteDataSource;
  final LocalUserLoginDataSource _localUserLoginDataSource;

  UserLoginRepositoryImpl({
    required WordpressRemoteDataSource wordpressRemoteDataSource,
    required LocalUserLoginDataSource localUserLoginDataSource,
  })  : _wordpressRemoteDataSource = wordpressRemoteDataSource,
        _localUserLoginDataSource = localUserLoginDataSource;

  @override
  Future<Either<Failure, bool>> authenticateUser(LoginCredentialsParams params) async {
    try {
      final isValidUser = await _wordpressRemoteDataSource.authenticateUser(params);

      return right(isValidUser);
    } on DioException catch (e, t) {
      return left(
        ServerFailure(
          message: e.message.toString(),
          response: e.response,
          stackTrace: t,
        ),
      );
    } catch (e, t) {
      return left(
        UnknownFailure(message: e.toString(), stackTrace: t),
      );
    }
  }

  @override
  Future<Either<Failure, LoginCredentialsEntity>> saveCredentials(
      LoginCredentialsParams params) async {
    try {
      final LoginCredentialsEntity userCredentials =
          await _localUserLoginDataSource.saveCredentials(params);

      return right(userCredentials);
    } catch (e, t) {
      return left(
        AppFailure(message: e.toString(), stackTrace: t),
      );
    }
  }

  @override
  Future<Either<Failure, LoginCredentialsEntity>> getLastLoginCredentials() async {
    try {
      final LoginCredentialsEntity userCredentials =
          await _localUserLoginDataSource.getLastCredentials();

      return right(userCredentials);
    } catch (e, t) {
      return left(AppFailure(message: e.toString(), stackTrace: t));
    }
  }
}
