import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/core/services/tags_service.dart';

import '../../../../tags/tags_exports.dart';

part 'tags_state.dart';
part 'tags_cubit.freezed.dart';

class TagsCubit extends Cubit<TagsState> {
  final TagsService _tagsService;

  TagsCubit({
    required TagsService tagsService,
  })  : _tagsService = tagsService,
        super(const TagsState.initial());

  createTag(String name) async {
    emit(const TagsState.loading());

    final result = await _tagsService.createTag(name);
    result.fold(
      (failure) => emit(TagsState.error(failure)),
      (tag) => emit(TagsState.created(tag)),
    );
  }

  getTagsByIds(List<int> ids) async {
    emit(const TagsState.loading());

    final result = await _tagsService.getTagsByIds(ids);

    result.fold(
      (failure) => emit(TagsState.error(failure)),
      (tags) => emit(TagsState.tagsByIds(tags)),
    );
  }

  searchTag(String value) async {
    if (isNotSearching()) {
      emit(const TagsState.searching());

      final result = await _tagsService.searchTag(value);

      result.fold(
        (failure) => emit(TagsState.error(failure)),
        (resultTags) => emit(TagsState.searchResult(resultTags)),
      );
    }
  }

  bool isNotSearching() =>
      state.maybeWhen(searching: () => false, orElse: () => true);
}
