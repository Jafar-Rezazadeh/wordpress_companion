import 'package:shared_preferences/shared_preferences.dart';

import '../../../user_login_exports.dart';

class LocalUserLoginDataSourceImpl implements LocalUserLoginDataSource {
  final SharedPreferences _sharedPreferences;
  String userNameKey = "userName";
  String applicationPasswordKey = "applicationPassword";
  String domainKey = "domain";

  LocalUserLoginDataSourceImpl({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;
  @override
  Future<UserCredentialsModel> saveCredentials(UserCredentialsParams params) async {
    final isUserNameSaved = await _sharedPreferences.setString(userNameKey, params.name);

    final isApplicationPasswordSaved = await _sharedPreferences.setString(
      applicationPasswordKey,
      params.applicationPassword,
    );

    final isDomainSaved = await _sharedPreferences.setString(domainKey, params.domain);

    if (isUserNameSaved && isApplicationPasswordSaved && isDomainSaved) {
      return UserCredentialsModel(
        userName: params.name,
        applicationPassword: params.applicationPassword,
        domain: params.domain,
      );
    }

    throw Exception("Failed to save credentials");
  }
}
