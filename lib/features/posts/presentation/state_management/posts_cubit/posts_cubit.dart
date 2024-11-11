import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';

part 'posts_state.dart';
part 'posts_cubit.freezed.dart';

typedef GetPostsFilters = ({
  String? search,
  String? after,
  String? before,
  List<int>? categories,
});

class PostsCubit extends Cubit<PostsState> {
  final GetPostsPerPage _getPostsPerPage;

  PostsCubit({
    required GetPostsPerPage getPostsPerPage,
  })  : _getPostsPerPage = getPostsPerPage,
        super(const PostsState.initial());

  GetPostsPerPageParams getPostsPerPageParams = GetPostsPerPageParams();

  getFirstPage() async {
    if (_stateIsNotLoading()) {
      emit(const PostsState.loading());

      getPostsPerPageParams = GetPostsPerPageParams();

      final result = await _getPostsPerPage(getPostsPerPageParams);

      result.fold(
        (failure) => emit(PostsState.error(failure)),
        (postsPageResult) => emit(PostsState.loaded(postsPageResult)),
      );
    }
  }

  bool _stateIsNotLoading() =>
      state.maybeWhen(loading: () => false, orElse: () => true);

  getNextPageData({
    String? after,
    String? before,
    List<int>? categories,
    String? search,
  }) async {
    final GetPostsFilters filters = (
      after: after,
      before: before,
      categories: categories,
      search: search,
    );

    if (_stateIsNotLoading()) {
      await _getNextPageData(filters);
    }
  }

  Future<void> _getNextPageData(GetPostsFilters filters) async {
    final previousPage = state.whenOrNull(loaded: (page) => page);

    if (previousPage?.hasNextPage == true) {
      emit(const PostsState.loading());

      getPostsPerPageParams = _increasePageAndSetFilters(filters);

      final result = await _getPostsPerPage(getPostsPerPageParams);

      result.fold(
        (failure) => emit(PostsState.error(failure)),
        (postsPageResult) {
          final allPageResult = PostsPageResult(
            hasNextPage: postsPageResult.hasNextPage,
            posts: (previousPage?.posts ?? []) + postsPageResult.posts,
          );

          emit(PostsState.loaded(allPageResult));
        },
      );
    }
  }

  GetPostsPerPageParams _increasePageAndSetFilters(GetPostsFilters filters) {
    return GetPostsPerPageParams(
      page: getPostsPerPageParams.page + 1,
      search: filters.search,
      after: filters.after,
      before: filters.before,
      categories: filters.categories,
    );
  }
}
