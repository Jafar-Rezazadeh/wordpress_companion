import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wordpress_companion/features/categories/application/widgets/category_selector_widget.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';

import '../../../../../core/core_export.dart';

class PostsFilterWidget extends StatefulWidget {
  final GetPostsFilters filters;
  final VoidCallback onApply;
  final VoidCallback onClear;
  const PostsFilterWidget({
    super.key,
    required this.filters,
    required this.onApply,
    required this.onClear,
  });

  @override
  State<PostsFilterWidget> createState() => _PostsFilterWidgetState();
}

class _PostsFilterWidgetState extends State<PostsFilterWidget> {
  List<PostStatusEnum> selectedStatus = PostStatusEnum.values;
  String? afterDate;
  String? beforeDate;
  List<int>? selectedCategories;

  @override
  Widget build(BuildContext context) {
    return FilterButton(
      numberOfAppliedFilters: _countFilters(),
      onPressed: () async {
        await CustomBottomSheets.showFilterBottomSheet(
          context: context,
          onApply: () {
            widget.filters
              ..setStatus(selectedStatus)
              ..setAfter(afterDate)
              ..setBefore(beforeDate)
              ..setCategories(selectedCategories);

            widget.onApply();
          },
          onClear: () {
            _resetFilterVariables();
            widget.onClear();
          },
          children: [
            _statusFilter(),
            _dateFilter(),
            _categorySelector(),
          ],
        );
      },
    );
  }

  void _resetFilterVariables() {
    selectedStatus = PostStatusEnum.values;
    afterDate = null;
    beforeDate = null;
    selectedCategories = null;
  }

  int? _countFilters() {
    int count = 0;

    if (widget.filters.after != null) {
      count++;
    }
    if (widget.filters.before != null) {
      count++;
    }
    if (widget.filters.status != PostStatusEnum.values) {
      count++;
    }
    if (widget.filters.categories?.isNotEmpty == true) {
      count++;
    }
    return count == 0 ? null : count;
  }

  Row _statusFilter() {
    return Row(
      children: [
        Text("وضعیت: ", style: Theme.of(context).textTheme.titleMedium),
        Expanded(
          child: CustomDropDownButton<PostStatusEnum>(
            initialValue: _initialStatus(),
            items: [
              _allStatus(),
              ..._statusItems(),
            ],
            onChanged: (value) {
              if (value != null) {
                selectedStatus = [value];
              } else {
                selectedStatus = PostStatusEnum.values;
              }
            },
          ),
        ),
      ],
    );
  }

  PostStatusEnum? _initialStatus() {
    return widget.filters.status.length == 1
        ? widget.filters.status.first
        : null;
  }

  DropdownMenuItem<PostStatusEnum> _allStatus() {
    return const DropdownMenuItem(
      value: null,
      child: Text("همه ی موارد"),
    );
  }

  Iterable<DropdownMenuItem<PostStatusEnum>> _statusItems() {
    return PostStatusEnum.values.map(
      (e) => DropdownMenuItem(
        value: e,
        child: Text(e.translate()),
      ),
    );
  }

  Widget _dateFilter() {
    return ExpansionTile(
      key: const Key("date_filter_expansion"),
      title: const Text("تاریخ"),
      initiallyExpanded: _expandIfOneOfTheDatesSelected,
      controlAffinity: ListTileControlAffinity.leading,
      children: [
        _afterDateInput(),
        const Gap(10),
        _beforeDateInput(),
      ],
    );
  }

  bool get _expandIfOneOfTheDatesSelected =>
      widget.filters.after != null || widget.filters.before != null;

  Widget _afterDateInput() {
    return CustomPersianDateSelector(
      key: const Key("after_date_input"),
      initialDate: DateTime.tryParse(widget.filters.after ?? ""),
      onSelected: (value) {
        afterDate = value?.toIso8601String();
      },
      label: "از:",
    );
  }

  Widget _beforeDateInput() {
    return CustomPersianDateSelector(
      key: const Key("before_date_input"),
      initialDate: DateTime.tryParse(widget.filters.before ?? ""),
      onSelected: (value) {
        beforeDate = value?.toIso8601String();
      },
      label: "تا:",
    );
  }

  Widget _categorySelector() {
    return ExpansionTile(
      key: const Key("category_selector_expansion"),
      title: const Text("دسته بندی ها"),
      initiallyExpanded: widget.filters.categories?.isNotEmpty == true,
      children: [
        CategorySelectorWidget(
          initialSelectedCategories: widget.filters.categories ?? [],
          onSelect: (value) {
            selectedCategories = value.map((e) => e.id).toList();
          },
        )
      ],
    );
  }
}
