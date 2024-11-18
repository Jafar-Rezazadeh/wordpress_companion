import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int id;
  final int count;
  final String description;
  final String link;
  final String name;
  final String slug;
  final int parent;

  const CategoryEntity({
    required this.id,
    required this.count,
    required this.description,
    required this.link,
    required this.name,
    required this.slug,
    required this.parent,
  });

  @override
  List<Object?> get props => [id];
}
