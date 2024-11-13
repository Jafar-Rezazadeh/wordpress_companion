import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
  List<PostStatus> selectedStatus = PostStatus.values;
  String? afterDate;
  String? beforeDate;

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
              ..setBefore(beforeDate);

            widget.onApply();
          },
          onClear: widget.onClear,
          children: [
            _statusFilter(),
            _dateFilter(),
            // TODO: categoryFilter
          ],
        );
      },
    );
  }

  int? _countFilters() {
    int count = 0;

    if (widget.filters.after != null) {
      count++;
    }
    if (widget.filters.before != null) {
      count++;
    }
    if (widget.filters.status != PostStatus.values) {
      count++;
    }
    return count == 0 ? null : count;
  }

  Row _statusFilter() {
    return Row(
      children: [
        Text("وضعیت: ", style: Theme.of(context).textTheme.titleMedium),
        Expanded(
          child: CustomDropDownButton<PostStatus>(
            initialValue: widget.filters.status.length == 1
                ? widget.filters.status.first
                : null,
            items: [
              _allStatus(),
              ..._statusItems(),
            ],
            onChanged: (value) {
              if (value != null) {
                selectedStatus = [value];
              } else {
                selectedStatus = PostStatus.values;
              }
            },
          ),
        ),
      ],
    );
  }

  DropdownMenuItem<PostStatus> _allStatus() {
    return const DropdownMenuItem(
      value: null,
      child: Text("همه ی موارد"),
    );
  }

  Iterable<DropdownMenuItem<PostStatus>> _statusItems() {
    return PostStatus.values.map(
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
}
