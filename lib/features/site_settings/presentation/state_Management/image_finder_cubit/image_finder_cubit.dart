import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/core/services/media_service.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

part 'image_finder_state.dart';
part 'image_finder_cubit.freezed.dart';

class ImageFinderCubit extends Cubit<ImageFinderState> {
  final MediaService _mediaService;

  ImageFinderCubit({required MediaService mediaService})
      : _mediaService = mediaService,
        super(const ImageFinderState.initial());

  findImage(int id) async {
    emit(const ImageFinderState.finding());

    final result = await _mediaService.getSingleMedia(id);

    result.fold(
      (failure) => emit(ImageFinderState.error(failure)),
      (media) => emit(ImageFinderState.imageFound(media)),
    );
  }
}
