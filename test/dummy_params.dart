import 'package:wordpress_companion/features/profile/domain/use_cases/update_my_profile.dart';
import 'package:wordpress_companion/features/site_settings/domain/use_cases/update_site_settings.dart';

class DummyParams {
  static UpdateMyProfileParams updateMyProfileParams =
      const UpdateMyProfileParams(
    name: "displayName",
    firstName: "firstName",
    lastName: "lastName",
    email: "email",
    url: "url",
    description: "description",
    nickName: "nickName",
    slug: "slug",
  );

  static UpdateSiteSettingsParams updateSiteSettingsParams =
      const UpdateSiteSettingsParams(
    title: "title",
    description: "description",
    siteIcon: 0,
    url: "url",
    email: "email",
    timeZone: "timeZone",
    dateFormat: "dateFormat",
    timeFormat: "timeFormat",
    startOfWeek: 1,
  );
}