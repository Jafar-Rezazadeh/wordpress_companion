import 'package:wordpress_companion/features/site_settings/site_settings_exports.dart';

class UpdateSiteSettingsParamsBuilder {
  String _title = "";
  String _description = "";
  int _siteIcon = 0;
  String _url = "";
  String _email = "";
  String _timeZone = "UTC+0";
  String _dateFormat = "";
  String _timeFormat = "";
  int _startOfWeek = 1;

  fromExistingObject(SiteSettingsEntity entity) {
    _title = entity.title;
    _description = entity.description;
    _siteIcon = entity.siteIcon;
    _url = entity.url;
    _email = entity.email;
    _timeZone = entity.timeZone.isNotEmpty ? entity.timeZone : _timeZone;
    _dateFormat = entity.dateFormat;
    _timeFormat = entity.timeFormat;
    _startOfWeek = entity.startOfWeek;
  }

  setTitle(String value) {
    _title = value;
    return this;
  }

  setDescription(String value) {
    _description = value;
    return this;
  }

  setIcon(int value) {
    _siteIcon = value;
    return this;
  }

  setUrl(String value) {
    _url = value;
    return this;
  }

  setEmail(String value) {
    _email = value;
    return this;
  }

  setTimeZone(String value) {
    _timeZone = value;
    return this;
  }

  setDateFormat(String value) {
    _dateFormat = value;
    return this;
  }

  setTimeFormat(String value) {
    _timeFormat = value;
    return this;
  }

  setStartOfWeek(int value) {
    _startOfWeek = value;
    return this;
  }

  UpdateSiteSettingsParams build() {
    if (_email.isEmpty || _timeZone.isEmpty) {
      throw AssertionError("Email and TimeZone is required and can't be empty");
    }

    return UpdateSiteSettingsParams(
      title: _title,
      description: _description,
      siteIcon: _siteIcon,
      url: _url,
      email: _email,
      timeZone: _timeZone,
      dateFormat: _dateFormat,
      timeFormat: _timeFormat,
      startOfWeek: _startOfWeek,
    );
  }
}
