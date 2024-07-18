import 'package:wordpress_companion/core/utils/injected_dio_options_handler.dart';
import 'package:wordpress_companion/dependency_injection.dart';

import 'package:wordpress_companion/features/login/login_exports.dart';

userLoginDependencyInjection() async {
  // data sources
  getIt.registerLazySingleton<WordpressRemoteDataSource>(
    () => WordpressRemoteDataSourceImpl(dio: getIt()),
  );
  getIt.registerLazySingletonAsync<LocalLoginDataSource>(
    () => LocalLoginDataSourceImpl.instance(),
  );
  await getIt.isReady<LocalLoginDataSource>();

  // repository
  getIt.registerLazySingleton<LoginRepository>(
    () => UserLoginRepositoryImpl(
      wordpressRemoteDataSource: getIt(),
      localUserLoginDataSource: getIt(),
    ),
  );

  // usecases
  getIt.registerLazySingleton(() => AuthenticateUser(userLoginRepository: getIt()));
  getIt.registerLazySingleton(() => SaveUserCredentials(userLoginRepository: getIt()));
  getIt.registerLazySingleton(() => GetLastLoginCredentials(userLoginRepository: getIt()));

  // cubit
  getIt.registerFactory(
    () => LoginCubit(
      authenticateUser: getIt(),
      saveUserCredentials: getIt(),
      getLastLoginCredentials: getIt(),
      injectedDioOptionsHandler: InjectedDioOptionsHandler(getItInstance: getIt),
    ),
  );
}
