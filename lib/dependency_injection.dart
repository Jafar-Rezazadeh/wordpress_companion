import 'package:get_it/get_it.dart';
import 'package:wordpress_companion/core/utils/dio_generator.dart';
import 'package:wordpress_companion/features/login/login_dependency_inj.dart';
import 'package:wordpress_companion/features/profile/profile_injection.dart';

class DependencyInjection {
  final GetIt getIt;

  DependencyInjection({required this.getIt});

  Future<void> init() async {
    _initDio();
    await initLoginInjection(getIt);
    await initProfileInjection(getIt);
  }

  _initDio() {
    getIt.registerLazySingleton(
      () => DioGenerator.generateDioWithDefaultSettings(),
    );
  }
}
