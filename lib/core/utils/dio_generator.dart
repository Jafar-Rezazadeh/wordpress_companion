import 'dart:io';

import 'package:dio/dio.dart';

class DioGenerator {
  static Dio generateDioWithDefaultSettings() {
    final dio = Dio();

    dio.options.headers.addAll({
      HttpHeaders.contentTypeHeader: "application/json",
    });
    dio.options.queryParameters.addAll(
      {
        "context": "edit",
      },
    );

    // just for testing to skip bad cert
    // (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
    //     (client) {
    //   client.badCertificateCallback = (cert, String host, int port) => true;
    //   return client;
    // };

    return dio;
  }
}
