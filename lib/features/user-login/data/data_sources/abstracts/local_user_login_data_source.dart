import 'package:wordpress_companion/features/user-login/user_login_exports.dart';

abstract class LocalUserLoginDataSource {
  Future<UserCredentialsModel> saveCredentials(LoginCredentialsParams params);
  Future<UserCredentialsModel> getLastCredentials();
}
