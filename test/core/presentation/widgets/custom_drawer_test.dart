import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/core/presentation/cubits/global_profile_cubit/global_profile_cubit.dart';
import 'package:wordpress_companion/core/presentation/widgets/custom_drawer.dart';
import 'package:wordpress_companion/features/profile/domain/entities/profile_avatar_urls.dart';
import 'package:wordpress_companion/features/profile/domain/entities/profile_entity.dart';

class MockGlobalProfileCubit extends MockCubit<GlobalProfileState>
    implements GlobalProfileCubit {}

class FakeProfileEntity extends Fake implements ProfileEntity {
  @override
  String get firstName => "firstName";

  @override
  String get lastName => "lastName";

  @override
  String get email => "email";

  @override
  ProfileAvatarUrlsEntity get avatarUrls => const ProfileAvatarUrlsEntity(
        size24px: "",
        size48px: "",
        size96px: "",
      );
}

void main() {
  late GlobalProfileCubit globalProfileCubit;

  setUp(() {
    globalProfileCubit = MockGlobalProfileCubit();
    when(
      () => globalProfileCubit.state,
    ).thenAnswer((_) => const GlobalProfileState.initial());
  });

  group("header -", () {
    group("globalProfileCubit -", () {
      testWidgets("should render empty (Container) when state is initial",
          (tester) async {
        //arrange
        whenListen(
          globalProfileCubit,
          Stream.fromIterable([
            const GlobalProfileState.initial(),
          ]),
        );

        await tester.pumpWidget(_testWidgetTree(globalProfileCubit));
        await tester.pump();

        //assert
        expect(find.byType(LoadingWidget), findsNothing);
        expect(find.byType(FailureWidget), findsNothing);
        expect(find.byType(UserAccountsDrawerHeader), findsNothing);
      });

      testWidgets("should render loadingWidget when state is loading",
          (tester) async {
        //arrange
        whenListen(
          globalProfileCubit,
          Stream.fromIterable([
            const GlobalProfileState.loading(),
          ]),
        );
        await tester.pumpWidget(_testWidgetTree(globalProfileCubit));
        await tester.pump();

        //assert
        expect(find.byType(LoadingWidget), findsOneWidget);
        expect(find.byType(FailureWidget), findsNothing);
        expect(find.byType(UserAccountsDrawerHeader), findsNothing);
      });

      testWidgets("should render userAccountsDrawerHeader when state is loaded",
          (tester) async {
        //arrange
        whenListen(
          globalProfileCubit,
          Stream.fromIterable([GlobalProfileState.loaded(FakeProfileEntity())]),
        );
        await tester.pumpWidget(_testWidgetTree(globalProfileCubit));
        await tester.pump();

        //assert
        expect(find.byType(UserAccountsDrawerHeader), findsOneWidget);
        expect(find.byType(LoadingWidget), findsNothing);
        expect(find.byType(FailureWidget), findsNothing);
      });

      testWidgets("should render failureWidget when state is error",
          (tester) async {
        //arrange
        whenListen(
          globalProfileCubit,
          Stream.fromIterable([
            GlobalProfileState.error(
              InternalFailure(
                  message: "message",
                  stackTrace: StackTrace.fromString("stackTraceString")),
            ),
          ]),
        );
        await tester.pumpWidget(_testWidgetTree(globalProfileCubit));
        await tester.pump();

        //assert
        expect(find.byType(FailureWidget), findsOneWidget);
        expect(find.byType(LoadingWidget), findsNothing);
        expect(find.byType(UserAccountsDrawerHeader), findsNothing);
      });
    });
  });

  group("user interaction -", () {
    group("bottom menu -", () {
      testWidgets("should launch the specified url when on tap",
          (tester) async {
        //arrange
// TODO:
        //verification

        //act

        //assert
      });
    });
  });
}

Widget _testWidgetTree(GlobalProfileCubit globalProfileCubit) {
  return ScreenUtilInit(
    child: MaterialApp(
      home: BlocProvider(
        create: (context) => globalProfileCubit,
        child: Builder(builder: (context) {
          context.read<GlobalProfileCubit>().getMyProfile();
          return const CustomDrawer();
        }),
      ),
    ),
  );
}
