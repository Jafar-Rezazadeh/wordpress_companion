import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:wordpress_companion/core/data/wordpress_remote_data_source/wordpress_remote_data_source_impl.dart';

void main() {
  late WordpressRemoteDataSourceImpl wordpressRemoteDataSourceImpl;
  late Dio dio;
  late DioAdapter dioAdapter;
  const exampleDomain = "https://example.com";
  const wpV2EndPoint = "wp-json/wp/v2";

  setUp(
    () {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio);
      wordpressRemoteDataSourceImpl = WordpressRemoteDataSourceImpl(dio: dio);
    },
  );

  group(
    "authenticateUser -",
    () {
      test(
        "should throw (DioException with 401 status code) when authentication is unsuccessful",
        () async {
          //arrange
          dioAdapter.onGet(
            "$exampleDomain/$wpV2EndPoint/settings/",
            (server) => server.reply(
              HttpStatus.unauthorized,
              null,
            ),
          );

          //act
          final result = wordpressRemoteDataSourceImpl.authenticateUser(
            (name: "name", applicationPassword: "1234", domain: exampleDomain),
          );

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
        },
      );
      test(
        "should return (true) when authentication is successful",
        () async {
          //arrange
          dioAdapter.onGet(
            "$exampleDomain/$wpV2EndPoint/settings/",
            (server) => server.reply(200, null),
          );

          //act
          final result = await wordpressRemoteDataSourceImpl.authenticateUser(
            (name: "name", applicationPassword: "1234", domain: exampleDomain),
          );

          //assert
          expect(result, true);
        },
      );
    },
  );
}
