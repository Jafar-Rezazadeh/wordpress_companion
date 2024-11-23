import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../core/contracts/use_case.dart';
import '../../../../../core/utils/global_dio_headers_handler.dart';
import '../../../login_exports.dart';
import '../../../../../core/errors/failures.dart';

part 'authentication_state.dart';
part 'authentication_cubit.freezed.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticateUser _authenticateUser;
  final SaveUserCredentials _saveUserCredentials;
  final ClearCachedCredentials _clearCachedCredentials;
  final GlobalDioHeadersHandler _globalDioHeadersHandler;
  AuthenticationCubit({
    required AuthenticateUser authenticateUser,
    required SaveUserCredentials saveUserCredentials,
    required ClearCachedCredentials clearCachedCredentials,
    required GlobalDioHeadersHandler globalDioHeadersHandler,
  })  : _authenticateUser = authenticateUser,
        _saveUserCredentials = saveUserCredentials,
        _clearCachedCredentials = clearCachedCredentials,
        _globalDioHeadersHandler = globalDioHeadersHandler,
        super(const AuthenticationState.initial());

  Future<void> loginAndSave(LoginCredentialsParams params) async {
    emit(const AuthenticationState.authenticating());
    final result = await _authenticateUser(params);

    result.fold(
      (failure) => emit(AuthenticationState.authenticationFailed(failure)),
      (isValidUser) async => _handleUserValidation(isValidUser, params),
    );
  }

  Future<void> _handleUserValidation(
      bool isValidUser, LoginCredentialsParams params) async {
    if (isValidUser) {
      final credentials = LoginCredentialsEntity(
        userName: params.name,
        applicationPassword: params.applicationPassword,
        domain: params.domain,
        rememberMe: params.rememberMe,
      );
      _setGlobalDioHeaders(credentials);
      await _handleRememberMe(params);

      emit(AuthenticationState.authenticated(credentials));
    } else {
      emit(const AuthenticationState.notValidUser());
    }
  }

  Future<void> _handleRememberMe(LoginCredentialsParams params) async {
    if (params.rememberMe) {
      await _saveUserCredentials(params);
    } else {
      await _clearCachedCredentials(NoParams());
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
