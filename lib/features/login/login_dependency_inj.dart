import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/global_dio_headers_handler.dart';

import 'login_exports.dart';

initLoginInjection(GetIt getIt) async {
  // data sources
  getIt.registerLazySingleton<WordpressRemoteDataSource>(
    () => WordpressRemoteDataSourceImpl(dio: getIt()),
  );
  getIt.registerLazySingletonAsync<LocalLoginDataSource>(
    () async {
      final sharedPref = await SharedPreferences.getInstance();
      return LocalLoginDataSourceImpl.instance(sharedPreferences: sharedPref);
    },
  );
  await getIt.isReady<LocalLoginDataSource>();

  // repository
  getIt.registerLazySingleton<LoginRepository>(
    () => UserLoginRepositoryImpl(
      wordpressRemoteDataSource: getIt(),
      localUserLoginDataSource: getIt(),
    ),
  );

  // use cases
  getIt.registerLazySingleton(
      () => AuthenticateUser(userLoginRepository: getIt()));
  getIt.registerLazySingleton(
      () => SaveUserCredentials(userLoginRepository: getIt()));
  getIt.registerLazySingleton(
      () => GetLastLoginCredentials(userLoginRepository: getIt()));

  // cubit
  getIt.registerFactory(
    () => AuthenticationCubit(
      authenticateUser: getIt(),
      saveUserCredentials: getIt(),
      clearCachedCredentials: ClearCachedCredentials(loginRepository: getIt()),
      globalDioHeadersHandler: GlobalDioHeadersHandler(getItInstance: getIt),
    ),
  );
  getIt.registerFactory(
    () => LoginCredentialsCubit(getLastLoginCredentials: getIt()),
  );
}
