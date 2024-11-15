import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_delta_from_html/flutter_quill_delta_from_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/media/domain/entities/media_entity.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';

class MockPostsCubit extends MockCubit<PostsState> implements PostsCubit {}

class FakePostParams extends Fake implements PostParams {}

class FakeMediaEntity extends Fake implements MediaEntity {
  @override
  int get id => 5;

  @override
  String get sourceUrl => "source";
}

void main() {
  late PostParamsBuilder postParamsBuilder;
  late PostsCubit mockPostsCubit;

  final dummyPost = PostEntity(
    id: 60,
    date: DateTime(1),
    guid: "guid",
    modified: DateTime(1),
    slug: "slug",
    status: PostStatusEnum.draft,
    type: "type",
    link: "link",
    title: "title",
    content: "content",
    excerpt: "excerpt",
    author: 1,
    authorName: "authorName",
    featuredMedia: 3,
    featureMediaLink: "featureMediaLink",
    commentStatus: "commentStatus",
    categories: const [1, 2],
    tags: const [63, 5],
  );

  Widget makeTestWidget(PostEntity? post) => ScreenUtilInit(
        child: BlocProvider(
          create: (context) => mockPostsCubit,
          child: MaterialApp(
            home: Material(
              child: EditOrCreatePostScreen(
                post: post,
                postParamsBuilderTest: postParamsBuilder,
              ),
            ),
          ),
        ),
      );

  setUpAll(() {
    registerFallbackValue(FakePostParams());
  });

  setUp(() {
    postParamsBuilder = PostParamsBuilder();
    mockPostsCubit = MockPostsCubit();
    when(
      () => mockPostsCubit.state,
    ).thenAnswer((_) => const PostsState.initial());
  });
  group("postParamsBuilder -", () {
    testWidgets("should set the initial post to builder when it is NOT null",
        (tester) async {
      //arrange
      await tester.pumpWidget(makeTestWidget(dummyPost));
      await tester.pumpAndSettle();

      //verification
      expect(find.byType(EditOrCreatePostScreen), findsOneWidget);

      //act
      final params = postParamsBuilder.build();

      //assert
      expect(params.id, dummyPost.id);
      expect(params.title, dummyPost.title);
      expect(params.slug, dummyPost.slug);
      expect(params.status, dummyPost.status);
      expect(params.categories, dummyPost.categories);
      expect(params.content, dummyPost.content);
      expect(params.excerpt, dummyPost.excerpt);
      expect(params.featuredImage, dummyPost.featuredMedia);
      expect(params.tags, dummyPost.tags);
    });

    testWidgets("should set the input values to builder onChanged ",
        (tester) async {
      //arrange
      await tester.pumpWidget(makeTestWidget(dummyPost));
      await tester.pumpAndSettle();
      //verification
      final statusInputFinder =
          find.byType(CustomDropDownButton<PostStatusEnum>);
      final customInputFinder = find.byType(CustomFormInputField);
      final contentEditorFinder = find.byType(QuillEditor);
      final featuredImageInputFinder = find.byType(FeaturedImageInput);

      expect(statusInputFinder, findsOneWidget);
      expect(customInputFinder, findsNWidgets(4));
      expect(contentEditorFinder, findsOneWidget);
      expect(featuredImageInputFinder, findsOneWidget);

      //act
      await tester
          .widget<CustomDropDownButton<PostStatusEnum>>(statusInputFinder)
          .onChanged(PostStatusEnum.private);

      for (int i = 0; i < 4; i++) {
        await tester.enterText(customInputFinder.at(i), "test");
      }

      const htmlText = "<p>test</p>";

      final delta = HtmlToDelta().convert(htmlText);

      tester
          .widget<QuillEditor>(contentEditorFinder)
          .controller
          .setContents(delta);

      await tester
          .widget<FeaturedImageInput>(featuredImageInputFinder)
          .onImageSelected(FakeMediaEntity());

      final params = postParamsBuilder.build();

      //assert
      expect(params.status, PostStatusEnum.private);
      expect(params.title, "test");
      expect(params.slug, "test");
      expect(params.content, "<p>test</p>");
      expect(params.excerpt, "test");
      expect(params.featuredImage, 5);
    });

    testWidgets(
        "should set featuredImage to 0 when onClear of featuredImageInput called",
        (tester) async {
      //arrange
      await tester.pumpWidget(makeTestWidget(dummyPost));
      await tester.pumpAndSettle();

      //verification
      expect(find.byType(FeaturedImageInput), findsOneWidget);
      final featuredImageInput =
          tester.widget<FeaturedImageInput>(find.byType(FeaturedImageInput));
      featuredImageInput.onImageSelected(FakeMediaEntity());

      expect(postParamsBuilder.build().featuredImage, FakeMediaEntity().id);

      //act
      featuredImageInput.onClearImage();

      //assert
      expect(postParamsBuilder.build().featuredImage, 0);
    });
  });

  group("onSubmit -", () {
    testWidgets("should call createPost when post prop is null",
        (tester) async {
      //arrange
      await tester.pumpWidget(makeTestWidget(null));
      await tester.pumpAndSettle();

      //verification
      final submitFinder = find.byKey(const Key("submit_button"));
      expect(submitFinder, findsOneWidget);

      //act
      await tester.tap(submitFinder);

      //assert
      verify(() => mockPostsCubit.createPosts(any())).called(1);
    });

    testWidgets("should call updatePost when given prop is NOT null",
        (tester) async {
      //arrange
      await tester.pumpWidget(makeTestWidget(dummyPost));
      await tester.pumpAndSettle();

      //verification
      final submitFinder = find.byKey(const Key("submit_button"));
      expect(submitFinder, findsOneWidget);

      //act
      await tester.tap(submitFinder);

      //assert
      verify(() => mockPostsCubit.updatePosts(any())).called(1);
    });
  });

  group("onDelete -", () {
    testWidgets("should show are_you_sure_dialog when user tapped on it",
        (tester) async {
      //arrange
      await tester.pumpWidget(makeTestWidget(dummyPost));
      await tester.pumpAndSettle();

      //verification
      expect(find.byKey(const Key("delete_button")), findsOneWidget);

      //act
      await tester.tap(find.byKey(const Key("delete_button")));
      await tester.pumpAndSettle();

      //assert
      expect(find.byKey(const Key("are_you_sure_dialog")), findsOneWidget);
    });

    testWidgets(
        "should call the deletePost of postsCubit when dialog confirmed",
        (tester) async {
      //arrange
      await tester.pumpWidget(makeTestWidget(dummyPost));

      //verification
      await tester.tap(find.byKey(const Key("delete_button")));
      await tester.pumpAndSettle();

      //act
      await tester.tap(find.byKey(const Key("confirm_button")));

      //assert
      verify(() => mockPostsCubit.deletePost(any())).called(1);
    });
  });

  group("postsCubit -", () {
    testWidgets("should loading on header when state is loading",
        (tester) async {
      when(
        () => mockPostsCubit.state,
      ).thenAnswer((_) => const PostsState.loading());

      await tester.pumpWidget(makeTestWidget(dummyPost));

      //verification
      expect(find.byType(PushedScreenAppBar), findsOneWidget);

      //act
      final header =
          tester.widget<PushedScreenAppBar>(find.byType(PushedScreenAppBar));

      //assert
      expect(header.showLoading, true);
    });
  });
}
