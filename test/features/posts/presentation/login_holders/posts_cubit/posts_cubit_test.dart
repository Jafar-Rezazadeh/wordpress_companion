import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';

class MockGetPostsPerPage extends Mock implements GetPostsPerPage {}

class MockDeletePost extends Mock implements DeletePost {}

class MockCreatePost extends Mock implements CreatePost {}

class MockUpdatePost extends Mock implements UpdatePost {}

class FakePostsPageResult extends Fake implements PostsPageResult {
  @override
  bool get hasNextPage => true;
  @override
  List<PostEntity> get posts => [];
}

class FakeFailure extends Fake implements Failure {}

class FakePostEntity extends Fake implements PostEntity {}

class FakePostParams extends Fake implements PostParams {}

void main() {
  late MockGetPostsPerPage mockGetPostsPerPage;
  late MockDeletePost mockDeletePost;
  late MockCreatePost mockCreatePost;
  late MockUpdatePost mockUpdatePost;
  late PostsCubit postsCubit;

  setUpAll(() {
    registerFallbackValue(GetPostsPerPageParams());
    registerFallbackValue(FakePostParams());
  });

  setUp(() {
    mockGetPostsPerPage = MockGetPostsPerPage();
    mockDeletePost = MockDeletePost();
    mockCreatePost = MockCreatePost();
    mockUpdatePost = MockUpdatePost();
    postsCubit = PostsCubit(
      getPostsPerPage: mockGetPostsPerPage,
      deletePost: mockDeletePost,
      createPost: mockCreatePost,
      updatePost: mockUpdatePost,
    );
  });

  group("getFirstPage -", () {
    blocTest<PostsCubit, PostsState>(
      'emits [loading, loaded] when success',
      setUp: () {
        when(
          () => mockGetPostsPerPage.call(any()),
        ).thenAnswer((_) async => right(FakePostsPageResult()));
      },
      build: () => postsCubit,
      act: (cubit) => cubit.getFirstPage(GetPostsFilters()),
      expect: () => [
        isA<PostsState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<PostsState>().having(
          (state) => state.whenOrNull(loaded: (_) => true),
          "is loaded state",
          true,
        ),
      ],
    );

    blocTest<PostsCubit, PostsState>(
      'emits [loading, error] when fails',
      setUp: () {
        when(
          () => mockGetPostsPerPage.call(any()),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => postsCubit,
      act: (cubit) => cubit.getFirstPage(GetPostsFilters()),
      expect: () => [
        isA<PostsState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<PostsState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          "is error state",
          true,
        ),
      ],
    );

    blocTest<PostsCubit, PostsState>(
      'emits [] when current state is',
      seed: () => const PostsState.loading(),
      setUp: () {},
      build: () => postsCubit,
      act: (cubit) => cubit.getFirstPage(GetPostsFilters()),
      expect: () => [],
      verify: (_) => verifyNever(() => mockGetPostsPerPage.call(any())),
    );

    blocTest<PostsCubit, PostsState>(
      'should set the given filters to params',
      seed: () => PostsState.loaded(FakePostsPageResult()),
      setUp: () {
        when(
          () => mockGetPostsPerPage.call(any()),
        ).thenAnswer((_) async => right(FakePostsPageResult()));
      },
      build: () => postsCubit,
      act: (cubit) => cubit.getFirstPage(
        GetPostsFilters()
          ..setSearch("test")
          ..setAfter("after")
          ..setBefore("before")
          ..setCategories([1, 2, 3])
          ..setStatus([PostStatus.publish]),
      ),
      verify: (_) {
        verify(
          () => mockGetPostsPerPage.call(
            any(
              that: isA<GetPostsPerPageParams>().having(
                (params) =>
                    params.search == "test" &&
                    params.after == "after" &&
                    params.before == "before" &&
                    params.categories!.length == 3 &&
                    params.status?.contains(PostStatus.publish) == true,
                "has expected params",
                true,
              ),
            ),
          ),
        );
      },
    );

    blocTest<PostsCubit, PostsState>(
      'should params  be default filters are null',
      seed: () => PostsState.loaded(FakePostsPageResult()),
      setUp: () {
        when(
          () => mockGetPostsPerPage.call(any()),
        ).thenAnswer((_) async => right(FakePostsPageResult()));
      },
      build: () => postsCubit,
      act: (cubit) async {
        await cubit.getFirstPage(GetPostsFilters());
        await cubit.getNextPageData(GetPostsFilters());
        await cubit.getNextPageData(GetPostsFilters());
        await cubit.getFirstPage(GetPostsFilters());
      },
      verify: (bloc) {
        _verifyParamsWithPage_1Called_2(mockGetPostsPerPage);
        _verifyParamsWithPage_2Called_1(mockGetPostsPerPage);
        _verifyParamsWithPage_3Called_1(mockGetPostsPerPage);
      },
    );
  });

  group("getNextPageData -", () {
    blocTest<PostsCubit, PostsState>(
      'emits [loading, loaded] when success',
      seed: () => PostsState.loaded(FakePostsPageResult()),
      setUp: () {
        when(
          () => mockGetPostsPerPage.call(any()),
        ).thenAnswer((_) async => right(FakePostsPageResult()));
      },
      build: () => postsCubit,
      act: (cubit) => cubit.getNextPageData(GetPostsFilters()),
      expect: () => [
        isA<PostsState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<PostsState>().having(
          (state) => state.whenOrNull(loaded: (_) => true),
          "is loaded state",
          true,
        ),
      ],
    );
    blocTest<PostsCubit, PostsState>(
      'emits [loading, error] when fails',
      seed: () => PostsState.loaded(FakePostsPageResult()),
      setUp: () {
        when(
          () => mockGetPostsPerPage.call(any()),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => postsCubit,
      act: (cubit) => cubit.getNextPageData(GetPostsFilters()),
      expect: () => [
        isA<PostsState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<PostsState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          "is error state",
          true,
        ),
      ],
    );

    blocTest<PostsCubit, PostsState>(
      'emits [] when current state is loading',
      seed: () => const PostsState.loading(),
      setUp: () {},
      build: () => postsCubit,
      act: (cubit) => cubit.getNextPageData(GetPostsFilters()),
      expect: () => [],
      verify: (_) => verifyNever(() => mockGetPostsPerPage.call(any())),
    );

    blocTest<PostsCubit, PostsState>(
      'should add the next page posts to current posts',
      seed: () => PostsState.loaded(
        PostsPageResult(hasNextPage: true, posts: [
          FakePostEntity(),
          FakePostEntity(),
        ]),
      ),
      setUp: () {
        when(() => mockGetPostsPerPage.call(any())).thenAnswer(
          (_) async => right(
            PostsPageResult(
              hasNextPage: false,
              posts: [
                FakePostEntity(),
                FakePostEntity(),
              ],
            ),
          ),
        );
      },
      build: () => postsCubit,
      skip: 2,
      act: (cubit) => cubit.getNextPageData(GetPostsFilters()),
      expect: () => [],
      verify: (cubit) {
        final posts = cubit.state.whenOrNull(loaded: (posts) => posts.posts);

        expect(posts?.length, 4);
      },
    );

    blocTest<PostsCubit, PostsState>(
      'emits [] when previousPage hasNextPage property is false',
      seed: () => PostsState.loaded(
        PostsPageResult(hasNextPage: false, posts: []),
      ),
      setUp: () {},
      build: () => postsCubit,
      act: (cubit) => cubit.getNextPageData(GetPostsFilters()),
      expect: () => [],
      verify: (_) => verifyNever(() => mockGetPostsPerPage.call(any())),
    );

    blocTest<PostsCubit, PostsState>(
      'should add filters to params',
      seed: () => PostsState.loaded(FakePostsPageResult()),
      setUp: () {
        when(
          () => mockGetPostsPerPage.call(any()),
        ).thenAnswer((_) async => right(FakePostsPageResult()));
      },
      build: () => postsCubit,
      act: (cubit) {
        final filters = GetPostsFilters();

        filters
          ..setSearch("test")
          ..setAfter("after")
          ..setBefore("before")
          ..setCategories([2])
          ..setStatus([PostStatus.publish]);

        return cubit.getNextPageData(filters);
      },
      verify: (_) => verify(
        () => mockGetPostsPerPage.call(
          any(
            that: isA<GetPostsPerPageParams>().having(
              (params) =>
                  params.search == "test" &&
                  params.after == "after" &&
                  params.before == "before" &&
                  params.categories?.length == 1 &&
                  params.status?.contains(PostStatus.publish) == true,
              "has expected Params",
              true,
            ),
          ),
        ),
      ),
    );

    blocTest<PostsCubit, PostsState>(
      'should increase page number ',
      seed: () => PostsState.loaded(FakePostsPageResult()),
      setUp: () {
        when(
          () => mockGetPostsPerPage.call(any()),
        ).thenAnswer((_) async => right(FakePostsPageResult()));
        when(
          () => mockGetPostsPerPage.call(any()),
        ).thenAnswer((_) async => right(FakePostsPageResult()));
      },
      build: () => postsCubit,
      act: (cubit) async {
        await cubit.getFirstPage(GetPostsFilters());
        await cubit.getNextPageData(GetPostsFilters());
      },
      verify: (_) => verify(
        () => mockGetPostsPerPage.call(
          any(
            that: isA<GetPostsPerPageParams>().having(
              (params) {
                return params.page == 2;
              },
              "page increased",
              true,
            ),
          ),
        ),
      ),
    );
  });

  group("deletePost -", () {
    blocTest<PostsCubit, PostsState>(
      'emits [loading , needsRefresh] when success to delete post',
      setUp: () {
        when(
          () => mockDeletePost.call(any()),
        ).thenAnswer((_) async => right(FakePostEntity()));
      },
      build: () => postsCubit,
      act: (cubit) => cubit.deletePost(1),
      expect: () => [
        isA<PostsState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<PostsState>().having(
          (state) => state.whenOrNull(needRefresh: () => true),
          "is needsRefresh state",
          true,
        ),
      ],
    );
    blocTest<PostsCubit, PostsState>(
      'emits [loading , error] when fails to delete post',
      setUp: () {
        when(
          () => mockDeletePost.call(any()),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => postsCubit,
      act: (cubit) => cubit.deletePost(1),
      expect: () => [
        isA<PostsState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<PostsState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          "is error state",
          true,
        ),
      ],
    );

    blocTest<PostsCubit, PostsState>(
      'emits [] when current state is loading',
      seed: () => const PostsState.loading(),
      setUp: () {},
      build: () => postsCubit,
      act: (cubit) => cubit.deletePost(1),
      expect: () => [],
    );
  });

  group("createPost -", () {
    blocTest<PostsCubit, PostsState>(
      'emits [loading, needsRefresh] when success to create',
      setUp: () {
        when(
          () => mockCreatePost.call(any()),
        ).thenAnswer((_) async => right(FakePostEntity()));
      },
      build: () => postsCubit,
      act: (cubit) => cubit.createPosts(FakePostParams()),
      expect: () => [
        isA<PostsState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<PostsState>().having(
          (state) => state.whenOrNull(needRefresh: () => true),
          "is needsRefresh state",
          true,
        ),
      ],
    );
    blocTest<PostsCubit, PostsState>(
      'emits [loading, error] when fails to create',
      setUp: () {
        when(
          () => mockCreatePost.call(any()),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => postsCubit,
      act: (cubit) => cubit.createPosts(FakePostParams()),
      expect: () => [
        isA<PostsState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<PostsState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          "is error state",
          true,
        ),
      ],
    );

    blocTest<PostsCubit, PostsState>(
      'emits [] when when current state is loading',
      seed: () => const PostsState.loading(),
      setUp: () {},
      build: () => postsCubit,
      act: (cubit) => cubit.createPosts(FakePostParams()),
      expect: () => [],
    );
  });

  group("updatePost -", () {
    blocTest<PostsCubit, PostsState>(
      'emits [loading, needsRefresh] when success',
      setUp: () {
        when(
          () => mockUpdatePost.call(any()),
        ).thenAnswer((_) async => right(FakePostEntity()));
      },
      build: () => postsCubit,
      act: (cubit) => cubit.updatePosts(FakePostParams()),
      expect: () => [
        isA<PostsState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<PostsState>().having(
          (state) => state.whenOrNull(needRefresh: () => true),
          "is needsRefresh state",
          true,
        ),
      ],
    );
    blocTest<PostsCubit, PostsState>(
      'emits [loading, error] when fails',
      setUp: () {
        when(
          () => mockUpdatePost.call(any()),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => postsCubit,
      act: (cubit) => cubit.updatePosts(FakePostParams()),
      expect: () => [
        isA<PostsState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<PostsState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          "is error state",
          true,
        ),
      ],
    );

    blocTest<PostsCubit, PostsState>(
      'emits [] when current state is loading',
      seed: () => const PostsState.loading(),
      setUp: () {},
      build: () => postsCubit,
      act: (cubit) => cubit.updatePosts(FakePostParams()),
      expect: () => [],
    );
  });
}

void _verifyParamsWithPage_1Called_2(MockGetPostsPerPage mockGetPostsPerPage) {
  verify(
    () => mockGetPostsPerPage.call(
      any(
        that: isA<GetPostsPerPageParams>().having(
          (params) => params.page == 1,
          "is page 1",
          true,
        ),
      ),
    ),
  ).called(2);
}

void _verifyParamsWithPage_2Called_1(MockGetPostsPerPage mockGetPostsPerPage) {
  verify(
    () => mockGetPostsPerPage.call(
      any(
        that: isA<GetPostsPerPageParams>().having(
          (params) => params.page == 2,
          "is page 2",
          true,
        ),
      ),
    ),
  ).called(1);
}

void _verifyParamsWithPage_3Called_1(MockGetPostsPerPage mockGetPostsPerPage) {
  verify(
    () => mockGetPostsPerPage.call(
      any(
        that: isA<GetPostsPerPageParams>().having(
          (params) => params.page == 3,
          "is page 3",
          true,
        ),
      ),
    ),
  ).called(1);
}
