import 'package:flutter/material.dart';
import 'package:flutter_handy_utils/extensions/widgets_separator_.dart';
import 'package:gap/gap.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(),
    );
  }

  PushedPageAppBar _appBar(BuildContext context) {
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
            const CustomFormInputField(label: "عنوان سایت"),
            const CustomFormInputField(label: "معرفی کوتاه"),
            const SiteIconInput(),
            const CustomFormInputField(label: "نشانی سایت"),
            CustomFormInputField(
              key: const Key("email_input"),
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
              initialValue: "F j,Y",
              onChanged: (value) {
                print(value);
              },
            ),
            TimeFormatInput(
              initialValue: "g:i a",
              onChanged: (value) {
                print(value);
              },
            ),
            StartOfWeekInput(
              initialValue: 1,
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
          selectHint: "انتخاب زمان محلی",
          searchHint: "جستجو...",
          onTimezoneSelected: (timeZone) {},
        ),
      ],
    );
  }
}
