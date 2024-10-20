import 'package:wordpress_companion/features/profile/domain/use_cases/update_my_profile.dart';

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
}
