import 'package:get_it/get_it.dart';
import 'package:wordpress_companion/features/site_settings/site_settings_injection.dart';
import 'core/utils/dio_generator.dart';
import 'features/login/login_dependency_inj.dart';
import 'features/profile/profile_injection.dart';

class DependencyInjection {
  final GetIt getIt;

  DependencyInjection({required this.getIt});

  Future<void> init() async {
    _initDio();
    await initLoginInjection(getIt);
    await initProfileInjection(getIt);
    await initSiteSettingsInjections(getIt);
  }

  _initDio() {
    getIt.registerLazySingleton(
      () => DioGenerator.generateDioWithDefaultSettings(),
    );
  }
}
