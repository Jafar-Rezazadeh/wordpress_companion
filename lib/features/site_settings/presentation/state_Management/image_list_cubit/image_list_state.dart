part of 'image_list_cubit.dart';

@freezed
class ImageListState with _$ImageListState {
  const factory ImageListState.initial() = _Initial;
  const factory ImageListState.loading() = _Loading;
  const factory ImageListState.loaded(
    CurrentPageMediasEntity currentPageMedias,
  ) = _Loaded;
  const factory ImageListState.error(Failure failure) = _Error;
}
