import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/profile/profile_exports.dart';

class MockGetMyProfile extends Mock implements GetMyProfile {}

class MockUpdateMyProfile extends Mock implements UpdateMyProfile {}

class FakeProfileEntity extends Fake implements ProfileEntity {
  @override
  String get name => "test name";
}

class FakeUpdateMyProfileParams extends Fake implements UpdateMyProfileParams {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockGetMyProfile mockGetMyProfile;
  late MockUpdateMyProfile mockUpdateMyProfile;
  late ProfileController profileController;

  setUpAll(() {
    registerFallbackValue(NoParams());
    registerFallbackValue(FakeUpdateMyProfileParams());
  });

  setUp(() {
    Get.reset();
    Get.testMode = true;

    mockGetMyProfile = MockGetMyProfile();
    mockUpdateMyProfile = MockUpdateMyProfile();
    when(
      () => mockGetMyProfile.call(any()),
    ).thenAnswer((_) async => right(FakeProfileEntity()));

    Get.create(
      () => ProfileController(
        getMyProfile: mockGetMyProfile,
        updateMyProfile: mockUpdateMyProfile,
      ),
      permanent: false,
    );

    profileController = Get.find<ProfileController>();
  });

  group("getMyProfile -", () {
    test("should status be (loading, success) when success", () async {
      //arrange
      when(
        () => mockGetMyProfile.call(any()),
      ).thenAnswer((invocation) async => right(FakeProfileEntity()));

      //act
      await profileController.getMyProfile();

      //assert
      expect(profileController.statusHistory.length, 2);
      expect(profileController.statusHistory[0].isLoading, true);
      expect(profileController.statusHistory[1].isSuccess, true);
    });

    test("should state be (ProfileEntity) when status is success", () async {
      //arrange
      when(
        () => mockGetMyProfile.call(any()),
      ).thenAnswer((_) async => right(FakeProfileEntity()));

      //act
      await profileController.getMyProfile();

      //assert
      expect(profileController.state, isNotNull);
    });

    test("should status be (loading, error)  when fails", () async {
      //arrange
      profileController.statusHistory.clear();
      when(
        () => mockGetMyProfile.call(any()),
      ).thenAnswer(
        (_) async => left(
          InternalFailure(
            message: "",
            stackTrace: StackTrace.fromString("stackTraceString"),
          ),
        ),
      );
      expect(profileController.failure, null);

      //act
      await profileController.getMyProfile();

      //assert
      expect(profileController.statusHistory.length, 2);
      expect(profileController.statusHistory[0].isLoading, true);
      expect(profileController.statusHistory[1].isError, true);
    });
    test("should failure Not Null when fails to getMyProfile", () async {
      //arrange
      when(
        () => mockGetMyProfile.call(any()),
      ).thenAnswer(
        (_) async => left(
          InternalFailure(
            message: "",
            stackTrace: StackTrace.fromString("stackTraceString"),
          ),
        ),
      );

      //act
      await profileController.getMyProfile();

      //assert
      expect(profileController.failure, isNotNull);
    });
  });

  group("updateProfile -", () {
    test("should status be (loading, error) when fails", () async {
      //arrange
      when(
        () => mockUpdateMyProfile.call(any()),
      ).thenAnswer((_) async => left(FakeFailure()));

      //act
      await profileController.updateMyProfile(FakeUpdateMyProfileParams());

      //assert
      final statusHistory = profileController.statusHistory;
      expect(statusHistory.length, 2);
      expect(statusHistory[0].isLoading, true);
      expect(statusHistory[1].isError, true);
    });

    test("should failure not null when updateProfile is fails", () async {
      //arrange
      when(
        () => mockUpdateMyProfile.call(any()),
      ).thenAnswer((_) async => left(FakeFailure()));

      //act
      await profileController.updateMyProfile(FakeUpdateMyProfileParams());

      //assert
      expect(profileController.failure, isNotNull);
    });

    test("should state be (Null) when status is error", () async {
      //arrange
      when(
        () => mockUpdateMyProfile.call(any()),
      ).thenAnswer((_) async => left(FakeFailure()));

      //act
      await profileController.updateMyProfile(FakeUpdateMyProfileParams());

      //assert
      expect(profileController.state, isNull);
    });

    test("should status be (loading, success) when success to update",
        () async {
      //arrange
      when(
        () => mockUpdateMyProfile.call(any()),
      ).thenAnswer((_) async => right(FakeProfileEntity()));

      //act
      await profileController.updateMyProfile(FakeUpdateMyProfileParams());

      //assert
      final statusHistory = profileController.statusHistory;
      expect(statusHistory.length, 2);
      expect(statusHistory[0].isLoading, true);
      expect(statusHistory[1].isSuccess, true);
    });

    test("should state be the updated (ProfileEntity) when success", () async {
      //arrange
      when(
        () => mockUpdateMyProfile.call(any()),
      ).thenAnswer((_) async => right(FakeProfileEntity()));

      //act
      await profileController.updateMyProfile(FakeUpdateMyProfileParams());

      //assert
      expect(profileController.state, isNotNull);
    });
  });

  group("global functionalities -", () {
    group("onInit -", () {
      test("should call _getMyProfile when controller initialized", () {
        //assert
        verify(() => mockGetMyProfile.call(any())).called(1);
      });
    });

    group("failure -", () {
      test("should failure be Null when status is success", () async {
        //arrange
        when(
          () => mockUpdateMyProfile.call(any()),
        ).thenAnswer((_) async => left(FakeFailure()));
        await profileController.updateMyProfile(FakeUpdateMyProfileParams());
        expect(profileController.failure, isNotNull);

        //act
        when(
          () => mockUpdateMyProfile.call(any()),
        ).thenAnswer((_) async => right(FakeProfileEntity()));

        await profileController.updateMyProfile(FakeUpdateMyProfileParams());

        //assert
        expect(profileController.failure, isNull);
      });

      test("should failure Not Null when status is error", () async {
        //arrange
        when(
          () => mockUpdateMyProfile.call(any()),
        ).thenAnswer((_) async => left(FakeFailure()));

        //act
        await profileController.updateMyProfile(FakeUpdateMyProfileParams());

        //assert
        expect(profileController.failure, isNotNull);
      });
    });

    group("onChange -", () {
      group("statusHistory -", () {
        test("should add status to statusHistory when change function invoked",
            () {
          //act
          profileController.statusHistory.clear();
          profileController.change(null, status: RxStatus.success());

          //assert
          final history = profileController.statusHistory;

          expect(history.length, 1);
          expect(history[0].isSuccess, true);
        });

        test("should clear all statusHistory when controller disposed", () {
          //act
          profileController.dispose();

          //assert
          expect(profileController.statusHistory, isEmpty);
        });
      });

      test("should set currentStatus when change invoked", () {
        //act
        profileController.change(null, status: RxStatus.loadingMore());

        //assert
        expect(profileController.currentStatus.isLoadingMore, true);
      });

      test("should set the state to (profileData) variable when on change", () {
        //arrange
        profileController.change(
          null,
          status: RxStatus.success(),
        );
        expect(profileController.profileData, isNull);

        //act
        profileController.change(
          FakeProfileEntity(),
          status: RxStatus.success(),
        );

        //assert
        expect(profileController.profileData, isNotNull);
        expect(profileController.profileData?.name, FakeProfileEntity().name);
      });
    });
  });
}
