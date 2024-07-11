import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordpress_companion/features/user-login/user_login_exports.dart';

import '../../../../../core/errors/failures.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticateUser _authenticateUser;
  LoginCubit({
    required AuthenticateUser authenticateUser,
  })  : _authenticateUser = authenticateUser,
        super(const LoginState.enterCredentials());

  login(UserAuthenticationParams params) async {
    emit(const LoginState.loggingIn());
    final result = await _authenticateUser(params);

    result.fold(
      (failure) => emit(LoginState.loginFailed(failure)),
      (isValidUser) {
        // TODO: save the user credentials in local storage for next Logins
        isValidUser ? emit(const LoginState.loginSuccess()) : emit(const LoginState.notValidUser());
      },
    );
  }
}
