import 'package:shared_preferences/shared_preferences.dart';

import '../../../user_login_exports.dart';

class LocalUserLoginDataSourceImpl implements LocalUserLoginDataSource {
  late SharedPreferences _sharedPreferences;
  final String _userNameKey = "userName";
  final String _applicationPasswordKey = "applicationPassword";
  final String _domainKey = "domain";

  LocalUserLoginDataSourceImpl.test({required SharedPreferences sharedPreferences}) {
    _sharedPreferences = sharedPreferences;
  }

  LocalUserLoginDataSourceImpl() {
    _getSharedPreferences();
  }

  _getSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future<UserCredentialsModel> saveCredentials(UserCredentialsParams params) async {
    final isUserNameSaved = await _sharedPreferences.setString(_userNameKey, params.name);

    final isApplicationPasswordSaved = await _sharedPreferences.setString(
      _applicationPasswordKey,
      params.applicationPassword,
    );

    final isDomainSaved = await _sharedPreferences.setString(_domainKey, params.domain);

    if (isUserNameSaved && isApplicationPasswordSaved && isDomainSaved) {
      return UserCredentialsModel(
        userName: params.name,
        applicationPassword: params.applicationPassword,
        domain: params.domain,
      );
    }

    throw Exception("Failed to save credentials");
  }

  @override
  Future<UserCredentialsModel> getLastCredentials() async {
    final userName = _sharedPreferences.getString(_userNameKey);
    final applicationPassword = _sharedPreferences.getString(_applicationPasswordKey);
    final domain = _sharedPreferences.getString(_domainKey);

    return UserCredentialsModel(
      userName: userName ?? "",
      applicationPassword: applicationPassword ?? "",
      domain: domain ?? "",
    );
  }
}
