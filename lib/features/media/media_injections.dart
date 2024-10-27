import 'package:get_it/get_it.dart';
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
}
