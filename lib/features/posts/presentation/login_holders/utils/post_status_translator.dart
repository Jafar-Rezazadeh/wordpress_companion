import 'package:wordpress_companion/core/core_export.dart';

extension PostStatusTranslator on PostStatusEnum {
  String translate() {
    switch (this) {
      case PostStatusEnum.publish:
        return "انتشار داده شده";

      case PostStatusEnum.private:
        return "خصوصی";

      case PostStatusEnum.pending:
        return "در انتظار بازبینی";

      case PostStatusEnum.future:
        return "انتشار در آینده";

      case PostStatusEnum.draft:
        return "پیش نویس";

      case PostStatusEnum.trash:
        return "زباله دان";
    }
  }
}
