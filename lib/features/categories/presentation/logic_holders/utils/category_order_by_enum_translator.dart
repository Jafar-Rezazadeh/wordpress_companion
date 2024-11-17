import 'package:wordpress_companion/core/constants/enums.dart';

class CategoryOrderByEnumTranslator {
  translate(CategoryOrderByEnum value) {
    switch (value) {
      case CategoryOrderByEnum.name:
        return "نام";

      case CategoryOrderByEnum.slug:
        return "نامک";

      case CategoryOrderByEnum.description:
        return "توضیحات";

      case CategoryOrderByEnum.count:
        return "تعداد";
    }
  }
}
