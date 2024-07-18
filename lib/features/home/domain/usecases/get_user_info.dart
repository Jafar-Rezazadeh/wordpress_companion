import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/home/domain/entities/user_entity.dart';
import 'package:wordpress_companion/features/home/home_exports.dart';
import 'package:wordpress_companion/features/login/login_exports.dart';

class GetUserInfo implements UseCase<UserEntity, LoginCredentialsEntity> {
  final UserService _userService;

  GetUserInfo({required UserService userService}) : _userService = userService;
  @override
  Future<Either<Failure, UserEntity>> call(LoginCredentialsEntity params) async {
    return await _userService.getUserInfo(params);
  }
}
