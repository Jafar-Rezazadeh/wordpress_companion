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
        // FIXME: there is a side effect here the function lies on the name
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

  // FIXME: this is not a good solution Make a class that handles this and call it in logic holder
  void _setDioOptions(UserCredentialsParams params) {
    getIt.get<Dio>().options
      ..baseUrl = params.domain
      ..headers.addAll(
        {
          "Authorization":
              makeBase64Encode(name: params.name, password: params.applicationPassword),
        },
      );
  }

  @override
  Future<Either<Failure, LoginCredentialsEntity>> saveCredentials(
      UserCredentialsParams params) async {
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

      // FIXME: side effect here too
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
