import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core_export.dart';
import '../../media_exports.dart';

class MediaPage extends StatefulWidget {
  const MediaPage({super.key});

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  bool hasMoreMedias = false;
  List<MediaEntity> listOfMedias = [];
  GetMediaPerPageParams params = GetMediaPerPageParams();

  @override
  void initState() {
    _getMedias();
    super.initState();
  }

  _getMedias() {
    context.read<MediaCubit>().getMediaPerPage(params);
  }

  _goNextPage() {
    if (hasMoreMedias) {
      context.read<MediaCubit>().getMediaPerPage(
            params.copyWith(page: params.page + 1),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // TODO: add upload media button (hint use an scaffold)
      children: [
        _header(),
        _mediaBuilder(),
      ],
    );
  }

  Widget _header() {
    return PageHeaderLayout(
      leftWidget: _searchInput(),
      rightWidget: _filterButton(),
    );
  }

  Widget _searchInput() {
    return CustomSearchInput(
      onSubmit: (value) {
        _reinitializeVariables(params: GetMediaPerPageParams(search: value));
        _getMedias();
      },
      onClear: () => _reset(),
    );
  }

  void _reset() {
    _reinitializeVariables();
    _getMedias();
  }

  void _reinitializeVariables({GetMediaPerPageParams? params}) {
    this.params = params ?? GetMediaPerPageParams();
    hasMoreMedias = false;
    listOfMedias.clear();
  }

  Widget _filterButton() {
    return MediaFilterButton(
      onApply: (filters) {
        _reinitializeVariables(
          params: GetMediaPerPageParams(
            type: filters.type,
            after: filters.after,
            before: filters.before,
          ),
        );
        _getMedias();
      },
      onClear: () => _reset(),
    );
  }

  Widget _mediaBuilder() {
    return BlocConsumer<MediaCubit, MediaState>(
      listener: _mediaStateListener,
      builder: (context, state) {
        return Expanded(
          flex: 9,
          child: InfiniteListView<MediaEntity>(
            onRefresh: _refresh,
            onScrolledToBottom: _goNextPage,
            data: listOfMedias,
            itemBuilder: (item) => MediaListItem(media: item),
            showBottomLoadingWhen:
                _isLoadingState(state) && listOfMedias.isNotEmpty,
            showFullScreenLoadingWhen:
                _isLoadingState(state) && listOfMedias.isEmpty,
          ),
        );
      },
    );
  }

  void _mediaStateListener(_, MediaState state) {
    state.whenOrNull(
      updated: () => _reset(),
      deleted: (_) => _reset(),
      loaded: (data) {
        hasMoreMedias = data.hasMoreMedias;
        listOfMedias.addAll(data.medias);
      },
      error: (failure) {
        CustomBottomSheets.showFailureBottomSheet(
          context: context,
          failure: failure,
        );
      },
    );
  }

  Future<void> _refresh() async {
    _reinitializeVariables(
      params: params.copyWith(page: 1, search: null),
    );
    _getMedias();
  }

  bool _isLoadingState(MediaState state) =>
      state.whenOrNull(loading: () => true) == true;
}
