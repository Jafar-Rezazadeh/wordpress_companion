import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordpress_companion/features/user-login/user_login_exports.dart';

import '../../../../../core/contracts/use_case.dart';
import '../../../../../core/errors/failures.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticateUser _authenticateUser;
  final SaveUserCredentials _saveUserCredentials;
  final GetLastLoginCredentials _getLastLoginCredentials;
  LoginCubit({
    required AuthenticateUser authenticateUser,
    required SaveUserCredentials saveUserCredentials,
    required GetLastLoginCredentials getLastLoginCredentials,
  })  : _authenticateUser = authenticateUser,
        _saveUserCredentials = saveUserCredentials,
        _getLastLoginCredentials = getLastLoginCredentials,
        super(const LoginState.initial());

  login(UserCredentialsParams params) async {
    emit(const LoginState.loggingIn());
    final result = await _authenticateUser(params);

    result.fold(
      (failure) => emit(LoginState.loginFailed(failure)),
      (isValidUser) async {
        await _handleRememberMe(params);
        // TODO: 1) set the dio options to avoid side effect
        isValidUser ? emit(const LoginState.loginSuccess()) : emit(const LoginState.notValidUser());
      },
    );
  }

  Future<void> _handleRememberMe(UserCredentialsParams params) async {
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

  Future<LoginCredentialsEntity?> getLastLoginCredentials() async {
    final result = await _getLastLoginCredentials.call(NoParams());

    return result.fold(
      (failure) async {
        return null;
      },
      (userCredentials) {
        // TODO: 2) set the dio options to avoid side effect
        return userCredentials;
      },
    );
  }
}
