import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/site_settings/presentation/screens/site_settings_screen.dart';
import 'package:wordpress_companion/features/site_settings/site_settings_exports.dart';

class MockSiteSettingsCubit extends MockCubit<SiteSettingsState>
    implements SiteSettingsCubit {}

class FakeSiteSettingsEntity extends Fake implements SiteSettingsEntity {
  @override
  String get title => "test";

  @override
  String get description => "test";

  @override
  int get siteIcon => 2;

  @override
  String get url => "test";

  @override
  String get email => "test@gmail.com";

  @override
  String get timeZone => "lhk:g";

  @override
  String get timeFormat => "H:i A";

  @override
  String get dateFormat => "h/lf/y";

  @override
  int get startOfWeek => 1;
}

void main() {
  late SiteSettingsCubit settingsCubit;

  final testWidgetTree = ScreenUtilInit(
    child: MaterialApp(
      home: BlocProvider(
        create: (context) => settingsCubit,
        child: const SiteSettingsScreen(),
      ),
    ),
  );

  setUp(() {
    settingsCubit = MockSiteSettingsCubit();

    when(
      () => settingsCubit.state,
    ).thenAnswer((_) => const SiteSettingsState.initial());
  });

  group("siteSettingsCubitBuilder -", () {
    testWidgets("should render LoadingWidget when state is Loading",
        (tester) async {
      //arrange
      whenListen(
        settingsCubit,
        Stream.fromIterable([
          const SiteSettingsState.loading(),
        ]),
      );
      await tester.pumpWidget(testWidgetTree);
      await tester.pump();

      //assert
      expect(find.byType(Form), findsNothing);
      expect(find.byType(LoadingWidget), findsOneWidget);
    });

    testWidgets("should render LoadingWidget when state is Updating",
        (tester) async {
      //arrange
      whenListen(
        settingsCubit,
        Stream.fromIterable([
          const SiteSettingsState.updating(),
        ]),
      );
      await tester.pumpWidget(testWidgetTree);
      await tester.pump();

      //assert
      expect(find.byType(Form), findsNothing);
      expect(find.byType(LoadingWidget), findsOneWidget);
    });

    testWidgets("should render the body when state is Not Loading and updating",
        (tester) async {
      //arrange
      whenListen(
        settingsCubit,
        Stream.fromIterable(
          [SiteSettingsState.loaded(FakeSiteSettingsEntity())],
        ),
      );
      await tester.pumpWidget(testWidgetTree);
      await tester.pump();

      //assert
      expect(find.byType(Form), findsOneWidget);
    });
  });

  group("siteSettingsStateListener -", () {
    testWidgets(
        "should add the site settings data into fields when state is loaded ",
        (tester) async {
      //arrange
      whenListen(
        settingsCubit,
        Stream.fromIterable(
          [SiteSettingsState.loaded(FakeSiteSettingsEntity())],
        ),
      );
      await tester.pumpWidget(testWidgetTree);
      await tester.pump();

      //assert
      final allInputs = tester.widgetList<TextFormField>(
        find.descendant(
          of: find.byType(Form),
          matching: find.byType(TextFormField),
        ),
      );
      for (var input in allInputs) {
        expect(input.initialValue, isNotEmpty);
      }
    });

    testWidgets(
        "should add the site settings data into fields when state is updated",
        (tester) async {
      //arrange
      whenListen(
        settingsCubit,
        Stream.fromIterable([
          SiteSettingsState.updated(FakeSiteSettingsEntity()),
        ]),
      );
      await tester.pumpWidget(testWidgetTree);
      await tester.pump();

      //act
      final allInputs = tester.widgetList<TextFormField>(
        find.descendant(
          of: find.byType(Form),
          matching: find.byType(TextFormField),
        ),
      );

      //assert
      for (var input in allInputs) {
        expect(input.initialValue, isNotEmpty);
      }
    });

    testWidgets("should show a bottomSheet when state is error",
        (tester) async {
      //arrange
      whenListen(
        settingsCubit,
        Stream.fromIterable([
          SiteSettingsState.error(
            InternalFailure(
              message: "message",
              stackTrace: StackTrace.fromString("hello"),
            ),
          ),
        ]),
      );
      await tester.pumpWidget(testWidgetTree);
      await tester.pump();

      //assert
      expect(find.byType(FailureWidget), findsOneWidget);
    });
  });
  group("on save -", () {
    group("email input -", () {
      testWidgets("should email request focus when the value of it is invalid",
          (tester) async {
        //arrange
        await tester.pumpWidget(testWidgetTree);

        //act
        await tester.enterText(find.byKey(const Key("email_input")), "test");
        final emailInputAfterTextEntered = tester.widget<CustomFormInputField>(
          find.byKey(const Key("email_input")),
        );
        emailInputAfterTextEntered.focusNode?.unfocus();
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key("save_site_settings_button")));
        await tester.pumpAndSettle();
        final emailInput = tester.widget<CustomFormInputField>(
          find.byKey(const Key("email_input")),
        );

        //assert
        expect(emailInput.focusNode?.hasFocus, true);
      });

      testWidgets(
          "should Not focus pn email input when when its value is valid",
          (tester) async {
        //arrange
        await tester.pumpWidget(testWidgetTree);

        //act
        await tester.enterText(
            find.byKey(const Key("email_input")), "test@gmail.com");
        final emailInputAfterTextEntered = tester.widget<CustomFormInputField>(
          find.byKey(const Key("email_input")),
        );
        emailInputAfterTextEntered.focusNode?.unfocus();
        await tester.pumpAndSettle();

        expect(emailInputAfterTextEntered.focusNode?.hasFocus, false);

        await tester.tap(find.byKey(const Key("save_site_settings_button")));
        await tester.pumpAndSettle();

        //assert
        final emailInputAfterSave = tester.widget<CustomFormInputField>(
          find.byKey(const Key("email_input")),
        );
        expect(emailInputAfterSave.focusNode?.hasFocus, false);
      });
    });
  });
}
