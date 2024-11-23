import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

class UpdateMedia implements UseCase<MediaEntity, UpdateMediaParams> {
  final MediaRepository _mediaRepository;

  UpdateMedia({required MediaRepository mediaRepository})
      : _mediaRepository = mediaRepository;

  @override
  Future<Either<Failure, MediaEntity>> call(UpdateMediaParams params) {
    return _mediaRepository.updateMedia(params);
  }
}

class UpdateMediaParams extends Equatable {
  final int id;
  final String altText;
  final String title;
  final String caption;
  final String description;

  const UpdateMediaParams({
    required this.id,
    required this.altText,
    required this.title,
    required this.caption,
    required this.description,
  });

  @override
  List<Object?> get props => [id];
}
