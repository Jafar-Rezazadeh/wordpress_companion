import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';

class MockGetPostsPerPage extends Mock implements GetPostsPerPage {}

class FakePostsPageResult extends Fake implements PostsPageResult {
  @override
  bool get hasNextPage => true;
  @override
  List<PostEntity> get posts => [];
}

class FakeFailure extends Fake implements Failure {}

class FakePostEntity extends Fake implements PostEntity {}

void main() {
  late MockGetPostsPerPage mockGetPostsPerPage;
  late PostsCubit postsCubit;

  setUpAll(() {
    registerFallbackValue(GetPostsPerPageParams());
  });

  setUp(() {
    mockGetPostsPerPage = MockGetPostsPerPage();
    postsCubit = PostsCubit(getPostsPerPage: mockGetPostsPerPage);
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
      act: (cubit) => cubit.getFirstPage(),
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
      act: (cubit) => cubit.getFirstPage(),
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
      act: (cubit) => cubit.getFirstPage(),
      expect: () => [],
      verify: (_) => verifyNever(() => mockGetPostsPerPage.call(any())),
    );

    blocTest<PostsCubit, PostsState>(
      'should params always be default ',
      seed: () => PostsState.loaded(FakePostsPageResult()),
      setUp: () {
        when(
          () => mockGetPostsPerPage.call(any()),
        ).thenAnswer((_) async => right(FakePostsPageResult()));
      },
      build: () => postsCubit,
      act: (cubit) async {
        await cubit.getFirstPage();
        await cubit.getNextPageData();
        await cubit.getNextPageData();
        await cubit.getFirstPage();
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
      act: (cubit) => cubit.getNextPageData(),
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
      act: (cubit) => cubit.getNextPageData(),
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
      act: (cubit) => cubit.getNextPageData(),
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
      act: (cubit) => cubit.getNextPageData(),
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
      act: (cubit) => cubit.getNextPageData(),
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
      act: (cubit) => cubit.getNextPageData(
        search: "test",
        after: "after",
        before: "before",
        categories: [2],
      ),
      verify: (_) => verify(
        () => mockGetPostsPerPage.call(
          any(
            that: isA<GetPostsPerPageParams>().having(
              (params) =>
                  params.search == "test" &&
                  params.after == "after" &&
                  params.before == "before" &&
                  params.categories?.length == 1,
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
        await cubit.getFirstPage();
        await cubit.getNextPageData();
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
