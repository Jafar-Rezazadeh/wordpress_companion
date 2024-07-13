import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get_it/get_it.dart';
import 'package:wordpress_companion/features/user-login/user_login_dependency_inj.dart';

GetIt getIt = GetIt.instance;

initializeDependencyInjections() async {
  _initDio();

  await userLoginDependencyInjection();
}

_initDio() {
  getIt.registerLazySingleton(() {
    final dio = Dio();
    //FIXME: Remove this on Production to check bad certificate
    // just for testing
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
      client.badCertificateCallback = (cert, String host, int port) => true;
      return client;
    };
    return dio;
  });
}
