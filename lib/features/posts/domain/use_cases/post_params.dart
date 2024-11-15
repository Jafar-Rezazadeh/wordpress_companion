import 'package:wordpress_companion/core/core_export.dart';

class PostParams {
  final int id;
  final String title;
  final String slug;
  final PostStatus status;
  final String content;
  final String excerpt;
  final List<int> categories;
  final List<int> tags;
  final int featuredImage;

  PostParams({
    required this.id,
    required this.title,
    required this.slug,
    required this.status,
    required this.content,
    required this.excerpt,
    required this.categories,
    required this.tags,
    required this.featuredImage,
  });
}
