import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../../../../core/core_export.dart';

class StartOfWeekInput extends StatefulWidget {
  final int? initialValue;
  final Function(int value) onSelect;
  const StartOfWeekInput({
    super.key,
    required this.onSelect,
    this.initialValue,
  });

  @override
  State<StartOfWeekInput> createState() => _StartOfWeekInputState();
}

class _StartOfWeekInputState extends State<StartOfWeekInput> {
  int? selectedValue;

  @override
  void initState() {
    selectedValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("روز آغازین هفته: "),
        DropdownButtonHideUnderline(
          child: DropdownButton2<int>(
            value: selectedValue,
            items: _listOfWeekDays,
            onChanged: (value) {
              if (value == null) {
                return;
              }
              setState(() => selectedValue = value);
              widget.onSelect(value);
            },
            hint: const Text("روز آغازین هفته"),
            iconStyleData: const IconStyleData(
              icon: Icon(Icons.expand_more),
            ),
            buttonStyleData: ButtonStyleData(
              decoration: BoxDecoration(
                border: Border.all(color: ColorPallet.border),
                borderRadius: BorderRadius.circular(smallCornerRadius),
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: edgeToEdgePaddingHorizontal),
            ),
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<int>> get _listOfWeekDays {
    return const [
      DropdownMenuItem(
        value: 0,
        child: Text("یکشنبه"),
      ),
      DropdownMenuItem(
        value: 1,
        child: Text("دوشنبه"),
      ),
      DropdownMenuItem(
        value: 2,
        child: Text("سه شنبه"),
      ),
      DropdownMenuItem(
        value: 3,
        child: Text("چهارشنبه"),
      ),
      DropdownMenuItem(
        value: 4,
        child: Text("پنج شنبه"),
      ),
      DropdownMenuItem(
        value: 5,
        child: Text("جمعه"),
      ),
      DropdownMenuItem(
        value: 6,
        child: Text("شنبه"),
      ),
    ];
  }
}
