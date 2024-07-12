part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loggingIn() = _LoggingIn;
  const factory LoginState.loginSuccess() = _LoginSuccess;
  const factory LoginState.notValidUser() = _NotValidUser;
  const factory LoginState.loginFailed(Failure failure) = _LoginFailed;
}
