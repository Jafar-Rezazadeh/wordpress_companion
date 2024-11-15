import 'package:flutter/material.dart';
import 'package:flutter_handy_utils/flutter_handy_utils.dart';
import 'package:gap/gap.dart';
import 'package:wordpress_companion/features/posts/presentation/widgets/create_or_edit_screen/section_title.dart';

import '../../../../../core/core_export.dart';

class TagInputWidget extends StatefulWidget {
  const TagInputWidget({super.key});

  @override
  State<TagInputWidget> createState() => _TagInputWidgetState();
}
// TODO: make tags feature and use it here

class _TagInputWidgetState extends State<TagInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: "برچسب ها"),
        _addTagInput(),
        _selectFromTags(),
        _selectedTags(),
      ].withGapInBetween(15),
    );
  }

  Row _addTagInput() {
    return Row(
      children: [
        const Expanded(
          child: CustomFormInputField(label: ""),
        ),
        const Gap(20),
        FilledButton(
          onPressed: () {},
          child: const Text("اضافه"),
        )
      ],
    );
  }

  Widget _selectFromTags() {
    return TextButton(
      onPressed: () {},
      child: const Text("انتخاب از برچسب ها استفاده شده"),
    );
  }

  Widget _selectedTags() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(
        4,
        (index) => Chip(
          label: Text("برچسب $index"),
          visualDensity: VisualDensity.compact,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          onDeleted: () {},
        ),
      ),
    );
  }
}
