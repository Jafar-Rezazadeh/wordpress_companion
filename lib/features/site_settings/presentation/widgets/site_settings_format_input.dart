import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wordpress_companion/core/core_export.dart';

import '../../../../core/widgets/grouped_radio_button.dart';

typedef FormatInputPredefine = ({String title, String secondary, String value});

class SiteSettingsFormatInputWidget extends StatefulWidget {
  final String? initialValue;
  final String title;
  final void Function(String) onChanged;
  final List<FormatInputPredefine> predefinedValues;

  const SiteSettingsFormatInputWidget({
    super.key,
    this.initialValue,
    required this.onChanged,
    required this.title,
    required this.predefinedValues,
  });

  @override
  State<SiteSettingsFormatInputWidget> createState() =>
      _SiteSettingsFormatInputWidgetState();
}

class _SiteSettingsFormatInputWidgetState
    extends State<SiteSettingsFormatInputWidget> {
  late TextEditingController customFormatController;

  @override
  void initState() {
    super.initState();
    customFormatController = TextEditingController(
      text: _ifNotAlreadyDefined() ? widget.initialValue : "",
    );
  }

  bool _ifNotAlreadyDefined() =>
      widget.predefinedValues.every((e) => e.value != widget.initialValue);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorPallet.border),
        borderRadius: BorderRadius.circular(smallCornerRadius),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(widget.title)),
          Expanded(
            flex: 3,
            child: GroupedRadioButton<String>(
              initialGroupValue: widget.initialValue,
              items: _listOfRadioTiles,
              onChanged: (value) => widget.onChanged(value ?? ""),
            ),
          )
        ],
      ),
    );
  }

  List<GroupedRadioButtonTile<String>> get _listOfRadioTiles {
    return widget.predefinedValues
        .map((e) => GroupedRadioButtonTile(
              title: Text(e.title),
              secondary: Text(e.secondary),
              value: e.value,
            ))
        .toList()
      ..add(
        GroupedRadioButtonTile(
          title: const Text("سفارشی:"),
          secondary: SizedBox(
            width: 0.15.sw,
            child: _customFormatInputField(),
          ),
          value: customFormatController.text,
        ),
      );
  }

  Widget _customFormatInputField() {
    return TextFormField(
      controller: customFormatController,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.bodySmall,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorPallet.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorPallet.border),
        ),
      ),
      onChanged: (_) => setState(() {}),
    );
  }

  @override
  void dispose() {
    customFormatController.dispose();
    super.dispose();
  }
}
