import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/core/utils/encoder.dart';
import 'package:wordpress_companion/features/login/data/data_sources/implementations/wordpress_remote_data_source_impl.dart';
import 'package:wordpress_companion/features/login/domain/use_cases/authenticate_user.dart';

void main() {
  late WordpressRemoteDataSourceImpl wordpressRemoteDataSourceImpl;
  late Dio dio;
  late DioAdapter dioAdapter;
  const exampleDomain = "https://myexample.com";
  const LoginCredentialsParams userAuthenticationParams = (
    name: "test",
    applicationPassword: "qth0 TUwn HrMP EMNm b6MM NvR0",
    domain: exampleDomain,
    rememberMe: true
  );

  setUp(
    () {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio, printLogs: true);
      wordpressRemoteDataSourceImpl = WordpressRemoteDataSourceImpl(dio: dio);
    },
  );

  group("authenticateUser -", () {
    test(
        "should throw (DioException with 401 status code) when authentication is unsuccessful",
        () async {
      //arrange
      dioAdapter.onGet(
        "${exampleDomain + wpV2EndPoint}/users/me",
        (server) => server.reply(
          HttpStatus.unauthorized,
          null,
        ),
      );

      //act
      final result = wordpressRemoteDataSourceImpl
          .authenticateUser(userAuthenticationParams);

      //assert
      expect(
        result,
        throwsA(
          isA<DioException>().having(
            (dioException) => dioException.response?.statusCode == 401,
            "is status code 401 unauthorized",
            true,
          ),
        ),
      );
    });

    test(
        "should return (true) when authentication is successful with 200 status code",
        () async {
      //arrange
      dioAdapter.onGet(
        "${exampleDomain + wpV2EndPoint}/users/me",
        headers: {
          "Authorization": CustomEncoder.base64Encode(
              name: userAuthenticationParams.name,
              password: userAuthenticationParams.applicationPassword),
        },
        (server) => server.reply(200, null),
      );

      //act
      final result = await wordpressRemoteDataSourceImpl
          .authenticateUser(userAuthenticationParams);

      //assert
      expect(result, true);
    });

    test(
        "should return (false) when authentication is unsuccessful without 200 status code",
        () async {
      //arrange
      dioAdapter.onGet(
        "${exampleDomain + wpV2EndPoint}/users/me",
        (server) => server.reply(201, null),
      );

      //act
      final result = await wordpressRemoteDataSourceImpl
          .authenticateUser(userAuthenticationParams);

      //assert
      expect(result, false);
    });
  });
}
