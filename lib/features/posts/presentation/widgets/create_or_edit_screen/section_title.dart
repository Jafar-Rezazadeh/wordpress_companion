import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/core_export.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const Gap(10),
        Expanded(
          child: Divider(
            color: ColorPallet.border,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
