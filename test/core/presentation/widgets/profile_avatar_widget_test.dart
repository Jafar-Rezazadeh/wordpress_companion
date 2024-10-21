import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/core/presentation/cubits/global_profile_cubit/global_profile_cubit.dart';
import 'package:wordpress_companion/core/presentation/widgets/profile_avatar_widget.dart';
import 'package:wordpress_companion/features/profile/domain/entities/profile_avatar_urls.dart';
import 'package:wordpress_companion/features/profile/domain/entities/profile_entity.dart';

class MockGlobalProfileCubit extends MockCubit<GlobalProfileState>
    implements GlobalProfileCubit {}

class FakeProfileEntity extends Fake implements ProfileEntity {
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
    _setCubitInitialState(globalProfileCubit);
  });

  group("avatarBuilder -", () {
    testWidgets("should render (container) when state is initial",
        (tester) async {
      //arrange
      whenListen(
        globalProfileCubit,
        Stream.fromIterable([
          const GlobalProfileState.initial(),
        ]),
      );
      await tester.pumpWidget(_testWidgetTree(globalProfileCubit));

      //assert
      expect(find.byType(Container), findsOneWidget);
      expect(find.byKey(const Key("avatar_widget")), findsNothing);
      expect(find.byType(LoadingWidget), findsNothing);
      expect(find.byType(FailureWidget), findsNothing);
    });

    testWidgets("should render (LoadingWidget) when state is loading",
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
    });

    testWidgets("should render avatar_widget when state is Loaded",
        (tester) async {
      //arrange
      whenListen(
        globalProfileCubit,
        Stream.fromIterable([
          GlobalProfileState.loaded(FakeProfileEntity()),
        ]),
      );

      await tester.pumpWidget(_testWidgetTree(globalProfileCubit));
      await tester.pump();

      //assert
      expect(find.byKey(const Key("avatar_widget")), findsOneWidget);
    });

    testWidgets("should render error_avatar_widget when state is error",
        (tester) async {
      //arrange
      whenListen(
        globalProfileCubit,
        Stream.fromIterable([
          GlobalProfileState.error(
            InternalFailure(
              message: "message",
              stackTrace: StackTrace.fromString("stackTraceString"),
            ),
          ),
        ]),
      );

      await tester.pumpWidget(_testWidgetTree(globalProfileCubit));
      await tester.pump();

      //assert
      expect(find.byKey(const Key("error_avatar_widget")), findsOneWidget);
    });
  });
}

MaterialApp _testWidgetTree(GlobalProfileCubit globalProfileCubit) {
  return MaterialApp(
    home: Material(
      child: BlocProvider(
        create: (context) => globalProfileCubit,
        child: const ProfileAvatarWidget(),
      ),
    ),
  );
}

void _setCubitInitialState(GlobalProfileCubit globalProfileCubit) {
  when(
    () => globalProfileCubit.state,
  ).thenAnswer((_) => const GlobalProfileState.initial());
}
