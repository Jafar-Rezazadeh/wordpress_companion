import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/core_export.dart';

import '../../posts_exports.dart';

class GetPostsPerPage
    implements UseCase<PostsPageResult, GetPostsPerPageParams> {
  final PostsRepository _postsRepository;

  GetPostsPerPage({
    required PostsRepository postsRepository,
  }) : _postsRepository = postsRepository;

  @override
  Future<Either<Failure, PostsPageResult>> call(
    GetPostsPerPageParams params,
  ) async {
    return _postsRepository.getPostsPerPage(params);
  }
}

class GetPostsPerPageParams {
  int page;
  int perPage;
  String? search;
  String? after;
  String? before;
  List<int>? categories;
  List<PostStatus>? status;

  GetPostsPerPageParams({
    this.page = 1,
    this.perPage = 10,
    this.search,
    this.after,
    this.before,
    this.categories,
    this.status,
  })  : assert(page >= 1, "page can't be less than 1"),
        assert(perPage >= 10, "perPage can't be less than 10");

  GetPostsPerPageParams copyWith({
    int? page,
    int? perPage,
    String? search,
    String? after,
    String? before,
    List<int>? categories,
    List<PostStatus>? status,
  }) {
    if (_pageIsLessThan_1(page) || _perPageIsLessThan_10(perPage)) {
      throw AssertionError("page can't be less than 1");
    }

    return GetPostsPerPageParams(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      search: search ?? this.search,
      after: after ?? this.after,
      before: before ?? this.before,
      categories: categories ?? this.categories,
      status: status ?? this.status,
    );
  }

  bool _pageIsLessThan_1(int? page) => page != null && page < 1;

  bool _perPageIsLessThan_10(int? perPage) => perPage != null && perPage < 10;
}
