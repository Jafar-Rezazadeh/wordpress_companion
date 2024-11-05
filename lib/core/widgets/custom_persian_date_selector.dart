import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class CustomPersianDateSelector extends StatefulWidget {
  final String label;
  final DateTime? initialDate;
  final Function(DateTime? value) onSelected;
  const CustomPersianDateSelector({
    super.key,
    required this.onSelected,
    required this.label,
    this.initialDate,
  });

  @override
  State<CustomPersianDateSelector> createState() =>
      _CustomPersianDateSelectorState();
}

class _CustomPersianDateSelectorState extends State<CustomPersianDateSelector> {
  Jalali? selectedDate;
  @override
  void initState() {
    _setInitialDate();
    super.initState();
  }

  void _setInitialDate() {
    if (widget.initialDate != null) {
      selectedDate = Jalali.fromDateTime(widget.initialDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Text(widget.label),
        const Gap(20),
        SizedBox(
          width: 0.4.sw,
          child: FilledButton(
            onPressed: () async => await _onPressed(context),
            child: Text(selectedDate?.formatCompactDate() ?? "-"),
          ),
        ),
      ],
    );
  }

  Future<void> _onPressed(BuildContext context) async {
    var value = await _pickDate(context);
    setState(() => selectedDate = value);
    widget.onSelected(value?.toDateTime());
  }

  Future<Jalali?> _pickDate(BuildContext context) {
    return showPersianDatePicker(
      context: context,
      initialDate: selectedDate ?? Jalali.now(),
      firstDate: Jalali(1385, 1),
      lastDate: Jalali.now().addYears(5),
      initialEntryMode: PersianDatePickerEntryMode.calendar,
    );
  }
}
