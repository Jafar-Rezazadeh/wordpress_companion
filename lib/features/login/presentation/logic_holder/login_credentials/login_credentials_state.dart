part of 'login_credentials_cubit.dart';

@freezed
class LoginCredentialsState with _$LoginCredentialsState {
  const factory LoginCredentialsState.initial() = _Initial;
  const factory LoginCredentialsState.gettingCredentials() =
      _GettingCredentials;
  const factory LoginCredentialsState.credentialsReceived(
    LoginCredentialsEntity credentials,
  ) = _CredentialsReceived;

  const factory LoginCredentialsState.error(Failure failure) = _Error;
}
