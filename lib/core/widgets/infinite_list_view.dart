import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../core_export.dart';

class InfiniteListView<T> extends StatefulWidget {
  final Future<void> Function() onRefresh;
  final Function() onScrolledToBottom;
  final List<T> data;
  final Widget Function(T item) itemBuilder;
  final bool showBottomLoadingWhen;
  final bool showFullScreenLoadingWhen;

  const InfiniteListView({
    super.key,
    required this.onRefresh,
    required this.onScrolledToBottom,
    required this.data,
    required this.itemBuilder,
    required this.showBottomLoadingWhen,
    required this.showFullScreenLoadingWhen,
  });

  @override
  State<InfiniteListView<T>> createState() => _InfiniteListViewState<T>();
}

class _InfiniteListViewState<T> extends State<InfiniteListView<T>> {
  final scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      widget.onScrolledToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.showFullScreenLoadingWhen
        ? _fullScreenLoading()
        : _listViewRenderer();
  }

  Widget _fullScreenLoading() {
    return const LoadingWidget(
      key: Key("full_screen_loading"),
    );
  }

  Widget _listViewRenderer() =>
      widget.data.isEmpty ? _showNoMediaInfo() : _showListOfMedia();

  Text _showNoMediaInfo() {
    return const Text(
      key: Key("no_data_info_text"),
      "محتوایی برای نمایش وجود ندارد.",
    );
  }

  Widget _showListOfMedia() {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: ListView.separated(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) => Divider(
          color: ColorPallet.border,
        ),
        itemCount: widget.data.length + 1,
        itemBuilder: (context, index) {
          if (index == widget.data.length) {
            return _onScrollLoadingWidget();
          }
          return widget.itemBuilder(widget.data[index]);
        },
      ),
    );
  }

  Widget _onScrollLoadingWidget() {
    return Container(
      key: const Key("load_on_scroll_widget"),
      height: 80,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: const CircularProgressIndicator(),
    ).animate(
      target: widget.showBottomLoadingWhen ? 1 : 0,
    )..show(maintain: widget.showBottomLoadingWhen);
  }
}
