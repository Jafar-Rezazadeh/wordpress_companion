import 'package:get_it/get_it.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';

initPostsInjections(GetIt getIt) {
  // data
  final postsRemoteDataSource = PostsRemoteDataSourceImpl(dio: getIt());

  // repositories
  final postsRepository =
      PostsRepositoryImpl(postsRemoteDataSource: postsRemoteDataSource);

  // cubits
  getIt.registerFactory(
    () => PostsCubit(
      getPostsPerPage: GetPostsPerPage(postsRepository: postsRepository),
      deletePost: DeletePost(postsRepository: postsRepository),
      createPost: CreatePost(postsRepository: postsRepository),
      updatePost: UpdatePost(postsRepository: postsRepository),
    ),
  );
  getIt.registerFactory(
    () => TagsCubit(tagsService: getIt()),
  );
}
