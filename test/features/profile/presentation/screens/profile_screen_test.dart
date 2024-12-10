import 'package:dartz/dartz.dart';
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

void main() {
  late ProfileController profileController;
  late MockGetMyProfile mockGetMyProfile;
  final dummyProfileEntity = DummyObjects.profileEntity();
  final dummyFailure = InternalFailure(
    message: "message",
    stackTrace: StackTrace.fromString("stackTraceString"),
  );

  setUpAll(() {
    registerFallbackValue(NoParams());
  });

  setUp(() {
    Get.testMode = true;
    mockGetMyProfile = MockGetMyProfile();
    profileController = ProfileController(
      getMyProfile: mockGetMyProfile,
      updateMyProfile: MockUpdateMyProfile(),
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
  });

  group("onSubmit -", () {});
}

ScreenUtilInit _testWidget() {
  return ScreenUtilInit(
    child: GetMaterialApp(home: ProfileScreen()),
  );
}
