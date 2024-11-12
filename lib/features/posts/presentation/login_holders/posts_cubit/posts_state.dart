part of 'posts_cubit.dart';

@freezed
class PostsState with _$PostsState {
  const factory PostsState.initial() = _Initial;
  const factory PostsState.loading() = _Loading;
  const factory PostsState.loaded(PostsPageResult postsPageResult) = _Loaded;
  const factory PostsState.needRefresh() = _NeedRefresh;
  const factory PostsState.error(Failure failure) = _Error;
}
