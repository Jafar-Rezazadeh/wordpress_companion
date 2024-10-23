import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/features/site_settings/site_settings_exports.dart';

class FakeSiteSettingsEntity extends Fake implements SiteSettingsEntity {
  @override
  String get title => "entityTest";

  @override
  String get description => "entityTest";

  @override
  int get siteIcon => 20;

  @override
  String get url => "entityTest";

  @override
  String get email => "test@gmail.com";

  @override
  String get timeZone => "Asia/Tehran";

  @override
  String get dateFormat => "d/m/Y";

  @override
  String get timeFormat => "H:i";

  @override
  int get startOfWeek => 1;
}

void main() {
  group("fromExistingObject -", () {
    test(
        "should set the fields from existing object (SiteSettingEntity) when fromExistingObject is called",
        () {
      //arrange
      final settings = FakeSiteSettingsEntity();
      final builder = UpdateSiteSettingsParamsBuilder();

      //act
      builder.fromExistingObject(settings);
      final params = builder.build();

      //assert
      expect(params, isA<UpdateSiteSettingsParams>());
      expect(params.title, settings.title);
      expect(params.description, settings.description);
      expect(params.siteIcon, settings.siteIcon);
      expect(params.url, settings.url);
      expect(params.email, settings.email);
      expect(params.timeZone, settings.timeZone);
      expect(params.dateFormat, settings.dateFormat);
      expect(params.timeFormat, settings.timeFormat);
      expect(params.startOfWeek, settings.startOfWeek);
    });
  });

  group("build", () {
    test("should throw a (AssertionError) when email or timeZone is empty", () {
      //arrange
      final emailCaseBuilder = UpdateSiteSettingsParamsBuilder();
      final timeZoneCaseBuilder = UpdateSiteSettingsParamsBuilder();

      //act
      emailCaseBuilder.setEmail("");
      emailCaseBuilder.setTimeZone("test");

      timeZoneCaseBuilder.setEmail("test");
      timeZoneCaseBuilder.setTimeZone("");

      //assert
      expect(() => emailCaseBuilder.build(), throwsAssertionError);
      expect(() => timeZoneCaseBuilder.build(), throwsAssertionError);
    });
  });

  group("setters -", () {
    test(
        "should set the given value and build a UpdateSiteSettingsParams with correct values",
        () {
      //arrange
      final builder = UpdateSiteSettingsParamsBuilder();

      //act
      builder
        ..setTitle("test")
        ..setDescription("test")
        ..setIcon(2)
        ..setUrl("test")
        ..setEmail("test")
        ..setTimeZone("test")
        ..setDateFormat("test")
        ..setTimeFormat("test")
        ..setStartOfWeek(2);
      final params = builder.build();

      //assert
      expect(params, isA<UpdateSiteSettingsParams>());
      expect(params.title, "test");
      expect(params.description, "test");
      expect(params.siteIcon, 2);
      expect(params.url, "test");
      expect(params.email, "test");
      expect(params.timeZone, "test");
      expect(params.dateFormat, "test");
      expect(params.timeFormat, "test");
      expect(params.startOfWeek, 2);
    });

    test(
        "should overwrite the existing values and build a UpdateSiteSettingsParams with given values ",
        () {
      //arrange
      final builder = UpdateSiteSettingsParamsBuilder();
      builder.fromExistingObject(FakeSiteSettingsEntity());

      //act
      builder
        ..setTitle("test")
        ..setDescription("test")
        ..setIcon(2)
        ..setUrl("test")
        ..setEmail("test")
        ..setTimeZone("test")
        ..setDateFormat("test")
        ..setTimeFormat("test")
        ..setStartOfWeek(2);
      final params = builder.build();

      //assert
      expect(params, isA<UpdateSiteSettingsParams>());
      expect(params.title, "test");
      expect(params.description, "test");
      expect(params.siteIcon, 2);
      expect(params.url, "test");
      expect(params.email, "test");
      expect(params.timeZone, "test");
      expect(params.dateFormat, "test");
      expect(params.timeFormat, "test");
      expect(params.startOfWeek, 2);
    });
  });
}
