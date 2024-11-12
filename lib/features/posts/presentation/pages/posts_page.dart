import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';
import 'package:wordpress_companion/features/posts/presentation/widgets/posts_page/post_item_widget.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  List<PostEntity> posts = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    context.read<PostsCubit>().getFirstPage();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: [
            _header(),
            _listOfPosts(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return const PageHeaderLayout(
        // TODO: make search and filters
        );
  }

  Widget _listOfPosts() {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: _postsStateListener,
      builder: (context, state) => Expanded(
        child: InfiniteListView<PostEntity>(
          onRefresh: () async {
            setState(() => posts.clear());
            context.read<PostsCubit>().getFirstPage();
          },
          onScrolledToBottom: () {
            context.read<PostsCubit>().getNextPageData();
          },
          data: posts,
          itemBuilder: (post) {
            return Container(
              key: const Key("post_item"),
              child: PostItemWidget(post: post),
            );
          },
          showBottomLoadingWhen: _isLoading(state) && posts.isNotEmpty,
          showFullScreenLoadingWhen: _isLoading(state) && posts.isEmpty,
        ),
      ),
    );
  }

  bool _isLoading(PostsState state) =>
      state.maybeWhen(loading: () => true, orElse: () => false);

  void _postsStateListener(_, PostsState state) {
    state.whenOrNull(
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
}
