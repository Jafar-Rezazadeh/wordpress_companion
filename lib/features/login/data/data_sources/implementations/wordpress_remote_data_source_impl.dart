import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wordpress_companion/features/login/login_exports.dart';

import '../../../../../core/constants/constants.dart';

class WordpressRemoteDataSourceImpl implements WordpressRemoteDataSource {
  final Dio _dio;

  WordpressRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  String myProfileRoute(String domain) => "$domain/$wpV2EndPoint/users/me";

  @override
  Future<bool> authenticateUser(LoginCredentialsParams params) async {
    final response = await _dio.get(
      myProfileRoute(params.domain),
      options: Options(
        headers: {
          "Authorization": makeBase64Encode(
              name: params.name, password: params.applicationPassword),
        },
      ),
    );

    return response.statusCode == HttpStatus.ok;
  }
}
