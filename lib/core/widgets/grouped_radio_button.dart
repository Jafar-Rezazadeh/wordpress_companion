import 'package:flutter/material.dart';

// TODO: put this into flutter_handy_utils
class GroupedRadioButtonTile<T> {
  final Widget title;
  final Widget? secondary;
  final T value;

  GroupedRadioButtonTile({
    required this.title,
    required this.value,
    this.secondary,
  });
}

class GroupedRadioButton<T> extends StatefulWidget {
  final Function(T? value) onChanged;
  final List<GroupedRadioButtonTile<T>> items;
  final T? initialGroupValue;
  const GroupedRadioButton({
    super.key,
    required this.items,
    required this.onChanged,
    this.initialGroupValue,
  });

  @override
  State<GroupedRadioButton<T>> createState() => _GroupedRadioButtonState<T>();
}

class _GroupedRadioButtonState<T> extends State<GroupedRadioButton<T>> {
  T? groupValue;

  @override
  void initState() {
    super.initState();
    groupValue = widget.initialGroupValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.items
          .map(
            (e) => RadioListTile<T>(
              title: e.title,
              secondary: e.secondary,
              dense: true,
              value: e.value,
              groupValue: groupValue,
              visualDensity: VisualDensity.compact,
              onChanged: (value) {
                setState(() => groupValue = value);
                widget.onChanged(value);
              },
            ),
          )
          .toList(),
    );
  }
}
