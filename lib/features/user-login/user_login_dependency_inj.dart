import 'package:wordpress_companion/dependency_injection.dart';

import 'package:wordpress_companion/features/user-login/user_login_exports.dart';

userLoginDependencyInjection() {
  // data sources
  getIt.registerLazySingleton<WordpressRemoteDataSource>(
    () => WordpressRemoteDataSourceImpl(dio: getIt()),
  );
  getIt.registerLazySingleton<LocalUserLoginDataSource>(() => LocalUserLoginDataSourceImpl());

  // repository
  getIt.registerLazySingleton<UserLoginRepository>(
    () => UserLoginRepositoryImpl(
      wordpressRemoteDataSource: getIt(),
      localUserLoginDataSource: getIt(),
    ),
  );

  // usecases
  getIt.registerLazySingleton(() => AuthenticateUser(userAuthenticationRepository: getIt()));

  // cubit
  getIt.registerFactory(() => LoginCubit(authenticateUser: getIt()));
}
