import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/constants/enums.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/media/domain/entities/current_page_medias_entity.dart';

import '../repositories/media_repository.dart';

class GetMediaPerPage
    implements UseCase<CurrentPageMediasEntity, GetMediaPerPageParams> {
  final MediaRepository _repository;

  GetMediaPerPage({required MediaRepository mediaRepository})
      : _repository = mediaRepository;

  @override
  Future<Either<Failure, CurrentPageMediasEntity>> call(
      GetMediaPerPageParams params) {
    return _repository.getMediaPerPage(params);
  }
}

class GetMediaPerPageParams {
  final int page;
  final int perPage;

  final String? search;
  final String? after;
  final String? before;
  final MediaType? type;

  GetMediaPerPageParams({
    this.page = 1,
    this.perPage = 10,
    this.search,
    this.after,
    this.before,
    this.type,
  })  : assert(page > 0, 'page must be greater than 0'),
        assert(perPage >= 10, 'perPage must be greater than or equal to 10');

  GetMediaPerPageParams copyWith({
    int? page,
    int? perPage,
    String? search,
    String? after,
    String? before,
    MediaType? type,
  }) {
    return GetMediaPerPageParams(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      search: search ?? this.search,
      after: after ?? this.after,
      before: before ?? this.before,
      type: type ?? this.type,
    );
  }
}
