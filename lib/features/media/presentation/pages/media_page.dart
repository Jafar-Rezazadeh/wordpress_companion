import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordpress_companion/features/media/presentation/widgets/upload_media_dialog/upload_file_dialog.dart';

import '../../../../core/core_export.dart';
import '../../media_exports.dart';

class MediaPage extends StatefulWidget {
  const MediaPage({super.key});

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage>
    with AutomaticKeepAliveClientMixin {
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
      params = params.copyWith(page: params.page + 1);
      _getMedias();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          _header(),
          _mediaBuilder(),
        ],
      ),
      floatingActionButton: _uploadMedia(),
    );
  }

  Widget _uploadMedia() {
    return FloatingActionButton(
      key: const Key("upload_media_button"),
      onPressed: () async {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (dialogContext) => PopScope(
            canPop: false,
            child: UploadFileDialog(dialogContext: dialogContext),
          ),
        ).then((value) => _reset());
      },
      child: const Icon(Icons.file_upload_outlined),
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
        hasMoreMedias = data.hasNextPage;

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

  @override
  bool get wantKeepAlive => true;
}
