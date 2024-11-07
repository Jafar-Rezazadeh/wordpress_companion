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
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_isScrolledToBottom && _isNotLoading) {
      widget.onScrolledToBottom();
    }
  }

  bool get _isScrolledToBottom {
    return scrollController.position.pixels >=
        scrollController.position.maxScrollExtent;
  }

  bool get _isNotLoading =>
      widget.showBottomLoadingWhen == false &&
      widget.showFullScreenLoadingWhen == false;

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

  Widget _showNoMediaInfo() {
    return Column(
      key: const Key("no_data_widget"),
      children: [
        const Text(
          "محتوایی برای نمایش وجود ندارد.",
        ),
        _refreshButton()
      ],
    );
  }

  IconButton _refreshButton() {
    return IconButton.filled(
      style: IconButton.styleFrom(
        shadowColor: Colors.black87,
        backgroundColor: Colors.white,
        foregroundColor: ColorPallet.lightBlue,
        elevation: 5,
      ),
      key: const Key("no_data_refresh_button"),
      onPressed: () => widget.onRefresh(),
      icon: const Icon(Icons.refresh),
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
