import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/constants/enums.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';

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
}

void main() {
  group("statusText -", () {
    testWidgets(
        "should color be (ColorPallet.lightGreen) when status is (published)",
        (tester) async {
      //arrange
      final post = FakePostEntity().setStatus(PostStatus.publish);

      await _makeTestWidget(tester, post);

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
      await _makeTestWidget(tester, post);

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
      await _makeTestWidget(tester, post);

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
      await _makeTestWidget(tester, post);

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

Future<void> _makeTestWidget(WidgetTester tester, post) {
  return tester.pumpWidget(
    MaterialApp(
      home: Material(
        child: PostItemWidget(post: post),
      ),
    ),
  );
}
