import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/profile/profile_exports.dart';

import '../../../../dummy_stuff.dart';

class MockGetMyProfile extends Mock implements GetMyProfile {}

class MockUpdateMyProfile extends Mock implements UpdateMyProfile {}

class FakeUpdateMyProfileParams extends Fake implements UpdateMyProfileParams {}

void main() {
  late ProfileController profileController;
  late MockGetMyProfile mockGetMyProfile;
  late MockUpdateMyProfile mockUpdateMyProfile;
  final dummyProfileEntity = DummyObjects.profileEntity();
  final dummyFailure = InternalFailure(
    message: "message",
    stackTrace: StackTrace.fromString("stackTraceString"),
  );

  setUpAll(() {
    registerFallbackValue(NoParams());
    registerFallbackValue(FakeUpdateMyProfileParams());
  });

  setUp(() {
    Get.testMode = true;
    mockGetMyProfile = MockGetMyProfile();
    mockUpdateMyProfile = MockUpdateMyProfile();

    profileController = ProfileController(
      getMyProfile: mockGetMyProfile,
      updateMyProfile: mockUpdateMyProfile,
    );
    when(
      () => mockGetMyProfile.call(any()),
    ).thenAnswer((_) async => right(dummyProfileEntity));
  });

  tearDown(() {
    Get.delete();
    Get.reset();
  });

  group("status changes -", () {
    testWidgets("should show (LoadingWidget) when status is loading",
        (tester) async {
      //arrange
      Get.put(profileController);
      await tester.pumpWidget(_testWidget());
      await tester.pumpAndSettle();

      // verification
      expect(find.byType(LoadingWidget), findsNothing);

      //act
      profileController.change(null, status: RxStatus.loading());
      await tester.pump();

      //assert
      expect(find.byType(LoadingWidget), findsOneWidget);
    });

    group("error -", () {
      testWidgets(
          "should show (FailureWidget) when the status is error at the beginning",
          (tester) async {
        //arrange
        when(
          () => mockGetMyProfile.call(any()),
        ).thenAnswer((_) async => left(dummyFailure));

        Get.put(profileController);
        await tester.pumpWidget(_testWidget());
        await tester.pumpAndSettle();

        //act

        //assert
        expect(profileController.status.isError, true);
        expect(find.byType(FailureWidget), findsOneWidget);
      });

      testWidgets(
          "should show (FailureWidget) when profileController status changes to error",
          (tester) async {
        //arrange
        Get.put<ProfileController>(profileController);

        await tester.pumpWidget(_testWidget());
        await tester.pumpAndSettle();

        //verification
        expect(find.byType(ProfileScreen), findsOneWidget);
        expect(find.byType(FailureWidget), findsNothing);

        //act
        profileController.change(null, status: RxStatus.error());
        await tester.pumpAndSettle();

        //assert
        expect(profileController.status.isError, true);
        expect(find.byType(FailureWidget), findsOneWidget);
      });

      testWidgets(
          "should show only one BottomSheet containing (FailureWidget) when multiple error status change happens",
          (tester) async {
        //arrange
        Get.put(profileController);

        await tester.pumpWidget(_testWidget());
        await tester.pumpAndSettle();

        //verification
        expect(find.byType(FailureWidget), findsNothing);

        //act
        profileController.change(null, status: RxStatus.error());
        await tester.pumpAndSettle();

        profileController.change(null, status: RxStatus.error());
        await tester.pumpAndSettle();

        //assert
        expect(find.byType(FailureWidget), findsExactly(1));
      });
    });
  });

  group("onSubmit -", () {
    testWidgets("should NOT call updateMyProfile when form is InValid",
        (tester) async {
      //arrange
      Get.put(profileController);
      await tester.pumpWidget(_testWidget());
      await tester.pumpAndSettle();

      //verification
      final submitFinder = find.byKey(const Key("submit_button"));
      final emailInputFinder = find.byKey(const Key("email_input"));

      expect(submitFinder, findsOneWidget);
      expect(emailInputFinder, findsOneWidget);

      //act
      await tester.enterText(emailInputFinder, "invalid email");

      await tester.tap(submitFinder);
      await tester.pumpAndSettle();

      //assert
      verifyNever(() => mockUpdateMyProfile.call(any()));
    });

    testWidgets("should Call UpdateMyProfile when form is valid",
        (tester) async {
      //arrange
      when(
        () => mockUpdateMyProfile.call(any()),
      ).thenAnswer((_) async => right(dummyProfileEntity));
      Get.put(profileController);
      await tester.pumpWidget(_testWidget());
      await tester.pumpAndSettle();

      //verification
      final submitFinder = find.byKey(const Key("submit_button"));
      expect(submitFinder, findsOneWidget);

      //act
      await tester.tap(submitFinder);
      await tester.pumpAndSettle();

      //assert
      verify(() => mockUpdateMyProfile.call(any())).called(1);
    });
  });

  group("updateParamsBuilder -", () {
    testWidgets(
        "should set the state to (UpdateParamsBuilder) when state changes",
        (tester) async {
      //arrange
      Get.put(profileController);

      final fakeState = DummyObjects.profileEntity(name: "test name");
      when(
        () => mockGetMyProfile.call(any()),
      ).thenAnswer((_) async => right(fakeState));

      await tester.pumpWidget(_testWidget());
      await tester.pumpAndSettle();

      //verification
      expect(find.byType(ProfileScreen), findsOneWidget);

      //act
      profileController.getMyProfile();
      await tester.pumpAndSettle();

      //assert
      final profileScreen =
          tester.widget<ProfileScreen>(find.byType(ProfileScreen));
      final params = profileScreen.paramsBuilder.build();

      expect(params.name, "test name");
    });

    testWidgets(
        "should set the UpdateParamsBuilder props when inputFields changed",
        (tester) async {
      //arrange
      Get.put(profileController);
      await tester.pumpWidget(_testWidget());
      await tester.pumpAndSettle();

      //verification
      expect(find.byType(CustomFormInputField), findsWidgets);
      final inputsFinder = find.byType(CustomFormInputField);

      //act
      for (int i = 0; i < inputsFinder.evaluate().length; i++) {
        await tester.enterText(inputsFinder.at(i), "test");
      }

      //assert
      final builderParams = tester
          .widget<ProfileScreen>(find.byType(ProfileScreen))
          .paramsBuilder
          .build();

      expect(builderParams.name, "test");
      expect(builderParams.firstName, "test");
      expect(builderParams.lastName, "test");
      expect(builderParams.email, "test");
      expect(builderParams.slug, "test");
      expect(builderParams.nickName, "test");
      expect(builderParams.url, "test");
      expect(builderParams.description, "test");
    });
  });
}

ScreenUtilInit _testWidget() {
  return ScreenUtilInit(
    child: GetMaterialApp(home: ProfileScreen()),
  );
}
