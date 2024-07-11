import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wordpress_companion/features/user-login/data/data_sources/wordpress_remote_data_source/wordpress_remote_data_source.dart';
import 'package:wordpress_companion/features/user-login/domain/usecases/authenticate_user.dart';

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
