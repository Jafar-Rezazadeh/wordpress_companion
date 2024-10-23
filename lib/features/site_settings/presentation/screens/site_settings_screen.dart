import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_handy_utils/extensions/widgets_separator_.dart';
import 'package:gap/gap.dart';
import 'package:wordpress_companion/core/widgets/custom_bottom_sheet.dart';
import '../../../../core/core_export.dart';
import '../../site_settings_exports.dart';

import '../../../../core/widgets/time_zone_selector.dart';
import '../widgets/start_of_week_input.dart';

class SiteSettingsScreen extends StatefulWidget {
  const SiteSettingsScreen({super.key});

  @override
  State<SiteSettingsScreen> createState() => _SiteSettingsScreenState();
}

class _SiteSettingsScreenState extends State<SiteSettingsScreen> {
  final formKey = GlobalKey<FormState>();
  final emailFocus = FocusNode();
  SiteSettingsEntity? settingData;

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

  Widget _settingsBuilder() {
    return BlocConsumer<SiteSettingsCubit, SiteSettingsState>(
      listener: _siteSettingsStateListener,
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const Center(child: LoadingWidget()),
          updating: () => const Center(child: LoadingWidget()),
          orElse: () => _body(),
        );
      },
    );
  }

  _siteSettingsStateListener(_, SiteSettingsState state) {
    state.whenOrNull(
      loaded: (settings) => settingData = settings,
      updated: (settings) => settingData = settings,
      error: (failure) => CustomBottomSheet.showFailureBottomSheet(
        context: context,
        failure: failure,
      ),
    );
  }

  PushedPageAppBar _appBar() {
    return PushedPageAppBar(
      context: context,
      title: "تنظیمات سایت",
      bottomActionWidgets: [
        SaveButton(
          key: const Key("save_site_settings_button"),
          onPressed: () {
            if (formKey.currentState?.validate() == true) {
              // save...
            }
          },
        ),
      ],
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
            CustomFormInputField(
              initialValue: settingData?.title,
              label: "عنوان سایت",
            ),
            CustomFormInputField(
              initialValue: settingData?.description,
              label: "معرفی کوتاه",
            ),
            SiteIconInput(
              initialValue: settingData?.siteIcon,
            ),
            CustomFormInputField(
              initialValue: settingData?.url,
              label: "نشانی سایت",
            ),
            CustomFormInputField(
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
            ),
            _timeZoneInput(),
            DateFormatInput(
              initialValue: settingData?.dateFormat,
              onChanged: (value) {
                print(value);
              },
            ),
            TimeFormatInput(
              initialValue: settingData?.timeFormat,
              onChanged: (value) {
                print(value);
              },
            ),
            StartOfWeekInput(
              initialValue: settingData?.startOfWeek,
              onSelect: (value) {
                print(value);
              },
            ),
            const Gap(50),
          ].withGapInBetween(25),
        ),
      ),
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
          onTimezoneSelected: (timeZone) {},
        ),
      ],
    );
  }
}
