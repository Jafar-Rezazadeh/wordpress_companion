import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/profile/profile_exports.dart';

import '../../../../../dummy_params.dart';

class MockGetMyProfile extends Mock implements GetMyProfile {}

class MockUpdateMyProfile extends Mock implements UpdateMyProfile {}

class FakeProfileEntity extends Fake implements ProfileEntity {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockGetMyProfile mockGetMyProfile;
  late MockUpdateMyProfile mockUpdateMyProfile;
  late ProfileCubit profileCubit;

  setUpAll(() {
    registerFallbackValue(NoParams());
    registerFallbackValue(DummyParams.updateMyProfileParams);
  });

  setUp(() {
    mockGetMyProfile = MockGetMyProfile();
    mockUpdateMyProfile = MockUpdateMyProfile();
    profileCubit = ProfileCubit(
      getMyProfile: mockGetMyProfile,
      updateMyProfile: mockUpdateMyProfile,
    );
  });

  group("getMyProfile -", () {
    blocTest<ProfileCubit, ProfileState>(
      'emits [loading, loaded] when success to get data',
      setUp: () {
        when(
          () => mockGetMyProfile.call(any()),
        ).thenAnswer((_) async => right(FakeProfileEntity()));
      },
      build: () => profileCubit,
      act: (cubit) => cubit.getMyProfile(),
      expect: () => [
        isA<ProfileState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<ProfileState>().having(
          (state) => state.whenOrNull(loaded: (_) => true),
          "is loaded state",
          true,
        ),
      ],
      verify: (_) => verify(() => mockGetMyProfile.call(any())).called(1),
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits [loading, error] when fails to get data',
      setUp: () {
        when(
          () => mockGetMyProfile.call(any()),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => profileCubit,
      act: (cubit) => cubit.getMyProfile(),
      expect: () => [
        isA<ProfileState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<ProfileState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          "is error state",
          true,
        ),
      ],
      verify: (_) => verify(() => mockGetMyProfile.call(any())).called(1),
    );
  });

  group("updateMyProfile -", () {
    blocTest<ProfileCubit, ProfileState>(
      'emits [loading, loaded] when success to updated the data',
      setUp: () {
        when(
          () => mockUpdateMyProfile.call(any()),
        ).thenAnswer((_) async => right(FakeProfileEntity()));
      },
      build: () => profileCubit,
      act: (cubit) => cubit.updateProfile(DummyParams.updateMyProfileParams),
      expect: () => [
        isA<ProfileState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<ProfileState>().having(
          (state) => state.whenOrNull(loaded: (_) => true),
          "is loaded state",
          true,
        ),
      ],
      verify: (_) => verify(() => mockUpdateMyProfile.call(any())).called(1),
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits [loading, error] when fails to update',
      setUp: () {
        when(
          () => mockUpdateMyProfile.call(any()),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => profileCubit,
      act: (cubit) => cubit.updateProfile(DummyParams.updateMyProfileParams),
      expect: () => [
        isA<ProfileState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<ProfileState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          "is error state",
          true,
        ),
      ],
      verify: (_) => verify(() => mockUpdateMyProfile.call(any())).called(1),
    );
  });
}
