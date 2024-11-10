import 'package:dio/dio.dart';
import 'package:wordpress_companion/core/core_export.dart';

import '../../../posts_exports.dart';

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final Dio _dio;

  PostsRemoteDataSourceImpl({required Dio dio}) : _dio = dio;
  @override
  Future<PostModel> createPost(PostParams params) {
    // TODO: implement createPost
    throw UnimplementedError();
  }

  @override
  Future<PostModel> deletePost(int id) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<PostsPageResult> getPostsPerPage(GetPostsPerPageParams params) async {
    final response = await _dio.get(
      "$wpV2EndPoint/posts",
      queryParameters: {
        "page": params.page,
        "per_page": params.perPage,
        if (params.search != null) "search": params.search,
        if (params.after != null) "after": params.after,
        if (params.before != null) "before": params.before,
        if (params.categories != null)
          "categories": params.categories?.join(","),
      },
    );
    final jsonData = ApiResponseHandler.convertToJsonList(response.data);

    final totalPages = int.parse(
      response.headers["x-wp-totalpages"]?.first ?? "0",
    );

    final posts = jsonData.map((e) => PostModel.fromJson(e)).toList();

    final hasNextPage = params.page < totalPages;

    return PostsPageResult(hasNextPage: hasNextPage, posts: posts);
  }

  @override
  Future<PostModel> updatePost(PostParams params) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
