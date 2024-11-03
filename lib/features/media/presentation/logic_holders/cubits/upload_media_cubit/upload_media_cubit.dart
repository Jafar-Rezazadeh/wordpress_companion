import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

part 'upload_media_state.dart';
part 'upload_media_cubit.freezed.dart';

class UploadMediaCubit extends Cubit<UploadMediaState> {
  final UploadMedia _uploadMedia;
  final CancelMediaUpload _cancelMediaUpload;

  UploadMediaCubit({
    required UploadMedia uploadMedia,
    required CancelMediaUpload cancelMediaUpload,
  })  : _uploadMedia = uploadMedia,
        _cancelMediaUpload = cancelMediaUpload,
        super(const UploadMediaState.initial());

  uploadMedia(String pathToFile) async {
    final result = await _uploadMedia.call(pathToFile);

    result.fold(
      (failure) => emit(UploadMediaState.error(failure)),
      (uploadMediaResult) {
        emit(UploadMediaState.startingUpload(uploadMediaResult.cancelToken));
        _emitStateByListeningTo(uploadMediaResult.stream);
      },
    );
  }

  void _emitStateByListeningTo(Stream<double> stream) {
    emit(const UploadMediaState.uploading(0));
    stream.listen(
      (progress) => emit(UploadMediaState.uploading(progress)),
      onDone: () => emit(const UploadMediaState.uploaded()),
      cancelOnError: true,
      onError: (error) => emit(
        UploadMediaState.error(
          FailureFactory.createFailure(error, StackTrace.current),
        ),
      ),
    );
  }

  cancelMediaUpload(CancelToken cancelToken) async {
    final result = await _cancelMediaUpload(cancelToken);

    result.fold(
      (failure) => emit(UploadMediaState.error(failure)),
      (_) {},
    );
  }
}
