import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/core_export.dart';

import '../../../../core/widgets/grouped_radio_button.dart';

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
  final textController = TextEditingController(text: " ");

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
        title: const Text("اکتبر 2024,7"),
        secondary: const Text("F j,Y"),
        value: "F j,Y",
      ),
      GroupedRadioButtonTile(
        title: const Text("2024-10-07"),
        secondary: const Text("Y-m-d"),
        value: "Y-m-d",
      ),
      GroupedRadioButtonTile(
        title: const Text("10/07/2024"),
        secondary: const Text("m/d/Y"),
        value: "m/d/Y",
      ),
      GroupedRadioButtonTile(
        title: const Text("07/10/2024"),
        secondary: const Text("d/m/Y"),
        value: "d/m/Y",
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
