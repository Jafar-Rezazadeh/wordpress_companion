import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/constants/enums.dart';
import 'package:wordpress_companion/features/categories/presentation/logic_holders/utils/category_order_by_enum_translator.dart';

void main() {
  test("should return Expected Strings ", () {
    //arrange
    final translator = CategoryOrderByEnumTranslator();

    //act
    final name = translator.translate(CategoryOrderByEnum.name);
    final slug = translator.translate(CategoryOrderByEnum.slug);
    final description = translator.translate(CategoryOrderByEnum.description);
    final count = translator.translate(CategoryOrderByEnum.count);

    //assert
    expect(name, "نام");
    expect(slug, "نامک");
    expect(description, "توضیحات");
    expect(count, "تعداد");
  });
}
