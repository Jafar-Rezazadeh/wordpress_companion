part of 'authentication_cubit.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.initial() = _Initial;
  const factory AuthenticationState.authenticating() = _Authenticating;
  factory AuthenticationState.authenticated(
      LoginCredentialsEntity credentials) = _Authenticated;
  const factory AuthenticationState.notValidUser() = _NotValidUser;
  const factory AuthenticationState.authenticationFailed(Failure failure) =
      _AuthenticationFailed;
}
