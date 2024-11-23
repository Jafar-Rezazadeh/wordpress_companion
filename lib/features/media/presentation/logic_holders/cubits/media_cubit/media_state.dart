part of 'media_cubit.dart';

@freezed
class MediaState with _$MediaState {
  const factory MediaState.initial() = _Initial;
  const factory MediaState.loading() = _Loading;
  const factory MediaState.loaded(CurrentPageMedias currentPageMedias) =
      _Loaded;
  const factory MediaState.updated() = _Updated;
  const factory MediaState.deleted(bool isDeleted) = _Deleted;
  const factory MediaState.error(Failure failure) = _Error;
}
