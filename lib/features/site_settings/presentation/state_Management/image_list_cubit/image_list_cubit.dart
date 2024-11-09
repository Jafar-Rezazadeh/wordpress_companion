import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/core/services/media_service.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

part 'image_list_state.dart';
part 'image_list_cubit.freezed.dart';

class ImageListCubit extends Cubit<ImageListState> {
  final MediaService _mediaService;

  ImageListCubit({required MediaService mediaService})
      : _mediaService = mediaService,
        super(const ImageListState.initial());

  late GetMediaPerPageParams _params = _defaultParams();

  GetMediaPerPageParams _defaultParams() {
    return GetMediaPerPageParams(
      page: 1,
      perPage: 100,
    );
  }

  getFirstPageData() async {
    _params = _defaultParams();
    emit(const ImageListState.loading());

    final result = await _mediaService.getMediaPerPage(_params);

    result.fold(
      (failure) => emit(ImageListState.error(failure)),
      (currentPageMedias) {
        emit(ImageListState.loaded(currentPageMedias));
      },
    );
  }

  getNextPageData() async {
    final isNotLoading = state.maybeWhen(
      loading: () => false,
      orElse: () => true,
    );
    if (isNotLoading) {
      await _getData();
    }
  }

  Future<void> _getData() async {
    final perviousPage = state.whenOrNull(
      loaded: (previousPage) => previousPage,
    );

    perviousPage == null
        ? await getFirstPageData()
        : await _getNextPageData(perviousPage);
  }

  Future<void> _getNextPageData(CurrentPageMediasEntity perviousPage) async {
    if (perviousPage.hasNextPage) {
      emit(const ImageListState.loading());

      _params = _params.copyWith(page: _params.page + 1);

      final result = await _mediaService.getMediaPerPage(_params);

      result.fold(
        (failure) => emit(ImageListState.error(failure)),
        (currentPageMedias) {
          final allMedias = CurrentPageMediasEntity(
            hasNextPage: currentPageMedias.hasNextPage,
            medias: perviousPage.medias + currentPageMedias.medias,
          );

          emit(ImageListState.loaded(allMedias));
        },
      );
    }
  }

  searchImage(String value) async {
    if (value.isNotEmpty) {
      emit(const ImageListState.loading());

      _params = GetMediaPerPageParams(page: 1, search: value, perPage: 50);

      final result = await _mediaService.getMediaPerPage(_params);

      result.fold(
        (failure) => emit(ImageListState.error(failure)),
        (currentPageMedias) {
          emit(ImageListState.loaded(currentPageMedias));
        },
      );
    }
  }
}
