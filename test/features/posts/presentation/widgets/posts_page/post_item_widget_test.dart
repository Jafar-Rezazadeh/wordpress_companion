import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';
import 'package:wordpress_companion/features/posts/presentation/screens/edit_or_create_post_screen.dart';

// ignore: must_be_immutable
class FakePostEntity extends Fake implements PostEntity {
  PostStatus _status = PostStatus.publish;

  @override
  PostStatus get status => _status;

  setStatus(PostStatus status) {
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
  DateTime get date => DateTime(1);

  @override
  String get slug => "slug";
}

void main() {
  group("onTap -", () {
    testWidgets("should go to editOrCreatePostRoute when the post item tapped",
        (tester) async {
      //arrange
      await _makeTestWidgetForRouter(tester);

      //verification

      //act
      await tester.tap(find.byType(PostItemWidget));
      await tester.pumpAndSettle();

      //assert
      expect(find.byType(EditOrCreatePostScreen), findsOneWidget);
    });
    testWidgets(
        "should go to editOrCreatePostRoute and send the post when the post item tapped",
        (tester) async {
      //arrange
      await _makeTestWidgetForRouter(tester);

      //verification

      //act
      await tester.tap(find.byType(PostItemWidget));
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
      final post = FakePostEntity().setStatus(PostStatus.publish);

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
      final post = FakePostEntity().setStatus(PostStatus.pending);
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
      final post = FakePostEntity().setStatus(PostStatus.draft);
      await _makeSimpleTestWidget(tester, post);

      //verification
      expect(find.byKey(const Key("status_text")), findsOneWidget);

      //act
      final textColor = _getTextColor(tester);

      //assert
      expect(textColor, ColorPallet.yellowishGreen);
    });

    testWidgets(
        "should color be (ColorPallet.blue) when status is NOT (publish,pending,draft)",
        (tester) async {
      //arrange
      final post = FakePostEntity().setStatus(PostStatus.private);
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

Future<Null> _makeTestWidgetForRouter(WidgetTester tester) async {
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
                          child: EditOrCreatePostScreen(post: post));
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
