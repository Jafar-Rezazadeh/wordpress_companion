import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final int id;
  final String title;
  final String content;
  final String date;

  // TODO: move this entity to its own feature when the feature will have made
  const PostEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        date,
      ];
}
