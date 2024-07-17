import 'package:wordpress_companion/features/user-login/user_login_exports.dart';

class UserCredentialsModel extends LoginCredentialsEntity {
  const UserCredentialsModel({
    required super.userName,
    required super.applicationPassword,
    required super.domain,
  });
}
