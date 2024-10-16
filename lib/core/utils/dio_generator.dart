import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class DioGenerator {
  static Dio generateDioWithDefaultSettings() {
    final dio = Dio();

    dio.options.queryParameters.addAll(
      {
        "context": "edit",
      },
    );

    //FIXME: Remove this on Production to check bad certificate
    // just for testing
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, String host, int port) => true;
      return client;
    };

    return dio;
  }
}
