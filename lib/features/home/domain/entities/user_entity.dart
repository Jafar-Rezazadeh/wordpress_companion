import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  // TODO: move this entity to its own feature when the feature will have made
  final int id;
  final String name;
  final String email;

  const UserEntity({required this.id, required this.name, required this.email});

  @override
  List<Object?> get props => [id, name, email];
}
