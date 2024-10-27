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
  var currentPageMedias = CurrentPageMediasEntity(
    hasMore: false,
    medias: [],
  );

  @override
  void initState() {
    context.read<MediaCubit>().getMediaPerPage(GetMediaPerPageParams());
    super.initState();
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
        return state.maybeWhen(
          loading: () => const Expanded(child: LoadingWidget()),
          orElse: () => _listOfMedia(),
        );
      },
    );
  }

  void _mediaStateListener(_, MediaState state) {
    state.whenOrNull(
      loaded: (data) => currentPageMedias = data,
      error: (failure) => CustomBottomSheets.showFailureBottomSheet(
        context: context,
        failure: failure,
      ),
    );
  }

  Widget _listOfMedia() {
    return Expanded(
      flex: 9,
      child: currentPageMedias.medias.isEmpty
          ? _showNoMediaInfo()
          : _showListOfMedia(),
    );
  }

  Text _showNoMediaInfo() {
    return const Text(
      key: Key("no_media_info_text"),
      "محتوایی برای نمایش وجود ندارد.",
    );
  }

  ListView _showListOfMedia() {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: ColorPallet.border,
      ),
      itemCount: currentPageMedias.medias.length,
      itemBuilder: (context, index) => MediaListItem(
        media: currentPageMedias.medias[index],
      ),
    );
  }
}
