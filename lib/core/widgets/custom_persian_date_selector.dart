import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class PersianDateSelector extends StatelessWidget {
  final String label;
  final Function(Jalali? value) onSelected;
  const PersianDateSelector({
    super.key,
    required this.onSelected,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Text(label),
        const Gap(20),
        SizedBox(
          width: 0.4.sw,
          child: FilledButton(
            onPressed: () async {
              final value = await showPersianDatePicker(
                context: context,
                initialDate: Jalali.now(),
                firstDate: Jalali(1385, 1),
                lastDate: Jalali.now().addYears(5),
                initialEntryMode: PersianDatePickerEntryMode.calendar,
              );

              onSelected(value);
            },
            child: const Text("-"),
          ),
        ),
      ],
    );
  }
}
