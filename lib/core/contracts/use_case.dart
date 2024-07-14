import 'package:dartz/dartz.dart';

import '../errors/failures.dart';

abstract class UseCase<T, Param> {
  Future<Either<Failure, T>> call(Param params);
}

class NoParams {}
