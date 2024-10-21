import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/features/profile/profile_exports.dart';

import '../errors/failures.dart';

abstract class ProfileService {
  Future<Either<Failure, ProfileEntity>> getMyProfile();
}
