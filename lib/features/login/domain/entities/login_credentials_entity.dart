import 'package:equatable/equatable.dart';

class LoginCredentialsEntity extends Equatable {
  final String userName;
  final String applicationPassword;
  final String domain;
  final bool rememberMe;

  const LoginCredentialsEntity({
    required this.userName,
    required this.applicationPassword,
    required this.domain,
    required this.rememberMe,
  });

  @override
  List<Object?> get props => [
        userName,
        applicationPassword,
        domain,
      ];
}
