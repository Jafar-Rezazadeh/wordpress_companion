import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordpress_companion/core/widgets/custom_bottom_sheet.dart';
import 'package:wordpress_companion/features/media/presentation/widgets/media_list_item.dart';

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
  late GetMediaPerPageParams params;
  final scrollController = ScrollController();

  @override
  void initState() {
    params = GetMediaPerPageParams();
    _getCurrentPageMedia();
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  _getCurrentPageMedia() {
    context.read<MediaCubit>().getMediaPerPage(params);
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      _nextMediasOfNextPage();
    }
  }

  _nextMediasOfNextPage() {
    if (hasMoreMedias) {
      context.read<MediaCubit>().getMediaPerPage(
            params.copyWith(page: params.page + 1),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _header(),
        _mediaBuilder(),
      ],
    );
  }

  Widget _header() {
    return PageHeaderLayout(
      leftWidget: CustomSearchInput(
        onChanged: (value) {},
      ),
      rightWidget: const FilterButton(),
    );
  }

  Widget _mediaBuilder() {
    return BlocConsumer<MediaCubit, MediaState>(
      listener: _mediaStateListener,
      builder: (context, state) {
        return _isFirstLoading(state) ? _fullScreenLoading() : _listOfMedia();
      },
    );
  }

  bool _isFirstLoading(MediaState state) =>
      state.whenOrNull(loading: () => true) == true &&
      params.page == 1 &&
      listOfMedias.isEmpty;

  Widget _fullScreenLoading() => const Expanded(
        key: Key("full_screen_loading"),
        child: LoadingWidget(),
      );

  void _mediaStateListener(_, MediaState state) {
    // TODO: make this one loading appears at the bottom
    // TODO: make a loadMore listView widget out of this to use it in other scenarios
    state.whenOrNull(
      loading: () {
        if (listOfMedias.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              key: Key("load_on_scroll_widget"),
              content: Text("loading more..."),
            ),
          );
        }
      },
      loaded: (data) {
        hasMoreMedias = data.hasMoreMedias;
        listOfMedias.addAll(data.medias);
      },
      error: (failure) => CustomBottomSheets.showFailureBottomSheet(
        context: context,
        failure: failure,
      ),
    );
  }

  Widget _listOfMedia() {
    return Expanded(
      flex: 9,
      child: listOfMedias.isEmpty ? _showNoMediaInfo() : _showListOfMedia(),
    );
  }

  Text _showNoMediaInfo() {
    return const Text(
      key: Key("no_media_info_text"),
      "محتوایی برای نمایش وجود ندارد.",
    );
  }

  Widget _showListOfMedia() {
    return RefreshIndicator(
      onRefresh: () async {
        _refresh();
      },
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: scrollController,
        separatorBuilder: (context, index) => Divider(
          color: ColorPallet.border,
        ),
        itemCount: listOfMedias.length,
        itemBuilder: (context, index) => MediaListItem(
          media: listOfMedias[index],
        ),
      ),
    );
  }

  void _refresh() {
    params = GetMediaPerPageParams();
    hasMoreMedias = false;
    listOfMedias.clear();
    _getCurrentPageMedia();
  }
}
