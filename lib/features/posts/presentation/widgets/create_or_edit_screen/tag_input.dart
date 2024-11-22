import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_handy_utils/flutter_handy_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:searchfield/searchfield.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';
import 'package:wordpress_companion/features/tags/tags_exports.dart';

import '../../../../../core/core_export.dart';

class TagInputWidget extends StatefulWidget {
  final List<int> initialTags;
  final Function(List<TagEntity> tags) onChanged;
  const TagInputWidget({
    super.key,
    required this.initialTags,
    required this.onChanged,
  });

  @override
  State<TagInputWidget> createState() => _TagInputWidgetState();
}

class _TagInputWidgetState extends State<TagInputWidget> {
  List<TagEntity> assignedTags = [];
  List<TagEntity> searchResult = [];
  late final TextEditingController textInputController;

  @override
  void initState() {
    super.initState();
    textInputController = TextEditingController();
    context.read<TagsCubit>().getTagsByIds(widget.initialTags);
  }

  @override
  void dispose() {
    textInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TagsCubit, TagsState>(
      listener: _tagsStateListener,
      builder: (context, state) => contents(state),
    );
  }

  void _tagsStateListener(_, TagsState state) {
    state.whenOrNull(
      tagsByIds: (tags) => assignedTags.addAll(tags),
      searchResult: (tags) => searchResult = tags,
      created: (tag) => _addNewTag(tag),
      error: (failure) => CustomBottomSheets.showFailureBottomSheet(
        context: context,
        failure: failure,
      ),
    );
  }

  void _addNewTag(TagEntity tag) {
    if (_notAlreadyAssigned(tag)) {
      setState(() => assignedTags.add(tag));
    }
    widget.onChanged(assignedTags);
  }

  bool _notAlreadyAssigned(TagEntity? item) {
    return item != null && !assignedTags.contains(item);
  }

  Column contents(TagsState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: "برچسب ها"),
        _tagInput(state),
        _assignedTags(),
      ].withGapInBetween(15),
    );
  }

  Row _tagInput(TagsState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _tagInputField(),
        const Gap(20),
        _createTagButton(state),
      ],
    );
  }

  Widget _tagInputField() {
    return SizedBox(
      width: 0.65.sw,
      child: SearchField<TagEntity>(
        searchInputDecoration: _searchInputDecoration(),
        controller: textInputController,
        suggestionAction: SuggestionAction.unfocus,
        onSearchTextChanged: onSearchTextChanged,
        onSuggestionTap: _onSuggestionTap,
        suggestions: _searchResultSuggestions(),
      ),
    );
  }

  List<SearchFieldListItem<TagEntity>>? onSearchTextChanged(value) {
    value.isNotEmpty ? _searchTag(value) : null;

    return null;
  }

  _onSuggestionTap(suggestion) {
    suggestion.item != null ? _addNewTag(suggestion.item!) : null;
    textInputController.clear();
  }

  SearchInputDecoration _searchInputDecoration() {
    return SearchInputDecoration(
      cursorColor: ColorPallet.lightBlue,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: ColorPallet.lightBlue),
        borderRadius: BorderRadius.circular(smallCornerRadius),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorPallet.border),
        borderRadius: BorderRadius.circular(smallCornerRadius),
      ),
    );
  }

  void _searchTag(String value) => context.read<TagsCubit>().searchTag(value);

  List<SearchFieldListItem<TagEntity>> _searchResultSuggestions() {
    return searchResult.map(
      (e) {
        return SearchFieldListItem<TagEntity>(
          e.name,
          child: Text(key: const Key("suggestion_item"), e.name),
          item: e,
        );
      },
    ).toList();
  }

  FilledButton _createTagButton(TagsState state) {
    return FilledButton(
      key: const Key("add_tag_button"),
      onPressed: state.maybeWhen(
        loading: null,
        searching: null,
        orElse: () => _assignNewTagToList,
      ),
      child: const Text("افزودن"),
    );
  }

  _assignNewTagToList() {
    if (textInputController.text.isNotEmpty) {
      final tagInSearchResult = searchResult.where(
        (element) => element.name == textInputController.text,
      );

      tagInSearchResult.isNotEmpty
          ? _getTagFromSearchResult(tagInSearchResult.first)
          : _createNewTag();

      FocusManager.instance.primaryFocus?.unfocus();
      textInputController.clear();
    }
  }

  void _getTagFromSearchResult(TagEntity tag) {
    _addNewTag(tag);
  }

  void _createNewTag() {
    context.read<TagsCubit>().createTag(textInputController.text);
  }

  Widget _assignedTags() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: assignedTags.map((e) => _tagChip(e)).toList(),
    );
  }

  Chip _tagChip(TagEntity tag) {
    return Chip(
      label: Text(tag.name),
      visualDensity: VisualDensity.compact,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      onDeleted: () => _removeTagFromAssignedTags(tag),
    );
  }

  void _removeTagFromAssignedTags(TagEntity tag) {
    setState(() => assignedTags.remove(tag));
    widget.onChanged(assignedTags);
  }
}
