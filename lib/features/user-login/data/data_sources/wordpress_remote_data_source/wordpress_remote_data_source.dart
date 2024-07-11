import '../../../domain/usecases/authenticate_user.dart';

abstract class WordpressRemoteDataSource {
  Future<bool> authenticateUser(UserAuthenticationParams params);
}
