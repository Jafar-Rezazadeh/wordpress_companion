import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/categories/application/categories_cubit/categories_cubit.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';

// ignore: must_be_immutable
class FakePostEntity extends Fake implements PostEntity {
  PostStatusEnum _status = PostStatusEnum.publish;

  @override
  int get id => 20;

  @override
  PostStatusEnum get status => _status;

  setStatus(PostStatusEnum status) {
    _status = status;
    return this;
  }

  @override
  String get featureMediaLink => "link";

  @override
  String get title => "title";

  @override
  String get authorName => "author";

  @override
  String get content => "content";

  @override
  DateTime get date => DateTime(1);

  @override
  String get slug => "slug";

  @override
  String get excerpt => "excerpt";

  @override
  List<int> get categories => [12, 5];

  @override
  List<int> get tags => [5, 6];

  @override
  int get featuredMedia => 1;
}

class MockPostsCubit extends MockCubit<PostsState> implements PostsCubit {}

class MockCategoriesCubit extends MockCubit<CategoriesState>
    implements CategoriesCubit {}

void main() {
  late PostsCubit postsCubit;
  late CategoriesCubit categoriesCubit;

  setUp(() {
    postsCubit = MockPostsCubit();
    categoriesCubit = MockCategoriesCubit();

    when(
      () => postsCubit.state,
    ).thenAnswer((_) => const PostsState.initial());
    when(
      () => categoriesCubit.state,
    ).thenAnswer((_) => const CategoriesState.initial());
  });

  Future<Null> makeTestWidgetForRouter(WidgetTester tester) async {
    return await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ScreenUtilInit(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: "/",
              routes: [
                GoRoute(
                  path: "/",
                  builder: (context, state) => Material(
                    child: PostItemWidget(post: FakePostEntity()),
                  ),
                  routes: [
                    GoRoute(
                      name: editOrCreatePostRoute,
                      path: editOrCreatePostRoute,
                      builder: (context, state) {
                        final post = state.extra as PostEntity?;

                        return Material(
                          child: MultiBlocProvider(
                            providers: [
                              BlocProvider(create: (context) => postsCubit),
                              BlocProvider(
                                  create: (context) => categoriesCubit),
                            ],
                            child: EditOrCreatePostScreen(post: post),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  group("onTap -", () {
    testWidgets("should go to editOrCreatePostRoute when the post item tapped",
        (tester) async {
      //arrange
      await makeTestWidgetForRouter(tester);
      await tester.pumpAndSettle();

      //act
      await tester.tap(find.byType(PostItemWidget).first);
      await tester.pumpAndSettle();

      //assert
      expect(find.byType(EditOrCreatePostScreen), findsOneWidget);
    });
    testWidgets(
        "should go to editOrCreatePostRoute and send the post when the post item tapped",
        (tester) async {
      //arrange
      await makeTestWidgetForRouter(tester);

      //verification

      //act
      await tester.tap(find.byType(ListTile));
      await tester.pumpAndSettle();

      //assert
      final editOrCreateScreenFinder = find.byType(EditOrCreatePostScreen);
      expect(editOrCreateScreenFinder, findsOneWidget);
      final postInEditCreateScreen = tester
          .widget<EditOrCreatePostScreen>(
            editOrCreateScreenFinder,
          )
          .post;
      expect(postInEditCreateScreen, isNotNull);
    });
  });
  group("statusText -", () {
    testWidgets(
        "should color be (ColorPallet.lightGreen) when status is (published)",
        (tester) async {
      //arrange
      final post = FakePostEntity().setStatus(PostStatusEnum.publish);

      await _makeSimpleTestWidget(tester, post);

      //verification
      expect(find.byKey(const Key("status_text")), findsOneWidget);

      //act
      final statusTextColor = _getTextColor(tester);

      //assert
      expect(statusTextColor, ColorPallet.lightGreen);
    });

    testWidgets("should color be (ColorPallet.yellow) when status is (pending)",
        (tester) async {
      //arrange
      final post = FakePostEntity().setStatus(PostStatusEnum.pending);
      await _makeSimpleTestWidget(tester, post);

      //verification
      expect(find.byKey(const Key("status_text")), findsOneWidget);

      //act
      final textColor = _getTextColor(tester);

      //assert
      expect(textColor, ColorPallet.yellow);
    });

    testWidgets(
        "should color be (ColorPallet.yellowishGreen) when status is (draft)",
        (tester) async {
      //arrange
      final post = FakePostEntity().setStatus(PostStatusEnum.draft);
      await _makeSimpleTestWidget(tester, post);

      //verification
      expect(find.byKey(const Key("status_text")), findsOneWidget);

      //act
      final textColor = _getTextColor(tester);

      //assert
      expect(textColor, ColorPallet.yellowishGreen);
    });
    testWidgets("should color be (ColorPallet.crimson) when status is (trash)",
        (tester) async {
      //arrange
      final post = FakePostEntity().setStatus(PostStatusEnum.trash);
      await _makeSimpleTestWidget(tester, post);

      //verification
      expect(find.byKey(const Key("status_text")), findsOneWidget);

      //act
      final textColor = _getTextColor(tester);

      //assert
      expect(textColor, ColorPallet.crimson);
    });

    testWidgets(
        "should color be (ColorPallet.blue) when status is NOT (publish,pending,draft)",
        (tester) async {
      //arrange
      final post = FakePostEntity().setStatus(PostStatusEnum.private);
      await _makeSimpleTestWidget(tester, post);

      //verification
      expect(find.byKey(const Key("status_text")), findsOneWidget);

      //act
      final textColor = _getTextColor(tester);

      //assert
      expect(textColor, ColorPallet.blue);
    });
  });
}

Color _getTextColor(WidgetTester tester) {
  return tester
      .widget<Text>(find.byKey(const Key("status_text")))
      .style!
      .color!;
}

Future<void> _makeSimpleTestWidget(WidgetTester tester, post) {
  return tester.pumpWidget(
    MaterialApp(
      home: Material(
        child: PostItemWidget(post: post),
      ),
    ),
  );
}
