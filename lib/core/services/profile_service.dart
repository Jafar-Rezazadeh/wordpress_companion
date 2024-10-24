import 'package:dartz/dartz.dart';
import '../../features/profile/profile_exports.dart';

import '../errors/failures.dart';

abstract class ProfileService {
  Future<Either<Failure, ProfileEntity>> getMyProfile();
}
