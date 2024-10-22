import '../constants/enums.dart';

class EnumTranslator {
  static String translateUserRole(UserRole role) {
    switch (role) {
      case UserRole.subscriber:
        return "مشترک";
      case UserRole.contributor:
        return "مشارکت کننده";
      case UserRole.author:
        return "نویسنده";
      case UserRole.editor:
        return "ویرایشگر";
      case UserRole.administrator:
        return "مدیر کل";
    }
  }
}
