import 'package:wordpress_companion/core/core_export.dart';

extension PostStatusTranslator on PostStatus {
  String translate() {
    switch (this) {
      case PostStatus.publish:
        return "انتشار داده شده";

      case PostStatus.private:
        return "خصوصی";

      case PostStatus.pending:
        return "در انتظار بازبینی";

      case PostStatus.future:
        return "انتشار در آینده";

      case PostStatus.draft:
        return "پیش نویس";
    }
  }
}
