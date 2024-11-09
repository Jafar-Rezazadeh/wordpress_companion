import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';
import 'package:wordpress_companion/features/site_settings/presentation/state_Management/image_list_cubit/image_list_cubit.dart';
import 'package:wordpress_companion/features/site_settings/presentation/utils/image_cache_tracker.dart';
import 'package:wordpress_companion/features/site_settings/presentation/widgets/image_list/sequential_image_list.dart';

class ImageSelectorDialog extends StatefulWidget {
  @override
  Key? get key => const Key("image_list_dialog");
  final BuildContext dialogContext;
  final Function(MediaEntity media) onSelect;
  const ImageSelectorDialog({
    super.key,
    required this.dialogContext,
    required this.onSelect,
  });

  @override
  State<ImageSelectorDialog> createState() => _ImageSelectorDialogState();
}

class _ImageSelectorDialogState extends State<ImageSelectorDialog> {
  List<MediaEntity> listOfMedias = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getFirstPage();
  }

  void _getFirstPage() {
    context.read<ImageListCubit>().getFirstPageData();
  }

  void _goNextPage() {
    context.read<ImageListCubit>().getNextPageData();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: edgeToEdgePaddingHorizontal,
        ),
        child: Column(
          children: [
            _backButton(),
            const Gap(10),
            _searchInput(),
            Divider(color: ColorPallet.border),
            _gridViewBuilder(),
          ],
        ),
      ),
    );
  }

  Widget _backButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: TextButton.icon(
        key: const Key("back_button"),
        onPressed: () => Navigator.of(widget.dialogContext).pop(),
        style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
        iconAlignment: IconAlignment.end,
        label: const Text("بازگشت"),
        icon: const Icon(Icons.chevron_left, textDirection: TextDirection.ltr),
      ),
    );
  }

  Widget _searchInput() {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.center,
        child: CustomSearchInput(
          onSubmit: (value) {
            if (value != null) {
              context.read<ImageListCubit>().searchImage(value);
            }
          },
          onClear: () => _getFirstPage(),
        ),
      ),
    );
  }

  Widget _gridViewBuilder() {
    return Expanded(
      flex: 9,
      child: BlocConsumer<ImageListCubit, ImageListState>(
        listener: _imageListStateListener,
        builder: (context, state) => _imagesGridView(),
      ),
    );
  }

  void _imageListStateListener(context, ImageListState state) {
    state.whenOrNull(
      loaded: (currentPageMedias) {
        setState(() => listOfMedias = currentPageMedias.medias);
      },
      error: (failure) => showDialog(
        context: context,
        builder: (dialogContext) => Dialog(
          key: const Key("failure_dialog"),
          child: FailureWidget(failure: failure),
        ),
      ),
    );
  }

  Widget _imagesGridView() {
    return SequentialImageList(
      medias: listOfMedias,
      imageCacheTracker: ImageCacheTracker(),
      onSelect: (media) {
        widget.onSelect(media);
        Navigator.of(widget.dialogContext).pop();
      },
      onScrolledToBottom: () => _goNextPage(),
    );
  }
}
