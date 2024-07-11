import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:wordpress_companion/features/user-login/data/data_sources/wordpress_remote_data_source/wordpress_remote_data_source_impl.dart';
import 'package:wordpress_companion/features/user-login/domain/usecases/authenticate_user.dart';

void main() {
  late WordpressRemoteDataSourceImpl wordpressRemoteDataSourceImpl;
  late Dio dio;
  late DioAdapter dioAdapter;
  const exampleDomain = "https://example.com";
  const wpV2EndPoint = "wp-json/wp/v2";
  const UserAuthenticationParams userAuthenticationParams =
      (name: "test", applicationPassword: "qth0 TUwn HrMP EMNm b6MM NvR0", domain: exampleDomain);

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
          final result = wordpressRemoteDataSourceImpl.authenticateUser(userAuthenticationParams);

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
        "should return (true) when authentication is successful with 200 status code",
        () async {
          //arrange
          dioAdapter.onGet(
            "$exampleDomain/$wpV2EndPoint/settings/",
            headers: {
              "Authorization": "Basic dGVzdDpxdGgwIFRVd24gSHJNUCBFTU5tIGI2TU0gTnZSMA==",
            },
            (server) => server.reply(200, null),
          );

          //act
          final result =
              await wordpressRemoteDataSourceImpl.authenticateUser(userAuthenticationParams);

          //assert
          expect(result, true);
        },
      );

      test(
        "should return (false) when authentication is unsuccessful without 200 status code",
        () async {
          //arrange
          dioAdapter.onGet(
            "$exampleDomain/$wpV2EndPoint/settings/",
            (server) => server.reply(201, null),
          );

          //act
          final result =
              await wordpressRemoteDataSourceImpl.authenticateUser(userAuthenticationParams);

          //assert
          expect(result, false);
        },
      );
    },
  );
}
