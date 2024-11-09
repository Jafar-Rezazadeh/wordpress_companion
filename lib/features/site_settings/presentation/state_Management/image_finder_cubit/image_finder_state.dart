part of 'image_finder_cubit.dart';

@freezed
class ImageFinderState with _$ImageFinderState {
  const factory ImageFinderState.initial() = _Initial;
  const factory ImageFinderState.finding() = _Finding;
  const factory ImageFinderState.imageFound(MediaEntity image) = _ImageFound;
  const factory ImageFinderState.error(Failure failure) = _Error;
}
