part of 'upload_media_cubit.dart';

@freezed
class UploadMediaState with _$UploadMediaState {
  const factory UploadMediaState.initial() = _Initial;
  const factory UploadMediaState.uploading(double progress) = _Loading;
  const factory UploadMediaState.uploaded() = _Uploaded;
  const factory UploadMediaState.error(Failure failure) = _Error;
}
