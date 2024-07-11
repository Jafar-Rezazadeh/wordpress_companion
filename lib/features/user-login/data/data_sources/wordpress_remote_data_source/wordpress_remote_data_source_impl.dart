import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wordpress_companion/features/user-login/user_login_exports.dart';

import '../../../../../core/constants/constants.dart';

class WordpressRemoteDataSourceImpl implements WordpressRemoteDataSource {
  final Dio _dio;

  WordpressRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<bool> authenticateUser(UserAuthenticationParams params) async {
    final response = await _dio.get(
      "${params.domain}/$wpV2EndPoint/settings/",
      options: Options(
        headers: {
          "Authorization":
              "Basic ${base64.encode(utf8.encode("${params.name}:${params.applicationPassword}"))}",
        },
      ),
    );

    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }
}
