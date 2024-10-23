import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/core/widgets/time_zone_selector.dart';
import 'package:wordpress_companion/features/site_settings/presentation/screens/site_settings_screen.dart';
import 'package:wordpress_companion/features/site_settings/presentation/widgets/start_of_week_input.dart';
import 'package:wordpress_companion/features/site_settings/site_settings_exports.dart';

class MockSiteSettingsCubit extends MockCubit<SiteSettingsState>
    implements SiteSettingsCubit {}

class DummySiteSettingsEntity extends Fake implements SiteSettingsEntity {
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

class FakeUpdateSiteSettingsParams extends Fake
    implements UpdateSiteSettingsParams {}

void main() {
  late SiteSettingsCubit settingsCubit;
  late UpdateSiteSettingsParamsBuilder builder;
  late Widget testWidgetTree;

  setUpAll(() {
    registerFallbackValue(FakeUpdateSiteSettingsParams());
  });

  setUp(() {
    settingsCubit = MockSiteSettingsCubit();
    builder = UpdateSiteSettingsParamsBuilder();

    when(
      () => settingsCubit.state,
    ).thenAnswer((_) => const SiteSettingsState.initial());

    testWidgetTree = ScreenUtilInit(
      child: MaterialApp(
        home: BlocProvider(
          create: (context) => settingsCubit,
          child: SiteSettingsScreen(updateSiteSettingsParamsBuilder: builder),
        ),
      ),
    );
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
          [SiteSettingsState.loaded(DummySiteSettingsEntity())],
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
          [SiteSettingsState.loaded(DummySiteSettingsEntity())],
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
          SiteSettingsState.updated(DummySiteSettingsEntity()),
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

    testWidgets("should set the builder fields when state is loaded",
        (tester) async {
      //arrange
      final initialSettings = DummySiteSettingsEntity();

      whenListen(
        settingsCubit,
        Stream.fromIterable([
          SiteSettingsState.loaded(initialSettings),
        ]),
      );
      await tester.pumpWidget(testWidgetTree);

      //assert
      _expectBuilderFieldAreSetFromExistingData(builder, initialSettings);
    });
    testWidgets("should set the builder fields when state is updated",
        (tester) async {
      //arrange
      final initialSettings = DummySiteSettingsEntity();
      whenListen(
        settingsCubit,
        Stream.fromIterable([
          SiteSettingsState.updated(initialSettings),
        ]),
      );
      await tester.pumpWidget(testWidgetTree);

      //assert
      _expectBuilderFieldAreSetFromExistingData(builder, initialSettings);
    });
  });
  group("user interaction -", () {
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

      testWidgets("should Not focus email input when when its value is valid",
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

    group("inputs -", () {
      testWidgets("should set the builder fields when inputs value are changed",
          (tester) async {
        //arrange
        await tester.pumpWidget(testWidgetTree);
        await tester.pump();

        //act
        final textInputsFinder = find.byType(CustomFormInputField);
        final textFieldsLength = tester.widgetList(textInputsFinder).length;

        for (var i = 0; i < textFieldsLength; i++) {
          await tester.enterText(textInputsFinder.at(i), "test");
        }
        await tester.pump();

        tester
            .widget<SiteIconInput>(
              find.byType(SiteIconInput),
            )
            .onSelect(1);
        tester
            .widget<TimezoneDropdown>(
              find.byType(TimezoneDropdown),
            )
            .onTimezoneSelected("Asia/tokyo");

        await tester.scrollUntilVisible(
          find.byType(DateFormatInput),
          500,
          scrollable: find.byType(Scrollable).first,
        );
        tester
            .widget<DateFormatInput>(
              find.byType(DateFormatInput),
            )
            .onChanged("y/m/n");
        tester
            .widget<TimeFormatInput>(
              find.byType(TimeFormatInput),
            )
            .onChanged("h:m:s");

        tester
            .widget<StartOfWeekInput>(
              find.byType(StartOfWeekInput),
            )
            .onSelect(2);

        //assert
        final params = builder.build();
        expect(params.title, "test");
        expect(params.description, "test");
        expect(params.siteIcon, 1);
        expect(params.url, "test");
        expect(params.email, "test");
        expect(params.timeZone, "Asia/tokyo");
        expect(params.dateFormat, "y/m/n");
        expect(params.timeFormat, "h:m:s");
        expect(params.startOfWeek, 2);
      });
    });

    group("on save -", () {
      testWidgets(
          "should invoke the update method of siteSettingsCubit when form is valid",
          (tester) async {
        whenListen(
          settingsCubit,
          Stream.fromIterable([
            SiteSettingsState.loaded(DummySiteSettingsEntity()),
          ]),
        );
        await tester.pumpWidget(testWidgetTree);

        //act
        // for validation should be valid
        await tester.enterText(
            find.byKey(const Key("email_input")), "test@gmail.com");

        await tester.tap(find.byKey(const Key("save_site_settings_button")));

        //assert
        verify(() => settingsCubit.updateSettings(any())).called(1);
      });
      testWidgets(
          "should Not invoke the update method of siteSettingsCubit when form is Invalid",
          (tester) async {
        whenListen(
          settingsCubit,
          Stream.fromIterable([
            SiteSettingsState.loaded(DummySiteSettingsEntity()),
          ]),
        );
        await tester.pumpWidget(testWidgetTree);

        //act
        await tester.enterText(find.byKey(const Key("email_input")), "test");
        await tester.tap(find.byKey(const Key("save_site_settings_button")));

        //assert
        verifyNever(() => settingsCubit.updateSettings(any()));
      });
    });
  });
}

void _expectBuilderFieldAreSetFromExistingData(
  UpdateSiteSettingsParamsBuilder builder,
  SiteSettingsEntity setting,
) {
  final params = builder.build();
  expect(params.title, setting.title);
  expect(params.description, setting.description);
  expect(params.email, setting.email);
  expect(params.siteIcon, setting.siteIcon);
  expect(params.url, setting.url);
  expect(params.timeZone, setting.timeZone);
  expect(params.dateFormat, setting.dateFormat);
  expect(params.timeFormat, setting.timeFormat);
  expect(params.startOfWeek, setting.startOfWeek);
}
