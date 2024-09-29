import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordpress_companion/core/utils/global_dio_headers_handler.dart';
import 'package:wordpress_companion/features/login/login_exports.dart';

import '../../../../../core/contracts/use_case.dart';
import '../../../../../core/errors/failures.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticateUser _authenticateUser;
  final SaveUserCredentials _saveUserCredentials;
  final GetLastLoginCredentials _getLastLoginCredentials;
  final GlobalDioHeadersHandler _globalDioHeadersHandler;
  LoginCubit({
    required AuthenticateUser authenticateUser,
    required SaveUserCredentials saveUserCredentials,
    required GetLastLoginCredentials getLastLoginCredentials,
    required GlobalDioHeadersHandler globalDioHeadersHandler,
  })  : _authenticateUser = authenticateUser,
        _saveUserCredentials = saveUserCredentials,
        _getLastLoginCredentials = getLastLoginCredentials,
        _globalDioHeadersHandler = globalDioHeadersHandler,
        super(const LoginState.initial());

  void loginAndSave(LoginCredentialsParams params) async {
    emit(const LoginState.loggingIn());
    final result = await _authenticateUser(params);

    result.fold(
      (failure) => emit(LoginState.loginFailed(failure)),
      (isValidUser) async {
        await _handleRememberMe(params);

        _handleUserValidation(isValidUser, params);
      },
    );
  }

  Future<void> _handleRememberMe(LoginCredentialsParams params) async {
    if (params.rememberMe) {
      await _saveUserCredentials(params);
    } else {
      await _saveUserCredentials(
        (
          name: "",
          applicationPassword: "",
          domain: "",
          rememberMe: false,
        ),
      );
    }
  }

  void _handleUserValidation(bool isValidUser, LoginCredentialsParams params) {
    if (isValidUser) {
      final credentials = LoginCredentialsEntity(
        userName: params.name,
        applicationPassword: params.applicationPassword,
        domain: params.domain,
      );
      _setGlobalDioHeaders(credentials);

      emit(LoginState.loginSuccess(credentials));
    } else {
      emit(const LoginState.notValidUser());
    }
  }

  void _setGlobalDioHeaders(LoginCredentialsEntity credentials) {
    _globalDioHeadersHandler.setBaseUrl(credentials.domain);

    _globalDioHeadersHandler.setAuthorization(
      username: credentials.userName,
      password: credentials.applicationPassword,
    );
  }

  // FIXME: should be refactored wrog way to use a cubit should emit some state make another cubit if needed
  Future<LoginCredentialsEntity?> getLastLoginCredentials() async {
    final result = await _getLastLoginCredentials.call(NoParams());

    return result.fold(
      (failure) async => null,
      (userCredentials) {
        _setGlobalDioHeaders(userCredentials);
        return userCredentials;
      },
    );
  }
}
