import 'package:equatable/equatable.dart';

class TagEntity extends Equatable {
  final int id;
  final String name;
  final String slug;
  final String description;
  final int count;

  const TagEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.count,
  });

  @override
  List<Object?> get props => [id];
}
