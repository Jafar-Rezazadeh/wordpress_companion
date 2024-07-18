import 'package:wordpress_companion/features/login/login_exports.dart';

abstract class LocalLoginDataSource {
  Future<LoginCredentialsModel> saveCredentials(LoginCredentialsParams params);
  Future<LoginCredentialsModel> getLastCredentials();
}
