import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/profile/presentation/screens/profile_screen.dart';
import 'package:wordpress_companion/features/profile/profile_exports.dart';

class MockProfileCubit extends MockCubit<ProfileState>
    implements ProfileCubit {}

class FakeProfileEntity extends Fake implements ProfileEntity {}

void main() {
  late ProfileCubit profileCubit;
  late Widget simulatedTree;

  final dummyProfileEntity = ProfileEntity(
    id: 0,
    userName: "username",
    name: "name",
    firstName: "firstName",
    lastName: "lastName",
    email: "email",
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
  );

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
    group("save -", () {
      // TODO:
    });
  });
}
