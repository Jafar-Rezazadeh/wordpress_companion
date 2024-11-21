import 'package:get_it/get_it.dart';
import 'package:wordpress_companion/core/services/tags_service.dart';
import 'package:wordpress_companion/features/tags/application/tags_service_impl.dart';
import 'package:wordpress_companion/features/tags/tags_exports.dart';

initTagsInjections(GetIt getIt) {
  // data sources
  final tagsRemoteDataSource = TagsRemoteDataSourceImpl(dio: getIt());

  // repositories
  final tagsRepository =
      TagsRepositoryImpl(tagsRemoteDataSource: tagsRemoteDataSource);

  // Application
  getIt.registerLazySingleton<TagsService>(
    () => TagsServiceImpl(
      createTag: CreateTag(tagsRepository: tagsRepository),
      getTagsByIds: GetTagsByIds(tagsRepository: tagsRepository),
      searchTag: SearchTag(tagsRepository: tagsRepository),
    ),
  );
}
