part of 'tags_cubit.dart';

@freezed
class TagsState with _$TagsState {
  const factory TagsState.initial() = _Initial;
  const factory TagsState.loading() = _Loading;
  const factory TagsState.tagsByIds(List<TagEntity> tags) = _TagsByIds;
  const factory TagsState.created(TagEntity tag) = _Created;
  const factory TagsState.searching() = _Searching;
  const factory TagsState.searchResult(List<TagEntity> tags) = _SearchResult;
  const factory TagsState.error(Failure failure) = _Error;
}
