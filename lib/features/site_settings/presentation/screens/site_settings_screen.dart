import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_handy_utils/extensions/widgets_separator_.dart';
import 'package:gap/gap.dart';
import '../../../../core/core_export.dart';
import '../../site_settings_exports.dart';

class SiteSettingsScreen extends StatefulWidget {
  const SiteSettingsScreen({super.key});

  @override
  State<SiteSettingsScreen> createState() => _SiteSettingsScreenState();
}

class _SiteSettingsScreenState extends State<SiteSettingsScreen> {
  final formKey = GlobalKey<FormState>();
  final emailFocus = FocusNode();
  SiteSettingsEntity? settingData;
  final updateSiteSettingsParamsBuilder = UpdateSiteSettingsParamsBuilder();

  @override
  void initState() {
    context.read<SiteSettingsCubit>().loadSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _settingsBuilder(),
    );
  }

  PushedPageAppBar _appBar() {
    return PushedPageAppBar(
      context: context,
      title: "تنظیمات سایت",
      bottomLeadingWidgets: [
        _submit(),
      ],
    );
  }

  SaveButton _submit() {
    return SaveButton(
      key: const Key("save_site_settings_button"),
      onPressed: () {
        if (formKey.currentState?.validate() == true) {
          final params = updateSiteSettingsParamsBuilder.build();
          context.read<SiteSettingsCubit>().updateSettings(params);
        }
      },
    );
  }

  Widget _settingsBuilder() {
    return BlocConsumer<SiteSettingsCubit, SiteSettingsState>(
      listener: _siteSettingsStateListener,
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => _loadingWidget(),
          updating: () => _loadingWidget(),
          orElse: () => _body(),
        );
      },
    );
  }

  Widget _loadingWidget() {
    return Container(
      padding: const EdgeInsets.only(top: 50),
      width: double.infinity,
      child: const LoadingWidget(),
    );
  }

  _siteSettingsStateListener(_, SiteSettingsState state) {
    state.whenOrNull(
      loaded: (settings) {
        updateSiteSettingsParamsBuilder.fromExistingObject(settings);
        settingData = settings;
        return;
      },
      updated: (settings) {
        updateSiteSettingsParamsBuilder.fromExistingObject(settings);
        settingData = settings;
        return;
      },
      error: (failure) => CustomBottomSheets.showFailureBottomSheet(
        context: context,
        failure: failure,
      ),
    );
  }

  Widget _body() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: edgeToEdgePaddingHorizontal,
            vertical: 30,
          ),
          children: [
            _titleInput(),
            _descriptionInput(),
            _siteIconInput(),
            _urlInput(),
            _emailInput(),
            _timeZoneInput(),
            _dateFormatInput(),
            _timeFormatInput(),
            _startOfWeekInput(),
            const Gap(50),
          ].withGapInBetween(25),
        ),
      ),
    );
  }

  Widget _titleInput() {
    return CustomFormInputField(
      initialValue: settingData?.title,
      label: "عنوان سایت",
      onChanged: (value) => updateSiteSettingsParamsBuilder.setTitle(value),
    );
  }

  Widget _descriptionInput() {
    return CustomFormInputField(
      initialValue: settingData?.description,
      label: "معرفی کوتاه",
      onChanged: (value) =>
          updateSiteSettingsParamsBuilder.setDescription(value),
    );
  }

  Widget _siteIconInput() {
    return SiteIconInput(
      initialValue: settingData?.siteIcon,
      onSelect: (value) => updateSiteSettingsParamsBuilder.setIcon(value),
    );
  }

  Widget _urlInput() {
    return CustomFormInputField(
      initialValue: settingData?.url,
      textDirection: TextDirection.ltr,
      label: "نشانی سایت",
      onChanged: (value) => updateSiteSettingsParamsBuilder.setUrl(value),
    );
  }

  Widget _emailInput() {
    return CustomFormInputField(
      key: const Key("email_input"),
      initialValue: settingData?.email,
      label: "ایمیل",
      focusNode: emailFocus,
      validator: (value) {
        final isValid = InputValidator.isValidEmail(value);
        if (isValid != null) {
          emailFocus.requestFocus();
        }
        return isValid;
      },
      onChanged: (value) => updateSiteSettingsParamsBuilder.setEmail(value),
    );
  }

  Widget _timeZoneInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("زمان محلی:"),
        TimezoneDropdown(
          initialTimeZone: settingData?.timeZone,
          selectHint: "انتخاب زمان محلی",
          searchHint: "جستجو...",
          onTimezoneSelected: (timeZone) =>
              updateSiteSettingsParamsBuilder.setTimeZone(timeZone),
        ),
      ],
    );
  }

  Widget _dateFormatInput() {
    return DateFormatInput(
      key: const Key("date_format_input"),
      initialValue: settingData?.dateFormat,
      onChanged: (value) =>
          updateSiteSettingsParamsBuilder.setDateFormat(value),
    );
  }

  Widget _timeFormatInput() {
    return TimeFormatInput(
      key: const Key("time_format_input"),
      initialValue: settingData?.timeFormat,
      onChanged: (value) =>
          updateSiteSettingsParamsBuilder.setTimeFormat(value),
    );
  }

  Widget _startOfWeekInput() {
    return StartOfWeekInput(
      initialValue: settingData?.startOfWeek,
      onSelect: (value) =>
          updateSiteSettingsParamsBuilder.setStartOfWeek(value),
    );
  }
}
