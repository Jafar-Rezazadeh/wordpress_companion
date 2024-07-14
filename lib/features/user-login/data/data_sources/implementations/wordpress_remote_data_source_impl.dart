import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wordpress_companion/features/user-login/user_login_exports.dart';

import '../../../../../core/constants/constants.dart';

class WordpressRemoteDataSourceImpl implements WordpressRemoteDataSource {
  final Dio _dio;

  WordpressRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  String getSettingsPath(String domain) => "$domain/$wpV2EndPoint/settings/";

  @override
  Future<bool> authenticateUser(UserCredentialsParams params) async {
    final response = await _dio.get(
      getSettingsPath(params.domain),
      options: Options(
        headers: {
          "Authorization": makeBase64Encode(params.name, params.applicationPassword),
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
