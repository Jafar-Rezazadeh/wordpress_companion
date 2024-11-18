import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage>
    with AutomaticKeepAliveClientMixin {
  List<PostEntity> posts = [];
  bool isLoading = false;
  final filters = GetPostsFilters();

  @override
  void initState() {
    super.initState();
    _getFirstPage();
  }

  _getFirstPage() => context.read<PostsCubit>().getFirstPage(filters);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: _createPostButton(),
        body: Column(
          children: [
            _header(),
            _listOfPosts(),
          ],
        ),
      ),
    );
  }

  Widget _createPostButton() {
    return FloatingActionButton(
      heroTag: "create_post_hero_tag",
      onPressed: () => context.goNamed(editOrCreatePostRoute),
      child: const Icon(Icons.add),
    );
  }

  Widget _header() {
    return PageHeaderLayout(
      rightWidget: PostsFilterWidget(
        filters: filters,
        onApply: () {
          _clearPosts();
          _getFirstPage();
        },
        onClear: () => _refresh(),
      ),
      leftWidget: _searchInput(),
    );
  }

  void _refresh() {
    _clearPosts();
    filters.reset();
    _getFirstPage();
  }

  Widget _searchInput() {
    return CustomSearchInput(
      onSubmit: (value) {
        if (value != null) {
          filters.setSearch(value);
          _clearPosts();
          _getFirstPage();
        }
      },
      onClear: () => _refresh(),
    );
  }

  void _clearPosts() => setState(() => posts.clear());

  Widget _listOfPosts() {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: _postsStateListener,
      builder: (context, state) => Expanded(
        child: _infiniteList(state),
      ),
    );
  }

  Widget _infiniteList(PostsState state) {
    return InfiniteListView<PostEntity>(
      onRefresh: () async => _refresh(),
      onScrolledToBottom: () => _getNextPageData(),
      data: posts,
      itemBuilder: _postItem,
      separatorWidget: const Gap(10),
      showBottomLoadingWhen: _isLoading(state) && posts.isNotEmpty,
      showFullScreenLoadingWhen: _isLoading(state) && posts.isEmpty,
    );
  }

  _getNextPageData() {
    context.read<PostsCubit>().getNextPageData(filters);
  }

  Widget _postItem(post) {
    return Container(
      key: const Key("post_item"),
      child: PostItemWidget(post: post),
    );
  }

  void _postsStateListener(_, PostsState state) {
    state.whenOrNull(
      needRefresh: () => _refresh(),
      loaded: (postsPageResult) {
        setState(() => posts = postsPageResult.posts);
      },
      error: (failure) async {
        await CustomBottomSheets.showFailureBottomSheet(
          context: context,
          failure: failure,
        );
      },
    );
  }

  bool _isLoading(PostsState state) =>
      state.maybeWhen(loading: () => true, orElse: () => false);

  @override
  bool get wantKeepAlive => true;
}
