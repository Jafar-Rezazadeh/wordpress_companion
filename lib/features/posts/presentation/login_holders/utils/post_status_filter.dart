import 'package:wordpress_companion/core/core_export.dart';

class PostStatusFilter {
  static List<PostStatusEnum> validPostStatusAsParam() {
    return PostStatusEnum.values
        .where(
          (element) =>
              element != PostStatusEnum.trash &&
              element != PostStatusEnum.future,
        )
        .toList();
  }
}
