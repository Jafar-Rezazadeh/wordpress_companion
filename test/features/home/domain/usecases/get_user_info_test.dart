import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/home/domain/entities/user_entity.dart';
import 'package:wordpress_companion/features/home/home_exports.dart';
import 'package:wordpress_companion/features/login/login_exports.dart';

class MockUserService extends Mock implements UserService {}

class FakeLoginCredentialsEntity extends Fake implements LoginCredentialsEntity {}

class FakeUserEntity extends Fake implements UserEntity {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late GetUserInfo getUserInfo;
  late MockUserService mockUserService;
  final FakeLoginCredentialsEntity fakeLoginCredentialsEntity = FakeLoginCredentialsEntity();

  setUp(() {
    mockUserService = MockUserService();
    getUserInfo = GetUserInfo(userService: mockUserService);
  });

  test(
    "should return (UserEntity) when success",
    () async {
      //arrange
      when(
        () => mockUserService.getUserInfo(fakeLoginCredentialsEntity),
      ).thenAnswer((invocation) async => right(FakeUserEntity()));

      //act
      final result = await getUserInfo.call(fakeLoginCredentialsEntity);
      final user = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(user, isA<UserEntity>());
    },
  );

  test(
    "should return (Failure) when unsuccessful",
    () async {
      //arrange
      when(
        () => mockUserService.getUserInfo(fakeLoginCredentialsEntity),
      ).thenAnswer((invocation) async => left(FakeFailure()));

      //act
      final result = await getUserInfo.call(fakeLoginCredentialsEntity);
      final failure = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(failure, isA<Failure>());
    },
  );
}
