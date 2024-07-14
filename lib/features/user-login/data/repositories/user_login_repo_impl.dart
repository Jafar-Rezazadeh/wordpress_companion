import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/dependency_injection.dart';
import 'package:wordpress_companion/features/user-login/user_login_exports.dart';

import '../../../../core/constants/constants.dart';

class UserLoginRepositoryImpl implements UserLoginRepository {
  final WordpressRemoteDataSource _wordpressRemoteDataSource;
  final LocalUserLoginDataSource _localUserLoginDataSource;

  UserLoginRepositoryImpl({
    required WordpressRemoteDataSource wordpressRemoteDataSource,
    required LocalUserLoginDataSource localUserLoginDataSource,
  })  : _wordpressRemoteDataSource = wordpressRemoteDataSource,
        _localUserLoginDataSource = localUserLoginDataSource;

  @override
  Future<Either<Failure, bool>> authenticateUser(UserCredentialsParams params) async {
    try {
      final isValidUser = await _wordpressRemoteDataSource.authenticateUser(params);

      if (isValidUser) {
        _setDioOptions(params);
      }

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

  void _setDioOptions(UserCredentialsParams params) {
    getIt.get<Dio>().options
      ..baseUrl = params.domain
      ..headers.addAll(
        {
          "Authorization": makeBase64Encode(params.name, params.applicationPassword),
        },
      );
  }

  @override
  Future<Either<Failure, UserCredentialsEntity>> saveCredentials(
      UserCredentialsParams params) async {
    try {
      final UserCredentialsEntity userCredentials =
          await _localUserLoginDataSource.saveCredentials(params);

      return right(userCredentials);
    } catch (e, t) {
      return left(
        AppFailure(message: e.toString(), stackTrace: t),
      );
    }
  }

  @override
  Future<Either<Failure, UserCredentialsEntity>> getLastLoginCredentials() async {
    try {
      final UserCredentialsEntity userCredentials =
          await _localUserLoginDataSource.getLastCredentials();

      _setDioOptions((
        name: userCredentials.userName,
        applicationPassword: userCredentials.applicationPassword,
        domain: userCredentials.domain,
        rememberMe: true
      ));

      return right(userCredentials);
    } catch (e, t) {
      return left(AppFailure(message: e.toString(), stackTrace: t));
    }
  }
}
