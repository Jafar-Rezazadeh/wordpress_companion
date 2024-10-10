import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordpress_companion/core/utils/global_dio_headers_handler.dart';
import 'package:wordpress_companion/features/login/login_exports.dart';
import '../../../../../core/errors/failures.dart';

part 'authentication_state.dart';
part 'authentication_cubit.freezed.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticateUser _authenticateUser;
  final SaveUserCredentials _saveUserCredentials;
  final GlobalDioHeadersHandler _globalDioHeadersHandler;
  AuthenticationCubit({
    required AuthenticateUser authenticateUser,
    required SaveUserCredentials saveUserCredentials,
    required GlobalDioHeadersHandler globalDioHeadersHandler,
  })  : _authenticateUser = authenticateUser,
        _saveUserCredentials = saveUserCredentials,
        _globalDioHeadersHandler = globalDioHeadersHandler,
        super(const AuthenticationState.initial());

  void loginAndSave(LoginCredentialsParams params) async {
    emit(const AuthenticationState.authenticating());
    final result = await _authenticateUser(params);

    result.fold(
      (failure) => emit(AuthenticationState.authenticationFailed(failure)),
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
        rememberMe: params.rememberMe,
      );
      _setGlobalDioHeaders(credentials);

      emit(AuthenticationState.authenticated(credentials));
    } else {
      emit(const AuthenticationState.notValidUser());
    }
  }

  void _setGlobalDioHeaders(LoginCredentialsEntity credentials) {
    _globalDioHeadersHandler.setBaseUrl(credentials.domain);

    _globalDioHeadersHandler.setAuthorization(
      username: credentials.userName,
      password: credentials.applicationPassword,
    );
  }
}
