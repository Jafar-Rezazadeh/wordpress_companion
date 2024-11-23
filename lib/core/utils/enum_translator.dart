import '../constants/enums.dart';

class EnumTranslator {
  static String translateUserRole(UserRoleEnum role) {
    switch (role) {
      case UserRoleEnum.subscriber:
        return "مشترک";
      case UserRoleEnum.contributor:
        return "مشارکت کننده";
      case UserRoleEnum.author:
        return "نویسنده";
      case UserRoleEnum.editor:
        return "ویرایشگر";
      case UserRoleEnum.administrator:
        return "مدیر کل";
    }
  }
}
