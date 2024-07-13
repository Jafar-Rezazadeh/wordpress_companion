import 'package:equatable/equatable.dart';

class UserCredentialsEntity extends Equatable {
  final String userName;
  final String applicationPassword;
  final String domain;

  const UserCredentialsEntity({
    required this.userName,
    required this.applicationPassword,
    required this.domain,
  });

  @override
  List<Object?> get props => [
        userName,
        applicationPassword,
        domain,
      ];
}
