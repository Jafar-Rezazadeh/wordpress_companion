import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/login/login_exports.dart';

class MockGetLastLoginCredentials extends Mock
    implements GetLastLoginCredentials {}

class FakeLoginCredentialsEntity extends Fake
    implements LoginCredentialsEntity {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late LoginCredentialsCubit loginCredentialsCubit;
  late MockGetLastLoginCredentials mockGetLastLoginCredentials;

  setUpAll(() {
    registerFallbackValue(NoParams());
  });

  setUp(() {
    mockGetLastLoginCredentials = MockGetLastLoginCredentials();
    loginCredentialsCubit = LoginCredentialsCubit(
        getLastLoginCredentials: mockGetLastLoginCredentials);
  });

  group("getLastLoginCredentials -", () {
    blocTest<LoginCredentialsCubit, LoginCredentialsState>(
      'emits [gettingCredentials, credentialsReceived] when success',
      setUp: () {
        when(
          () => mockGetLastLoginCredentials.call(any()),
        ).thenAnswer((invocation) async => right(FakeLoginCredentialsEntity()));
      },
      build: () => loginCredentialsCubit,
      act: (cubit) => cubit.getLastLoginCredentials(),
      expect: () => [
        isA<LoginCredentialsState>().having(
          (state) => state.whenOrNull(gettingCredentials: () => true),
          "is gettingCredentials state",
          true,
        ),
        isA<LoginCredentialsState>().having(
          (state) => state.whenOrNull(credentialsReceived: (_) => true),
          "is credentialsReceived state",
          true,
        ),
      ],
    );

    blocTest<LoginCredentialsCubit, LoginCredentialsState>(
      'emits [gettingCredentials, error] when fails',
      setUp: () {
        when(
          () => mockGetLastLoginCredentials.call(any()),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => loginCredentialsCubit,
      act: (cubit) => cubit.getLastLoginCredentials(),
      expect: () => [
        isA<LoginCredentialsState>().having(
          (state) => state.whenOrNull(gettingCredentials: () => true),
          "is gettingCredentials state",
          true,
        ),
        isA<LoginCredentialsState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          "is error state",
          true,
        ),
      ],
    );
  });
}
