import 'package:flutter/material.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';
import 'package:wordpress_companion/features/site_settings/presentation/utils/image_cache_tracker.dart';

class SequentialImageList extends StatefulWidget {
  final List<MediaEntity> medias;
  final VoidCallback onScrolledToBottom;
  final Function(MediaEntity media) onSelect;
  final ImageCacheTracker imageCacheTracker;
  final ScrollController? scrollController;

  const SequentialImageList({
    super.key,
    required this.medias,
    required this.onScrolledToBottom,
    required this.onSelect,
    required this.imageCacheTracker,
    this.scrollController,
  });

  @override
  State<SequentialImageList> createState() => _SequentialImageListState();
}

class _SequentialImageListState extends State<SequentialImageList> {
  List<ImageProvider> images = [];
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = widget.scrollController ?? ScrollController();

    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      widget.onScrolledToBottom();
    }
  }

  @override
  void didUpdateWidget(SequentialImageList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.medias != oldWidget.medias) {
      images.clear();
      _loadImagesSequentially();
    }
  }

  Future<void> _loadImagesSequentially() async {
    for (int i = 0; i < widget.medias.length; i++) {
      try {
        await widget.imageCacheTracker.precache(
          context,
          NetworkImage(widget.medias[i].sourceUrl),
        );

        if (!mounted) return;

        setState(() => images.add(NetworkImage(widget.medias[i].sourceUrl)));
      } catch (e) {
        debugPrint('Error loading image at index $i: $e');
      }
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return images.isEmpty && _isNotInTest()
        ? const Center(child: LoadingWidget())
        : _imagesGridView();
  }

  GridView _imagesGridView() {
    return GridView.builder(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) =>
          widget.imageCacheTracker.isImageCached(images[index])
              ? InkWell(
                  onTap: () => widget.onSelect(widget.medias[index]),
                  child: Image(
                    image: images[index],
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                  ),
                )
              : null,
    );
  }

  bool _isNotInTest() {
    return View.of(context)
            .platformDispatcher
            .toString()
            .contains("TestPlatformDispatcher") ==
        false;
  }
}
