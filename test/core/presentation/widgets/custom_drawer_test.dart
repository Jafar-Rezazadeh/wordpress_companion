import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/profile/profile_exports.dart';
import 'package:wordpress_companion/features/site_settings/site_settings_exports.dart';

class MockGlobalProfileCubit extends MockCubit<GlobalProfileState>
    implements GlobalProfileCubit {}

class MockSiteSettingsCubit extends MockCubit<SiteSettingsState>
    implements SiteSettingsCubit {}

class MockCustomUrlLauncher extends Mock implements CustomUrlLauncher {}

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
  late SiteSettingsCubit siteSettingsCubit;
  late MockCustomUrlLauncher mockCustomUrlLauncher;

  setUp(() {
    globalProfileCubit = MockGlobalProfileCubit();
    siteSettingsCubit = MockSiteSettingsCubit();
    mockCustomUrlLauncher = MockCustomUrlLauncher();
    when(
      () => globalProfileCubit.state,
    ).thenAnswer((_) => const GlobalProfileState.initial());
    when(
      () => siteSettingsCubit.state,
    ).thenAnswer((_) => const SiteSettingsState.initial());
  });

  Widget testWidgetTree = ScreenUtilInit(
    child: MaterialApp(
      home: BlocProvider(
        create: (context) => globalProfileCubit,
        child: Builder(builder: (context) {
          context.read<GlobalProfileCubit>().getMyProfile();
          return CustomDrawer(customUrlLauncher: mockCustomUrlLauncher);
        }),
      ),
    ),
  );

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

        await tester.pumpWidget(testWidgetTree);
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
        await tester.pumpWidget(testWidgetTree);
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
        await tester.pumpWidget(testWidgetTree);
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
        await tester.pumpWidget(testWidgetTree);
        await tester.pump();

        //assert
        expect(find.byType(FailureWidget), findsOneWidget);
        expect(find.byType(LoadingWidget), findsNothing);
        expect(find.byType(UserAccountsDrawerHeader), findsNothing);
      });
    });
  });

  group("user interaction -", () {
    group("navigationItems -", () {
      testWidgets(
          "should go to route (SiteSettingsScreen) when taped on site_settings_nav",
          (tester) async {
        //arrange
        await tester.pumpWidget(
          MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: "/",
              routes: [
                GoRoute(
                  path: "/",
                  builder: (context, state) => testWidgetTree,
                  routes: [
                    GoRoute(
                      name: siteSettingsScreenRoute,
                      path: siteSettingsScreenRoute,
                      builder: (context, state) => BlocProvider(
                        create: (context) => siteSettingsCubit,
                        child: const SiteSettingsScreen(),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();

        //verification
        expect(find.byKey(const Key("site_settings_nav")), findsOneWidget);

        //act
        await tester.tap(find.byKey(const Key("site_settings_nav")));
        await tester.pumpAndSettle();

        //assert
        expect(find.byType(SiteSettingsScreen), findsOneWidget);
      });
    });
    group("bottom menu -", () {
      testWidgets(
          "should launch the telegram url when tap on telegram the button",
          (tester) async {
        //arrange
        when(
          () => mockCustomUrlLauncher.openInBrowser(any()),
        ).thenAnswer((_) async => true);

        await tester.pumpWidget(testWidgetTree);

        //verification
        expect(find.byType(Drawer), findsOneWidget);

        //act
        await tester.tap(find.byKey(const Key("telegram_button")));
        await tester.pumpAndSettle();

        //assert
        verify(() =>
                mockCustomUrlLauncher.openInBrowser("https://t.me/jafar_rzzd"))
            .called(1);
      });

      testWidgets("should launch the github url when tap on the github button",
          (tester) async {
        //arrange
        when(
          () => mockCustomUrlLauncher.openInBrowser(any()),
        ).thenAnswer((_) async => true);
        await tester.pumpWidget(testWidgetTree);

        //verification
        expect(find.byKey(const Key("github_button")), findsOneWidget);

        //act
        await tester.tap(find.byKey(const Key("github_button")));
        await tester.pumpAndSettle();

        //assert
        verify(
          () => mockCustomUrlLauncher
              .openInBrowser("https://github.com/Jafar-Rezazadeh"),
        ).called(1);
      });

      testWidgets("should launch the gmail url when tap on the email button",
          (tester) async {
        //arrange
        when(
          () => mockCustomUrlLauncher.openInBrowser(any()),
        ).thenAnswer((_) async => true);
        await tester.pumpWidget(testWidgetTree);

        //verification
        expect(find.byKey(const Key("email_button")), findsOneWidget);

        //act
        await tester.tap(find.byKey(const Key("email_button")));
        await tester.pumpAndSettle();

        //assert
        verify(
          () => mockCustomUrlLauncher
              .openInBrowser("https://mailto:jafarrezazadeh76@gmail.com"),
        ).called(1);
      });
    });
  });
}
