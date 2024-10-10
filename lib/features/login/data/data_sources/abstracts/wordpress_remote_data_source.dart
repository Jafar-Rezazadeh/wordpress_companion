import '../../../domain/use_cases/authenticate_user.dart';

abstract class WordpressRemoteDataSource {
  Future<bool> authenticateUser(LoginCredentialsParams params);
}
