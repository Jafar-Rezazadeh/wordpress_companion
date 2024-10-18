import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/constants/enums.dart';
import 'package:wordpress_companion/core/utils/enum_translator.dart';

void main() {
  group("translateUserRole -", () {
    test("should return expected String base on given role ", () {
      //assert
      expect(_translateUserRole(UserRole.administrator), "مدیر کل");
      expect(_translateUserRole(UserRole.author), "نویسنده");
      expect(_translateUserRole(UserRole.contributor), "مشارکت کننده");
      expect(_translateUserRole(UserRole.editor), "ویرایشگر");
      expect(_translateUserRole(UserRole.subscriber), "مشترک");
    });
  });
}

String _translateUserRole(UserRole role) =>
    EnumTranslator.translateUserRole(role);
