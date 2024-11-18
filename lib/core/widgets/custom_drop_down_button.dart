import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../core_export.dart';

class CustomDropDownButton<T> extends StatefulWidget {
  final Function(T? value) onChanged;
  final List<DropdownMenuItem<T>>? items;
  final T? initialValue;

  const CustomDropDownButton({
    super.key,
    this.items,
    required this.onChanged,
    this.initialValue,
  });

  @override
  State<CustomDropDownButton<T>> createState() =>
      _CustomDropDownButtonState<T>();
}

class _CustomDropDownButtonState<T> extends State<CustomDropDownButton<T>> {
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: ColorPallet.border),
          borderRadius: BorderRadius.circular(smallCornerRadius),
        ),
        child: _dropDownButton(),
      ),
    );
  }

  Widget _dropDownButton() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        value: selectedValue,
        buttonStyleData: const ButtonStyleData(
          padding:
              EdgeInsets.symmetric(horizontal: edgeToEdgePaddingHorizontal),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(Icons.expand_more),
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(smallCornerRadius),
          ),
        ),
        items: widget.items,
        onChanged: (value) {
          setState(() => selectedValue = value);
          widget.onChanged(value);
        },
      ),
    );
  }
}
