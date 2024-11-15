import 'package:wordpress_companion/core/core_export.dart';

class PostStatusFilter {
  static List<PostStatus> validPostStatusAsParam() {
    return PostStatus.values
        .where(
          (element) =>
              element != PostStatus.trash && element != PostStatus.future,
        )
        .toList();
  }
}
