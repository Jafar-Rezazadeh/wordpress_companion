import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/user-login/user_login_exports.dart';

class UserAuthenticationRepositoryImpl implements UserAuthenticationRepository {
  final WordpressRemoteDataSource _wordpressRemoteDataSource;

  UserAuthenticationRepositoryImpl({required WordpressRemoteDataSource wordpressRemoteDataSource})
      : _wordpressRemoteDataSource = wordpressRemoteDataSource;

  @override
  Future<Either<Failure, bool>> authenticateUser(UserAuthenticationParams params) async {
    try {
      final result = await _wordpressRemoteDataSource.authenticateUser(params);

      return right(result);
    } on DioException catch (e, t) {
      return left(
        ServerFailure(
          message: "${e.message} \n $t",
          response: e.response,
        ),
      );
    } catch (e, t) {
      return left(UnknownFailure(message: "$e \n\n $t}"));
    }
  }
}
