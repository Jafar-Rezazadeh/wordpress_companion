import '../../profile_exports.dart';

class UpdateMyProfileParamsBuilder {
  String _name = "";
  String _firstName = "";
  String _lastName = "";
  String _email = "";
  String _url = "";
  String _description = "";
  String _nickName = "";
  String _slug = "";

  setFromInitialData(ProfileEntity? profile) {
    if (profile != null) {
      _name = profile.name;
      _firstName = profile.firstName;
      _lastName = profile.lastName;
      _email = profile.email;
      _url = profile.url;
      _description = profile.description;
      _nickName = profile.nickName;
      _slug = profile.slug;
    }

    return this;
  }

  setName(String name) {
    _name = name;
    return this;
  }

  setFirstName(String firstName) {
    _firstName = firstName;
    return this;
  }

  setLastName(String lastName) {
    _lastName = lastName;
    return this;
  }

  setEmail(String email) {
    _email = email;
    return this;
  }

  setUrl(String url) {
    _url = url;
    return this;
  }

  setDescription(String description) {
    _description = description;
    return this;
  }

  setNickname(String nickName) {
    _nickName = nickName;
    return this;
  }

  setSlug(String slug) {
    _slug = slug;
    return this;
  }

  UpdateMyProfileParams build() {
    if (_email.isEmpty) {
      throw AssertionError("Email is required and can't be empty");
    }

    return UpdateMyProfileParams(
      name: _name,
      firstName: _firstName,
      lastName: _lastName,
      email: _email,
      url: _url,
      description: _description,
      nickName: _nickName,
      slug: _slug,
    );
  }
}
