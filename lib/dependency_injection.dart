import 'package:get_it/get_it.dart';
import 'package:wordpress_companion/features/media/media_injections.dart';
import 'package:wordpress_companion/features/site_settings/site_settings_injection.dart';
import 'core/utils/dio_generator.dart';
import 'features/login/login_dependency_inj.dart';
import 'features/profile/profile_injection.dart';

// FIXME: refactor injections

class DependencyInjection {
  final GetIt getIt;

  DependencyInjection({required this.getIt});

  Future<void> init() async {
    _initDio();
    await initLoginInjection(getIt);
    await initProfileInjection(getIt);
    await initSiteSettingsInjections(getIt);
    await initMediaInjections(getIt);
  }

  _initDio() {
    getIt.registerLazySingleton(
      () => DioGenerator.generateDioWithDefaultSettings(),
    );
  }
}
