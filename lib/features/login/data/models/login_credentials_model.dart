import '../../login_exports.dart';

class LoginCredentialsModel extends LoginCredentialsEntity {
  const LoginCredentialsModel({
    required super.userName,
    required super.applicationPassword,
    required super.domain,
    required super.rememberMe,
  });
}
