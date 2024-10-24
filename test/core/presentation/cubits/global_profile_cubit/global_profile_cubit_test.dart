import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/core/presentation/cubits/global_profile_cubit/global_profile_cubit.dart';
import 'package:wordpress_companion/core/services/profile_service.dart';
import 'package:wordpress_companion/features/profile/profile_exports.dart';

class MockProfileService extends Mock implements ProfileService {}

class FakeProfileEntity extends Fake implements ProfileEntity {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockProfileService mockProfileService;
  late GlobalProfileCubit globalProfileCubit;

  setUp(() {
    mockProfileService = MockProfileService();
    globalProfileCubit = GlobalProfileCubit(profileService: mockProfileService);
  });

  group("getMyProfile -", () {
    blocTest<GlobalProfileCubit, GlobalProfileState>(
      'emits [loading, loaded] when success to get my profile',
      setUp: () {
        when(
          () => mockProfileService.getMyProfile(),
        ).thenAnswer((_) async => right(FakeProfileEntity()));
      },
      build: () => globalProfileCubit,
      act: (cubit) => cubit.getMyProfile(),
      expect: () => [
        isA<GlobalProfileState>().having(
          (state) => state.whenOrNull(loading: () => true),
          'is loading state',
          true,
        ),
        isA<GlobalProfileState>().having(
          (state) => state.whenOrNull(loaded: (_) => true),
          'is loaded state',
          true,
        ),
      ],
    );

    blocTest<GlobalProfileCubit, GlobalProfileState>(
      'emits [loading, error] when fails to get my profile',
      setUp: () {
        when(
          () => mockProfileService.getMyProfile(),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => globalProfileCubit,
      act: (cubit) => cubit.getMyProfile(),
      expect: () => [
        isA<GlobalProfileState>().having(
          (state) => state.whenOrNull(loading: () => true),
          'is loading state',
          true,
        ),
        isA<GlobalProfileState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          'is error state',
          true,
        ),
      ],
    );
  });
}
