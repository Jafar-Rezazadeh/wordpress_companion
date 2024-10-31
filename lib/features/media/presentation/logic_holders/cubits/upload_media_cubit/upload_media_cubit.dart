import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

part 'upload_media_state.dart';
part 'upload_media_cubit.freezed.dart';

class UploadMediaCubit extends Cubit<UploadMediaState> {
  final UploadMedia _uploadMedia;

  UploadMediaCubit({
    required UploadMedia uploadMedia,
  })  : _uploadMedia = uploadMedia,
        super(const UploadMediaState.initial());

  uploadMedia(String pathToFile) async {
    emit(const UploadMediaState.uploading(0));

    final result = await _uploadMedia.call(pathToFile);

    result.fold(
      (failure) => emit(UploadMediaState.error(failure)),
      (streamProgress) => _emitStateByListeningTo(streamProgress),
    );
  }

  void _emitStateByListeningTo(Stream<double> streamProgress) {
    streamProgress.listen(
      (progress) => emit(UploadMediaState.uploading(progress)),
      onDone: () => emit(const UploadMediaState.uploaded()),
      cancelOnError: true,
      onError: (error) => emit(
        UploadMediaState.error(
            FailureFactory.createFailure(error, StackTrace.current)),
      ),
    );
  }
}
