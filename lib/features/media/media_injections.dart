import 'package:get_it/get_it.dart';
import 'package:wordpress_companion/core/services/media_service.dart';
import 'package:wordpress_companion/features/media/application/media_service_impl.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

initMediaInjections(GetIt getIt) {
  // Data Sources
  final mediaRemoteDataSource = MediaRemoteDataSourceImpl(dio: getIt());

  // Repositories
  final mediaRepository = MediaRepositoryImpl(
    mediaRemoteDataSource: mediaRemoteDataSource,
  );

  // Cubits
  getIt.registerFactory(
    () => MediaCubit(
      deleteMedia: DeleteMedia(mediaRepository: mediaRepository),
      getMediaPerPage: GetMediaPerPage(mediaRepository: mediaRepository),
      updateMedia: UpdateMedia(mediaRepository: mediaRepository),
    ),
  );
  getIt.registerFactory(
    () => UploadMediaCubit(
      uploadMedia: UploadMedia(mediaRepository: mediaRepository),
      cancelMediaUpload: CancelMediaUpload(mediaRepository: mediaRepository),
    ),
  );

  // Application
  getIt.registerLazySingleton<MediaService>(
    () => MediaServiceImpl(
      getMediaPerPage: GetMediaPerPage(mediaRepository: mediaRepository),
      getSingleMedia: GetSingleMedia(mediaRepository: mediaRepository),
    ),
  );

  getIt.registerFactory(() => ImageListCubit(mediaService: getIt()));
}
