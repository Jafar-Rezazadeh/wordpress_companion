import 'package:equatable/equatable.dart';
import 'package:wordpress_companion/core/core_export.dart';

class PostEntity extends Equatable {
  final int id;
  final DateTime date;
  final String guid;
  final DateTime modified;
  final String slug;
  final PostStatusEnum status;
  final String type;
  final String link;
  final String title;
  final String content;
  final String excerpt;
  final int author;
  final String authorName;
  final int featuredMedia;
  final String featureMediaLink;
  final String commentStatus;
  final List<int> categories;
  final List<int> tags;

  const PostEntity({
    required this.id,
    required this.date,
    required this.guid,
    required this.modified,
    required this.slug,
    required this.status,
    required this.type,
    required this.link,
    required this.title,
    required this.content,
    required this.excerpt,
    required this.author,
    required this.authorName,
    required this.featuredMedia,
    required this.featureMediaLink,
    required this.commentStatus,
    required this.categories,
    required this.tags,
  });

  @override
  List<Object?> get props => [id];
}
