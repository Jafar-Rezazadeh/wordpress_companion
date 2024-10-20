import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/entities/profile_avatar.dart';

import '../errors/failures.dart';

abstract class ProfileService {
  Future<Either<Failure, ProfileAvatar>> getProfileAvatar();
}
