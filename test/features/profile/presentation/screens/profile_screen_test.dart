import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/constants/enums.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/profile/presentation/screens/profile_screen.dart';
import 'package:wordpress_companion/features/profile/profile_exports.dart';

class MockProfileCubit extends MockCubit<ProfileState>
    implements ProfileCubit {}

class FakeProfileEntity extends Fake implements ProfileEntity {}

class FakeUpdateMyProfileParams extends Fake implements UpdateMyProfileParams {}

void main() {
  late ProfileCubit profileCubit;
  late Widget simulatedTree;

  final dummyProfileEntity = ProfileEntity(
    id: 0,
    userName: "username",
    name: "name",
    firstName: "firstName",
    lastName: "lastName",
    email: "test@gmail.com",
    url: "url",
    description: "description",
    link: "link",
    locale: "locale",
    nickName: "nickName",
    slug: "slug",
    registeredDate: DateTime(1),
    avatarUrls: const ProfileAvatarUrlsEntity(
      size24px: "",
      size48px: "",
      size96px: "",
    ),
    roles: const [UserRole.administrator],
  );

  setUpAll(() {
    registerFallbackValue(FakeUpdateMyProfileParams());
  });

  setUp(() {
    profileCubit = MockProfileCubit();
    when(
      () => profileCubit.state,
    ).thenAnswer((_) => const ProfileState.initial());

    simulatedTree = ScreenUtilInit(
      child: MaterialApp(
        home: BlocProvider(
          create: (_) => profileCubit,
          child: const ProfileScreen(),
        ),
      ),
    );
  });

  group("profileCubit -", () {
    group("builder -", () {
      testWidgets("should Not build anything when profileState is initial",
          (tester) async {
        //arrange
        whenListen(
          profileCubit,
          Stream.fromIterable([
            const ProfileState.initial(),
          ]),
        );

        //act
        await tester.pumpWidget(simulatedTree);
        await tester.pump();

        //assert
        expect(find.byType(LoadingWidget), findsNothing);
        expect(find.byKey(const Key("contents_key")), findsNothing);
        expect(find.byType(FailureWidget), findsNothing);
      });

      testWidgets("should build loadingWidget when ProfileState is loading",
          (tester) async {
        //arrange
        whenListen(
          profileCubit,
          Stream.fromIterable([
            const ProfileState.loading(),
          ]),
        );

        //act
        await tester.pumpWidget(simulatedTree);
        await tester.pump();

        //assert
        expect(find.byType(LoadingWidget), findsOneWidget);
        expect(find.byKey(const Key("contents_key")), findsNothing);
        expect(find.byType(FailureWidget), findsNothing);
      });

      testWidgets("should build the content when profileState is loaded",
          (tester) async {
        //arrange
        whenListen(
          profileCubit,
          Stream.fromIterable([
            ProfileState.loaded(dummyProfileEntity),
          ]),
        );

        //act
        await tester.pumpWidget(simulatedTree);
        await tester.pumpAndSettle();

        //assert
        expect(find.byKey(const Key("contents_key")), findsOneWidget);
        expect(find.byType(LoadingWidget), findsNothing);
        expect(find.byType(FailureWidget), findsNothing);
      });

      testWidgets("should build FailureWidget when ProfileState is error",
          (tester) async {
        //arrange
        whenListen(
          profileCubit,
          Stream.fromIterable(
            [
              ProfileState.error(
                InternalFailure(
                  message: "message",
                  stackTrace: StackTrace.fromString("stackTraceString"),
                ),
              )
            ],
          ),
        );

        //act
        await tester.pumpWidget(simulatedTree);
        await tester.pump();

        //assert
        expect(find.byType(FailureWidget), findsOneWidget);
        expect(find.byKey(const Key("contents_key")), findsNothing);
        expect(find.byType(LoadingWidget), findsNothing);
      });
    });

    group("listener -", () {
      testWidgets(
          "should insert the profile data to inputs when profile state is loaded",
          (tester) async {
        //arrange
        whenListen(
          profileCubit,
          Stream.fromIterable([ProfileState.loaded(dummyProfileEntity)]),
        );

        //act
        await tester.pumpWidget(simulatedTree);
        await tester.pumpAndSettle();

        //assert
        expect(find.text(dummyProfileEntity.userName), findsOneWidget);
        expect(find.text(dummyProfileEntity.name), findsOneWidget);
        expect(find.text(dummyProfileEntity.firstName), findsOneWidget);
        expect(find.text(dummyProfileEntity.lastName), findsOneWidget);
        expect(find.text(dummyProfileEntity.email), findsOneWidget);
        expect(find.text(dummyProfileEntity.slug), findsOneWidget);
        expect(find.text(dummyProfileEntity.nickName), findsOneWidget);
        expect(find.text(dummyProfileEntity.url), findsOneWidget);
        expect(find.text(dummyProfileEntity.description), findsOneWidget);
      });
    });
  });

  group("user interactions -", () {
    group("inputs -", () {
      group("email input -", () {
        testWidgets(
            "should email input be Not Valid if value is empty or invalid email",
            (tester) async {
          //arrange
          whenListen(
            profileCubit,
            Stream.fromIterable([ProfileState.loaded(dummyProfileEntity)]),
          );
          await tester.pumpWidget(simulatedTree);
          await tester.pumpAndSettle();

          //verification
          expect(find.text(dummyProfileEntity.email), findsOneWidget);

          //act
          final emailInput = tester.widget<TextFormField>(
            find.descendant(
                of: find.byKey(const Key("email_input")),
                matching: find.byType(TextFormField)),
          );

          //assert
          expect(emailInput.validator!("test"), isA<String>());
          expect(emailInput.validator!(""), isA<String>());
        });
        testWidgets(
            "should email input has been focused if value is invalid when submit button is tapped",
            (tester) async {
          //arrange

          whenListen(
            profileCubit,
            Stream.fromIterable([ProfileState.loaded(dummyProfileEntity)]),
          );
          await tester.pumpWidget(simulatedTree);
          await tester.pumpAndSettle();

          //verification
          expect(find.text(dummyProfileEntity.email), findsOneWidget);

          //act
          final emailInput = tester.widget<CustomFormInputField>(
            find.byKey(const Key("email_input")),
          );
          await tester.enterText(find.byKey(const Key("email_input")), "test");
          emailInput.focusNode?.unfocus();
          await tester.pump();
          expect(emailInput.focusNode?.hasFocus, false);

          await tester.tap(find.byKey(const Key("submit_button")));
          await tester.pumpAndSettle();

          //assert
          expect(emailInput.focusNode?.hasFocus, true);
        });

        testWidgets("should email input be Valid if value is a valid email",
            (tester) async {
          //arrange
          whenListen(
            profileCubit,
            Stream.fromIterable([ProfileState.loaded(dummyProfileEntity)]),
          );
          await tester.pumpWidget(simulatedTree);
          await tester.pumpAndSettle();

          //verification
          expect(find.text(dummyProfileEntity.email), findsOneWidget);

          //act
          final emailInput = tester.widget<TextFormField>(
            find.descendant(
                of: find.byKey(const Key("email_input")),
                matching: find.byType(TextFormField)),
          );

          //assert
          expect(emailInput.validator!("test@gmail.com"), isNull);
        });
      });
    });
    group("submit -", () {
      testWidgets("should call the updateProfile of cubit when form is valid",
          (tester) async {
        //arrange
        whenListen(
          profileCubit,
          Stream.fromIterable([ProfileState.loaded(dummyProfileEntity)]),
        );

        await tester.pumpWidget(simulatedTree);
        await tester.pumpAndSettle();

        //verification
        expect(find.byKey(const Key("submit_button")), findsOneWidget);

        //act
        await tester.tap(find.byKey(const Key("submit_button")));
        await tester.pumpAndSettle();

        //assert
        verify(() => profileCubit.updateProfile(any()));
      });

      testWidgets(
          "should Not call the updateProfile of cubit when form is invalid",
          (tester) async {
        //arrange
        whenListen(
          profileCubit,
          Stream.fromIterable([ProfileState.loaded(dummyProfileEntity)]),
        );

        await tester.pumpWidget(simulatedTree);
        await tester.pumpAndSettle();

        //verification
        expect(find.byKey(const Key("submit_button")), findsOneWidget);

        //act
        await tester.enterText(find.byKey(const Key("email_input")), "test");
        await tester.tap(find.byKey(const Key("submit_button")));
        await tester.pumpAndSettle();

        //assert
        verifyNever(() => profileCubit.updateProfile(any()));
      });
    });
  });
}
