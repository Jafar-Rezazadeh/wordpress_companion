import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/constants/enums.dart';
import 'package:wordpress_companion/features/posts/presentation/login_holders/utils/post_status_filter.dart';

void main() {
  group("validPostStatusAsParam -", () {
    test("should return expected (List<PostStatus>)  ", () {
      //act
      final result = PostStatusFilter.validPostStatusAsParam();

      //assert
      final expectedStatus = [
        PostStatusEnum.publish,
        PostStatusEnum.pending,
        PostStatusEnum.private,
        PostStatusEnum.draft,
      ];

      for (var status in expectedStatus) {
        expect(result, contains(status));
      }
    });

    test("should NOT include (future, trash) ", () {
      //act
      final result = PostStatusFilter.validPostStatusAsParam();

      //assert
      final notIncludedStatus = [
        PostStatusEnum.future,
        PostStatusEnum.trash,
      ];

      for (var status in notIncludedStatus) {
        expect(result, isNot(contains(status)));
      }
    });
  });
}
