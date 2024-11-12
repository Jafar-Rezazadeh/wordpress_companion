import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/posts/presentation/login_holders/utils/post_status_translator.dart';

void main() {
  test("should return expect strings base on status ", () {
    //arrange
    String publish = PostStatus.publish.translate();
    String private = PostStatus.private.translate();
    String pending = PostStatus.pending.translate();
    String future = PostStatus.future.translate();
    String draft = PostStatus.draft.translate();

    //assert
    expect(publish, "انتشار داده شده");
    expect(private, "خصوصی");
    expect(pending, "در انتظار بازبینی");
    expect(future, "انتشار در آینده");
    expect(draft, "پیش نویس");
  });
}
