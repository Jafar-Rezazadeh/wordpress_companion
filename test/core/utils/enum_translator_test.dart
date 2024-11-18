import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/constants/enums.dart';
import 'package:wordpress_companion/core/utils/enum_translator.dart';

void main() {
  group("translateUserRole -", () {
    test("should return expected String base on given role ", () {
      //assert
      expect(_translateUserRole(UserRoleEnum.administrator), "مدیر کل");
      expect(_translateUserRole(UserRoleEnum.author), "نویسنده");
      expect(_translateUserRole(UserRoleEnum.contributor), "مشارکت کننده");
      expect(_translateUserRole(UserRoleEnum.editor), "ویرایشگر");
      expect(_translateUserRole(UserRoleEnum.subscriber), "مشترک");
    });
  });
}

String _translateUserRole(UserRoleEnum role) =>
    EnumTranslator.translateUserRole(role);
