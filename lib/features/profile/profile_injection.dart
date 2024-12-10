import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../core/services/profile_service.dart';
import 'data/repositories/profile_repository_impl.dart';
import 'profile_exports.dart';

initProfileInjection(GetIt getIt) {
  // data sources
  final ProfileRemoteDataSource profileRemoteDataSource =
      ProfileRemoteDataSourceImpl(dio: getIt());

  // repositories
  final ProfileRepository profileRepository = ProfileRepositoryImpl(
    profileRemoteDataSource: profileRemoteDataSource,
  );

  // Service
  getIt.registerLazySingleton<ProfileService>(
    () => ProfileServiceImpl(
      getMyProfile: GetMyProfile(profileRepository: profileRepository),
    ),
  );

  // controllers
  Get.lazyPut(
    () => ProfileController(
      getMyProfile: GetMyProfile(profileRepository: profileRepository),
      updateMyProfile: UpdateMyProfile(profileRepository: profileRepository),
    ),
  );
}
