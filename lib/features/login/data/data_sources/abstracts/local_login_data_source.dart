import '../../../login_exports.dart';

abstract class LocalLoginDataSource {
  Future<LoginCredentialsModel> saveCredentials(LoginCredentialsParams params);
  Future<LoginCredentialsModel> getLastCredentials();
  Future<void> clearCachedCredentials();
}
