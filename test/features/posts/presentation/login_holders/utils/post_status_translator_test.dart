import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/posts/presentation/login_holders/utils/post_status_translator.dart';

void main() {
  test("should return expect strings base on status ", () {
    //arrange
    String publish = PostStatusEnum.publish.translate();
    String private = PostStatusEnum.private.translate();
    String pending = PostStatusEnum.pending.translate();
    String future = PostStatusEnum.future.translate();
    String draft = PostStatusEnum.draft.translate();

    //assert
    expect(publish, "انتشار داده شده");
    expect(private, "خصوصی");
    expect(pending, "در انتظار بازبینی");
    expect(future, "انتشار در آینده");
    expect(draft, "پیش نویس");
  });
}
