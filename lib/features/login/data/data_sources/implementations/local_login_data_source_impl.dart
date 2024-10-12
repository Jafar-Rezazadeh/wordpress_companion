import 'package:shared_preferences/shared_preferences.dart';

import '../../../login_exports.dart';

class LocalLoginDataSourceImpl implements LocalLoginDataSource {
  late SharedPreferences _sharedPreferences;
  final String _userNameKey = "userName";
  final String _applicationPasswordKey = "applicationPassword";
  final String _domainKey = "domain";
  final String _rememberMeKey = "rememberMe";

  LocalLoginDataSourceImpl.instance(
      {required SharedPreferences sharedPreferences}) {
    _sharedPreferences = sharedPreferences;
  }

  @override
  Future<LoginCredentialsModel> saveCredentials(
      LoginCredentialsParams params) async {
    final isUserNameSaved =
        await _sharedPreferences.setString(_userNameKey, params.name);

    final isApplicationPasswordSaved = await _sharedPreferences.setString(
      _applicationPasswordKey,
      params.applicationPassword,
    );

    final isDomainSaved =
        await _sharedPreferences.setString(_domainKey, params.domain);

    final isRememberMeSaved =
        await _sharedPreferences.setBool(_rememberMeKey, params.rememberMe);

    if (isUserNameSaved &&
        isApplicationPasswordSaved &&
        isDomainSaved &&
        isRememberMeSaved) {
      return LoginCredentialsModel(
        userName: params.name,
        applicationPassword: params.applicationPassword,
        domain: params.domain,
        rememberMe: params.rememberMe,
      );
    }

    throw Exception("Failed to save credentials");
  }

  @override
  Future<LoginCredentialsModel> getLastCredentials() async {
    final userName = _sharedPreferences.getString(_userNameKey);
    final applicationPassword =
        _sharedPreferences.getString(_applicationPasswordKey);
    final domain = _sharedPreferences.getString(_domainKey);
    final rememberMe = _sharedPreferences.getBool(_rememberMeKey);

    return LoginCredentialsModel(
      userName: userName ?? "",
      applicationPassword: applicationPassword ?? "",
      domain: domain ?? "",
      rememberMe: rememberMe ?? false,
    );
  }

  @override
  Future<void> clearCachedCredentials() async {
    final isAllRemoved = await Future.wait([
      _sharedPreferences.remove(_userNameKey),
      _sharedPreferences.remove(_applicationPasswordKey),
      _sharedPreferences.remove(_domainKey),
      _sharedPreferences.remove(_rememberMeKey),
    ]);

    isAllRemoved.every((e) => e == true)
        ? null
        : throw Exception("Failed to clear credentials");
  }
}
