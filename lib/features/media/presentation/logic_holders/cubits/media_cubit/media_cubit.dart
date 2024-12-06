import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

import '../../../../../../core/errors/failures.dart';

part 'media_state.dart';
part 'media_cubit.freezed.dart';

class MediaCubit extends Cubit<MediaState> {
  final DeleteMedia _deleteMedia;
  final GetMediaPerPage _getMediaPerPage;
  final UpdateMedia _updateMedia;

  MediaCubit({
    required DeleteMedia deleteMedia,
    required GetMediaPerPage getMediaPerPage,
    required UpdateMedia updateMedia,
  })  : _deleteMedia = deleteMedia,
        _getMediaPerPage = getMediaPerPage,
        _updateMedia = updateMedia,
        super(const MediaState.initial());

  deleteMedia(int id) async {
    emit(const MediaState.loading());

    final result = await _deleteMedia(id);

    result.fold(
      (failure) => emit(MediaState.error(failure)),
      (isDeleted) => emit(MediaState.deleted(isDeleted)),
    );
  }

  updateMedia(UpdateMediaParams params) async {
    emit(const MediaState.loading());

    final result = await _updateMedia(params);

    result.fold(
      (failure) => emit(MediaState.error(failure)),
      (updatedMedia) => emit(const MediaState.updated()),
    );
  }

  // TODO: put the page increment logic here and only get other logic
  getMediaPerPage(GetMediaPerPageParams params) async {
    if (_isNotInLoadingState()) {
      emit(const MediaState.loading());

      final result = await _getMediaPerPage(params);

      result.fold(
        (failure) => emit(MediaState.error(failure)),
        (currentPageData) => emit(MediaState.loaded(currentPageData)),
      );
    }
  }

  bool _isNotInLoadingState() => state.whenOrNull(loading: () => true) != true;
}
