import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/site_settings/site_settings_exports.dart';

class MockSiteSettingsCubit extends MockCubit<SiteSettingsState>
    implements SiteSettingsCubit {}

class DummySiteSettingsEntity extends Fake implements SiteSettingsEntity {
  @override
  String get title => "title";

  @override
  String get description => "description";

  @override
  int get siteIcon => 2;

  @override
  String get url => "url";

  @override
  String get email => "test@gmail.com";

  @override
  String get timeZone => "UTC";

  @override
  String get timeFormat => "H:i A";

  @override
  String get dateFormat => "d/m/y";

  @override
  int get startOfWeek => 1;
}

class FakeUpdateSiteSettingsParams extends Fake
    implements UpdateSiteSettingsParams {}

void main() {
  late SiteSettingsCubit settingsCubit;
  late Widget testWidgetTree;

  setUpAll(() {
    registerFallbackValue(FakeUpdateSiteSettingsParams());
  });

  setUp(() {
    settingsCubit = MockSiteSettingsCubit();

    when(
      () => settingsCubit.state,
    ).thenAnswer((_) => const SiteSettingsState.initial());

    testWidgetTree = ScreenUtilInit(
      child: MaterialApp(
        home: BlocProvider(
          create: (context) => settingsCubit,
          child: const SiteSettingsScreen(),
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
    testWidgets("should set settings data into fields when state is loaded ",
        (tester) async {
      //arrange
      final settings = DummySiteSettingsEntity();
      whenListen(
        settingsCubit,
        Stream.fromIterable(
          [SiteSettingsState.loaded(settings)],
        ),
        initialState: const SiteSettingsState.loading(),
      );
      await tester.pumpWidget(testWidgetTree);
      await tester.pump();

      //assert
      _expectSettingsIsSetToInputs(settings, tester);
    });

    testWidgets("should set settings data into fields when state is updated",
        (tester) async {
      //arrange
      final settings = DummySiteSettingsEntity();
      whenListen(
        settingsCubit,
        Stream.fromIterable([
          SiteSettingsState.updated(settings),
        ]),
        initialState: const SiteSettingsState.loading(),
      );
      await tester.pumpWidget(testWidgetTree);
      await tester.pump();

      //assert
      _expectSettingsIsSetToInputs(settings, tester);
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

      testWidgets(
          "should invoke the update method with expected params when inputs value are changed",
          (tester) async {
        //arrange
        final settings = DummySiteSettingsEntity();
        await tester.pumpWidget(testWidgetTree);
        await tester.pump();

        //act
        await _enterSettingsToInputs(tester, settings);

        await tester.tap(find.byKey(const Key("save_site_settings_button")));

        //assert
        verify(
          () => settingsCubit.updateSettings(
            any(
              that: isA<UpdateSiteSettingsParams>().having(
                (params) =>
                    params.title == "test" &&
                    params.description == "test" &&
                    params.siteIcon == settings.siteIcon &&
                    params.url == "test" &&
                    params.email == settings.email &&
                    params.timeZone == settings.timeZone &&
                    params.dateFormat == settings.dateFormat &&
                    params.timeFormat == settings.timeFormat &&
                    params.startOfWeek == settings.startOfWeek &&
                    params.siteIcon == settings.siteIcon,
                "is expected params",
                true,
              ),
            ),
          ),
        ).called(1);
      });
    });
  });
}

Future<void> _enterSettingsToInputs(
    WidgetTester tester, DummySiteSettingsEntity settings) async {
  final textInputsFinder = find.byType(CustomFormInputField);
  final textFieldsLength = tester.widgetList(textInputsFinder).length;

  for (var i = 0; i < textFieldsLength; i++) {
    if (tester.widget<CustomFormInputField>(textInputsFinder.at(i)).key ==
        const Key("email_input")) {
      await tester.enterText(textInputsFinder.at(i), settings.email);
    } else {
      await tester.enterText(textInputsFinder.at(i), "test");
    }
  }
  await tester.pumpAndSettle();

  tester
      .widget<SiteIconInput>(
        find.byType(SiteIconInput),
      )
      .onSelect(settings.siteIcon);
  tester
      .widget<TimezoneDropdown>(
        find.byType(TimezoneDropdown),
      )
      .onTimezoneSelected(settings.timeZone);

  await tester.scrollUntilVisible(
    find.byType(DateFormatInput),
    500,
    scrollable: find.byType(Scrollable).first,
  );
  tester
      .widget<DateFormatInput>(
        find.byType(DateFormatInput),
      )
      .onChanged(settings.dateFormat);
  tester
      .widget<TimeFormatInput>(
        find.byType(TimeFormatInput),
      )
      .onChanged(settings.timeFormat);

  tester
      .widget<StartOfWeekInput>(
        find.byType(StartOfWeekInput),
      )
      .onSelect(settings.startOfWeek);
}

Future<void> _expectSettingsIsSetToInputs(
    DummySiteSettingsEntity initialSettings, WidgetTester tester) async {
  expect(find.text(initialSettings.title), findsOneWidget);
  expect(find.text(initialSettings.description), findsOneWidget);
  expect(find.text(initialSettings.url), findsOneWidget);
  expect(find.text(initialSettings.email), findsOneWidget);
  expect(find.text(initialSettings.timeZone), findsOneWidget);
  await tester.scrollUntilVisible(
    find.text("دوشنبه"),
    500,
    scrollable: find.byType(Scrollable).first,
  );
  expect(find.text("دوشنبه"), findsOneWidget);
  expect(
    tester
        .widget<DateFormatInput>(find.byKey(const Key("date_format_input")))
        .initialValue,
    initialSettings.dateFormat,
  );
  expect(
    tester
        .widget<TimeFormatInput>(find.byKey(const Key("time_format_input")))
        .initialValue,
    initialSettings.timeFormat,
  );
}
