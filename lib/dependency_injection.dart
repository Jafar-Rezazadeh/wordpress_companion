import 'package:get_it/get_it.dart';
import 'package:wordpress_companion/core/utils/dio_generator.dart';
import 'package:wordpress_companion/features/login/login_dependency_inj.dart';

GetIt getIt = GetIt.instance;

initializeDependencyInjections() async {
  _initDio();
  await userLoginDependencyInjection();
}

_initDio() {
  getIt.registerLazySingleton(
    () => DioGenerator.generateDioWithDefaultSettings(),
  );
}
