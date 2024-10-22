import 'package:get_it/get_it.dart';
import '../../core/services/profile_service.dart';
import 'data/repositories/profile_repository_impl.dart';
import 'profile_exports.dart';

initProfileInjection(GetIt getIt) {
  // data sources
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(dio: getIt()),
  );

  // repositories
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(profileRemoteDataSource: getIt()),
  );

  // cubits
  getIt.registerFactory(
    () => ProfileCubit(
      getMyProfile: GetMyProfile(profileRepository: getIt()),
      updateMyProfile: UpdateMyProfile(profileRepository: getIt()),
    ),
  );

  // Service
  getIt.registerLazySingleton<ProfileService>(
    () => ProfileServiceImpl(
      getMyProfile: GetMyProfile(profileRepository: getIt()),
    ),
  );
}
