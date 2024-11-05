import 'package:equatable/equatable.dart';
import 'package:wordpress_companion/features/media/domain/entities/media_details_entity.dart';

class MediaEntity extends Equatable {
  final int id;
  final DateTime date;
  final String guid;
  final DateTime modified;
  final String slug;
  final String status;
  final String type;
  final String link;
  final String title;
  final int author;
  final int featuredMedia;
  final String commentStatus;
  final String pingStatus;
  final String template;
  final String permalinkTemplate;
  final String generatedSlug;
  final List<String> classList;
  final String description;
  final String caption;
  final String altText;
  final String mediaType;
  final String mimeType;
  final MediaDetailsEntity mediaDetails;
  final int? post;
  final String sourceUrl;
  final String? authorName;

  const MediaEntity({
    required this.id,
    required this.date,
    required this.guid,
    required this.modified,
    required this.slug,
    required this.status,
    required this.type,
    required this.link,
    required this.title,
    required this.author,
    required this.featuredMedia,
    required this.commentStatus,
    required this.pingStatus,
    required this.template,
    required this.permalinkTemplate,
    required this.generatedSlug,
    required this.classList,
    required this.description,
    required this.caption,
    required this.altText,
    required this.mediaType,
    required this.mimeType,
    required this.mediaDetails,
    required this.post,
    required this.sourceUrl,
    required this.authorName,
  });

  @override
  List<Object?> get props => [id];
}
