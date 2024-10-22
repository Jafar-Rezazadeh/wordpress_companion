import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/core_export.dart';
import '../../../../core/widgets/grouped_radio_button.dart';

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
  final textController = TextEditingController();

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
          const Expanded(child: Text("ساختار تاریخ:")),
          Expanded(
            flex: 3,
            child: GroupedRadioButton<String>(
              initialGroupValue: widget.initialValue,
              items: _listOfRadioTiles,
              onChanged: (value) => widget.onChanged(value),
            ),
          )
        ],
      ),
    );
  }

  List<GroupedRadioButtonTile<String>> get _listOfRadioTiles {
    return [
      GroupedRadioButtonTile(
        title: const Text("8:21 ب.ظ"),
        secondary: const Text("g:i a"),
        value: "g:i a",
      ),
      GroupedRadioButtonTile(
        title: const Text("8:21 ب.ظ"),
        secondary: const Text("g:i A"),
        value: "g:i A",
      ),
      GroupedRadioButtonTile(
        title: const Text("20:21"),
        secondary: const Text("H:i"),
        value: "H:i",
      ),
      GroupedRadioButtonTile(
        title: const Text("سفارشی:"),
        secondary: SizedBox(
          width: 0.15.sw,
          child: _customFormatInputField(),
        ),
        value: textController.text,
      )
    ];
  }

  TextField _customFormatInputField() {
    return TextField(
      controller: textController,
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
}
