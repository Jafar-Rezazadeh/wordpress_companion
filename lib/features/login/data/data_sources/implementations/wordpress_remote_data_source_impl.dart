import 'dart:io';

import 'package:dio/dio.dart';
import '../../../login_exports.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/encoder.dart';

class WordpressRemoteDataSourceImpl implements WordpressRemoteDataSource {
  final Dio _dio;

  WordpressRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<bool> authenticateUser(LoginCredentialsParams params) async {
    final response = await _dio.get(
      "${params.domain + wpV2EndPoint}/users/me",
      options: Options(headers: _header(params)),
    );

    return response.statusCode == HttpStatus.ok;
  }

  Map<String, dynamic> _header(LoginCredentialsParams params) {
    return {
      "Authorization": CustomEncoder.base64Encode(
        name: params.name,
        password: params.applicationPassword,
      ),
    };
  }
}
