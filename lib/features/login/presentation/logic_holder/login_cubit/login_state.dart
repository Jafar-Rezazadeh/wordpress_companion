part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loggingIn() = _LoggingIn;
  factory LoginState.loginSuccess(LoginCredentialsEntity credentials) = _LoginSuccess;
  const factory LoginState.notValidUser() = _NotValidUser;
  const factory LoginState.loginFailed(Failure failure) = _LoginFailed;
}
