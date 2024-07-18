import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../login_exports.dart';

class LocalLoginDataSourceImpl implements LocalLoginDataSource {
  late SharedPreferences _sharedPreferences;
  final String _userNameKey = "userName";
  final String _applicationPasswordKey = "applicationPassword";
  final String _domainKey = "domain";

  LocalLoginDataSourceImpl.test({required SharedPreferences sharedPreferences}) {
    _sharedPreferences = sharedPreferences;
  }

  static Future<LocalLoginDataSource> instance() async {
    WidgetsFlutterBinding.ensureInitialized();
    final sharedPreferences = await SharedPreferences.getInstance();
    return LocalLoginDataSourceImpl.test(sharedPreferences: sharedPreferences);
  }

  @override
  Future<LoginCredentialsModel> saveCredentials(LoginCredentialsParams params) async {
    final isUserNameSaved = await _sharedPreferences.setString(_userNameKey, params.name);

    final isApplicationPasswordSaved = await _sharedPreferences.setString(
      _applicationPasswordKey,
      params.applicationPassword,
    );

    final isDomainSaved = await _sharedPreferences.setString(_domainKey, params.domain);

    if (isUserNameSaved && isApplicationPasswordSaved && isDomainSaved) {
      return LoginCredentialsModel(
        userName: params.name,
        applicationPassword: params.applicationPassword,
        domain: params.domain,
      );
    }

    throw Exception("Failed to save credentials");
  }

  @override
  Future<LoginCredentialsModel> getLastCredentials() async {
    final userName = _sharedPreferences.getString(_userNameKey);
    final applicationPassword = _sharedPreferences.getString(_applicationPasswordKey);
    final domain = _sharedPreferences.getString(_domainKey);

    return LoginCredentialsModel(
      userName: userName ?? "",
      applicationPassword: applicationPassword ?? "",
      domain: domain ?? "",
    );
  }
}
