import 'package:flutter/material.dart';
import 'package:wordpress_companion/features/site_settings/presentation/widgets/site_settings_format_input.dart';

class DateFormatInput extends StatefulWidget {
  final String? initialValue;
  final Function(String? value) onChanged;
  const DateFormatInput({
    super.key,
    required this.onChanged,
    this.initialValue,
  });

  @override
  State<DateFormatInput> createState() => _DateFormatInputState();
}

class _DateFormatInputState extends State<DateFormatInput> {
  final List<FormatInputPredefine> predefinedTimeFormats = [
    (title: "اکتبر 2024,7", secondary: "F j, Y", value: "F j, Y"),
    (title: "2024-10-07", secondary: "Y-m-d", value: "Y-m-d"),
    (title: "10/07/2024", secondary: "m/d/Y", value: "m/d/Y"),
    (title: "07/10/2024", secondary: "d/m/Y", value: "d/m/Y"),
  ];

  @override
  Widget build(BuildContext context) {
    return SiteSettingsFormatInputWidget(
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      title: "ساختار تاریخ",
      predefinedValues: predefinedTimeFormats,
    );
  }
}
