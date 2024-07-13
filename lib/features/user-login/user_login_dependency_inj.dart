import 'package:wordpress_companion/dependency_injection.dart';

import 'package:wordpress_companion/features/user-login/user_login_exports.dart';

userLoginDependencyInjection() async {
  // data sources
  getIt.registerLazySingleton<WordpressRemoteDataSource>(
    () => WordpressRemoteDataSourceImpl(dio: getIt()),
  );
  getIt.registerLazySingletonAsync<LocalUserLoginDataSource>(
    () => LocalUserLoginDataSourceImpl.instance(),
  );
  await getIt.isReady<LocalUserLoginDataSource>();

  // repository
  getIt.registerLazySingleton<UserLoginRepository>(
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
    ),
  );
}
