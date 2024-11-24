import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';

part 'posts_state.dart';
part 'posts_cubit.freezed.dart';

class PostsCubit extends Cubit<PostsState> {
  final GetPostsPerPage _getPostsPerPage;
  final DeletePost _deletePost;
  final CreatePost _createPost;
  final UpdatePost _updatePost;

  PostsCubit({
    required GetPostsPerPage getPostsPerPage,
    required DeletePost deletePost,
    required CreatePost createPost,
    required UpdatePost updatePost,
  })  : _getPostsPerPage = getPostsPerPage,
        _deletePost = deletePost,
        _createPost = createPost,
        _updatePost = updatePost,
        super(const PostsState.initial());

  GetPostsPerPageParams getPostsPerPageParams = GetPostsPerPageParams();

  getFirstPage(GetPostsFilters filters) async {
    if (_stateIsNotLoading()) {
      emit(const PostsState.loading());

      getPostsPerPageParams = _setFiltersToParams(filters);

      final result = await _getPostsPerPage(getPostsPerPageParams);

      result.fold(
        (failure) => emit(PostsState.error(failure)),
        (postsPageResult) => emit(PostsState.loaded(postsPageResult)),
      );
    }
  }

  GetPostsPerPageParams _setFiltersToParams(GetPostsFilters filters) {
    return GetPostsPerPageParams(
      search: filters.search,
      after: filters.after,
      before: filters.before,
      categories: filters.categories,
      status: filters.status,
    );
  }

  bool _stateIsNotLoading() =>
      state.maybeWhen(loading: () => false, orElse: () => true);

  getNextPageData(GetPostsFilters filters) async {
    if (_stateIsNotLoading()) {
      await _getNextPageData(filters);
    }
  }

  Future<void> _getNextPageData(GetPostsFilters filters) async {
    final previousPage = state.whenOrNull(loaded: (page) => page);

    if (previousPage?.hasNextPage == true) {
      emit(const PostsState.loading());

      getPostsPerPageParams = getPostsPerPageParams.copyWith(
        page: getPostsPerPageParams.page + 1,
        search: filters.search,
        after: filters.after,
        before: filters.before,
        categories: filters.categories,
        status: filters.status,
      );

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

  deletePost(int id) async {
    if (_stateIsNotLoading()) {
      emit(const PostsState.loading());

      final result = await _deletePost(id);

      result.fold(
        (failure) => emit(PostsState.error(failure)),
        (deletedPost) => emit(const PostsState.needRefresh()),
      );
    }
  }

  createPosts(PostParams postParams) async {
    if (_stateIsNotLoading()) {
      emit(const PostsState.loading());

      final result = await _createPost(postParams);

      result.fold(
        (failure) => emit(PostsState.error(failure)),
        (createdPost) => emit(const PostsState.needRefresh()),
      );
    }
  }

  updatePosts(PostParams postParams) async {
    if (_stateIsNotLoading()) {
      emit(const PostsState.loading());

      final result = await _updatePost(postParams);

      result.fold(
        (failure) => emit(PostsState.error(failure)),
        (updatedPost) => emit(const PostsState.needRefresh()),
      );
    }
  }
}
