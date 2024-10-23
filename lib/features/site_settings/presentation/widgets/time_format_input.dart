import 'package:flutter/material.dart';
import 'package:wordpress_companion/features/site_settings/presentation/widgets/site_settings_format_input.dart';

class TimeFormatInput extends StatefulWidget {
  final String? initialValue;
  final Function(String? value) onChanged;
  const TimeFormatInput({
    super.key,
    required this.onChanged,
    this.initialValue,
  });

  @override
  State<TimeFormatInput> createState() => _TimeFormatInputState();
}

class _TimeFormatInputState extends State<TimeFormatInput> {
  List<FormatInputPredefine> predefinedTimeFormats = [
    (title: "8:21 ب.ظ", secondary: "g:i a", value: "g:i a"),
    (title: "8:21 ب.ظ", secondary: "g:i A", value: "g:i A"),
    (title: "21:21", secondary: "H:i", value: "H:i"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SiteSettingsFormatInputWidget(
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      title: "ساختار زمان",
      predefinedValues: predefinedTimeFormats,
    );
  }
}
