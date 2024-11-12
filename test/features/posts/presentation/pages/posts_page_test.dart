import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';
import 'package:wordpress_companion/features/posts/presentation/pages/posts_page.dart';

class MockPostsCubit extends MockCubit<PostsState> implements PostsCubit {}

class FakePostEntity extends Fake implements PostEntity {
  @override
  PostStatus get status => PostStatus.publish;

  @override
  String get title => "title";

  @override
  String get authorName => "authorName";

  @override
  DateTime get date => DateTime(1);

  @override
  String get featureMediaLink => "";
}

void main() {
  late PostsCubit postsCubit;
  setUpAll(() {
    registerFallbackValue(GetPostsFilters());
  });
  setUp(() {
    postsCubit = MockPostsCubit();
    when(() => postsCubit.state).thenAnswer((_) => const PostsState.initial());
  });

  group("header -", () {
    group("filters -", () {
      testWidgets("should open filter_bottom_sheet when FilterButton is tapped",
          (tester) async {
        //arrange
        await tester.pumpWidget(_testWidget(postsCubit));
        await tester.pumpAndSettle();

        //verification
        expect(find.byType(FilterButton), findsOneWidget);

        //act
        await tester.tap(find.byType(FilterButton));
        await tester.pumpAndSettle();

        //assert
        expect(find.byKey(const Key("filter_bottom_sheet")), findsOneWidget);
      });
    });
    group("search input -", () {
      testWidgets(
          "should call the getFirstPageData and set search filter when onSubmit invoked",
          (tester) async {
        //arrange
        await tester.pumpWidget(_testWidget(postsCubit));
        await tester.pumpAndSettle();

        //verification
        expect(find.byType(CustomSearchInput), findsOneWidget);

        //act
        tester
            .widget<CustomSearchInput>(find.byType(CustomSearchInput))
            .onSubmit("search");

        //assert
        verify(
          () => postsCubit.getFirstPage(
            any(
              that: isA<GetPostsFilters>().having(
                (filters) => filters.search == "search",
                "is search filter set",
                true,
              ),
            ),
          ),
        );
      });

      testWidgets(
          "should clear posts reset filters and call getFirstPageData when onClear invoked",
          (tester) async {
        //arrange
        await tester.pumpWidget(_testWidget(postsCubit));
        await tester.pumpAndSettle();

        //verification
        expect(find.byType(CustomSearchInput), findsOneWidget);

        //act
        tester
            .widget<CustomSearchInput>(find.byType(CustomSearchInput))
            .onSubmit("test");
        tester
            .widget<CustomSearchInput>(find.byType(CustomSearchInput))
            .onClear();

        //assert
        verify(
          () => postsCubit.getFirstPage(
            any(
              that: isA<GetPostsFilters>().having(
                (filters) =>
                    filters.search == null &&
                    filters.after == null &&
                    filters.before == null &&
                    filters.categories == null,
                "is all filters are null",
                true,
              ),
            ),
          ),
        ).called(3);
      });
    });
  });

  group("PostsCubit -", () {
    testWidgets("should call getFirstPage on widget init", (tester) async {
      //arrange
      await tester.pumpWidget(_testWidget(postsCubit));
      await tester.pumpAndSettle();

      //verification
      verify(() => postsCubit.getFirstPage(any())).called(1);
    });

    testWidgets(
        "should show full_screen_loading when state is loading and posts are empty",
        (tester) async {
      //arrange
      whenListen(
        postsCubit,
        Stream.fromIterable([
          PostsState.loaded(PostsPageResult(hasNextPage: true, posts: [])),
          const PostsState.loading(),
        ]),
      );
      await tester.pumpWidget(_testWidget(postsCubit));

      await tester.pump(Durations.short1);

      //assert
      expect(find.byKey(const Key("full_screen_loading")), findsOneWidget);
    });

    testWidgets(
        "should on_scroll_loading_widget when state is loading but there is some posts",
        (tester) async {
      //arrange
      whenListen(
        postsCubit,
        Stream.fromIterable([
          PostsState.loaded(
            PostsPageResult(
              hasNextPage: true,
              posts: [FakePostEntity(), FakePostEntity(), FakePostEntity()],
            ),
          ),
          const PostsState.loading(),
        ]),
      );
      await tester.pumpWidget(_testWidget(postsCubit));
      await tester.pump(Durations.short1);

      //assert
      expect(find.byKey(const Key("on_scroll_loading_widget")), findsOneWidget);
      expect(find.byKey(const Key("full_screen_loading")), findsNothing);
    });

    testWidgets("should list of posts when state is loaded", (tester) async {
      //arrange
      whenListen(
        postsCubit,
        Stream.fromIterable(
          [
            PostsState.loaded(PostsPageResult(hasNextPage: true, posts: [
              FakePostEntity(),
              FakePostEntity(),
              FakePostEntity(),
            ]))
          ],
        ),
      );
      await tester.pumpWidget(_testWidget(postsCubit));

      await tester.pumpAndSettle();

      //assert
      expect(find.byKey(const Key("post_item")), findsNWidgets(3));
    });

    testWidgets("should show failure_bottom_sheet when state is error",
        (tester) async {
      //arrange
      whenListen(
        postsCubit,
        Stream.fromIterable([
          PostsState.error(InternalFailure(
              message: "message",
              stackTrace: StackTrace.fromString("stackTrace"))),
        ]),
      );

      await tester.pumpWidget(_testWidget(postsCubit));
      await tester.pumpAndSettle();

      //assert
      expect(find.byKey(const Key("failure_bottom_sheet")), findsOneWidget);
    });
  });

  group("InfiniteListView -", () {
    group("onRefresh -", () {
      testWidgets(
          "should call getFirstPage of postsCubit when onRefresh is invoked with NO filters",
          (tester) async {
        //arrange
        whenListen(
          postsCubit,
          Stream.fromIterable([
            PostsState.loaded(PostsPageResult(hasNextPage: true, posts: [])),
            const PostsState.loading(),
          ]),
        );
        await tester.pumpWidget(_testWidget(postsCubit));
        await tester.pump(Durations.short1);

        //verification
        expect(find.byType(InfiniteListView<PostEntity>), findsOneWidget);
        expect(find.byType(CustomSearchInput), findsOneWidget);

        //act
        tester
            .widget<CustomSearchInput>(find.byType(CustomSearchInput))
            .onSubmit("test search");

        final infiniteListView = tester.widget<InfiniteListView<PostEntity>>(
          find.byType(InfiniteListView<PostEntity>),
        );
        infiniteListView.onRefresh();

        //assert
        verify(
          () => postsCubit.getFirstPage(
            any(
              that: isA<GetPostsFilters>().having(
                (filters) =>
                    filters.search == null &&
                    filters.after == null &&
                    filters.before == null &&
                    filters.categories == null,
                "is no filters",
                true,
              ),
            ),
          ),
        ).called(3);
      });

      testWidgets("should get when ", (tester) async {
        //arrange

        //verification

        //act

        //assert
      });
    });

    testWidgets(
        "should call getNextPageData of postsCubit when scrolled to bottom",
        (tester) async {
      //arrange
      whenListen(
        postsCubit,
        Stream.fromIterable([
          PostsState.loaded(PostsPageResult(hasNextPage: true, posts: [])),
          const PostsState.loading(),
        ]),
      );
      await tester.pumpWidget(_testWidget(postsCubit));
      await tester.pump(Durations.short1);

      //verification
      expect(find.byType(InfiniteListView<PostEntity>), findsOneWidget);

      //act
      final infiniteListView = tester.widget<InfiniteListView<PostEntity>>(
        find.byType(InfiniteListView<PostEntity>),
      );
      infiniteListView.onScrolledToBottom();

      //assert
      verify(() => postsCubit.getNextPageData(any())).called(1);
    });
  });
}

Widget _testWidget(PostsCubit postsCubit) {
  return ScreenUtilInit(
    child: MaterialApp(
      home: BlocProvider(
        create: (context) => postsCubit,
        child: const PostsPage(),
      ),
    ),
  );
}
