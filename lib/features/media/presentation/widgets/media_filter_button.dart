import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wordpress_companion/core/extensions/extensions.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/core_export.dart';
import '../../../../core/widgets/custom_persian_date_selector.dart';

class MediaFilterButton extends StatefulWidget {
  final Function(MediaFilters filters) onApply;
  final VoidCallback onClear;
  const MediaFilterButton({
    super.key,
    required this.onApply,
    required this.onClear,
  });

  @override
  State<MediaFilterButton> createState() => _MediaFilterButtonState();
}

typedef MediaFilters = ({
  MediaType? type,
  String? before,
  String? after,
});

class _MediaFilterButtonState extends State<MediaFilterButton> {
  final filtersBuilder = _MediaFiltersBuilder();

  @override
  Widget build(BuildContext context) {
    return FilterButton(
      numberOfAppliedFilters:
          filtersBuilder.filtersCount != 0 ? filtersBuilder.filtersCount : null,
      onPressed: () {
        CustomBottomSheets.showFilterBottomSheet(
          context: context,
          onApply: () => _onApply(context),
          onClear: () => _onClear(context),
          children: [
            _typeFilterWidget(),
            _dateFilterWidget(),
          ],
        );
      },
    );
  }

  void _onClear(BuildContext context) {
    setState(() {
      filtersBuilder.clearAll();
    });
    context.pop();
    widget.onClear();
  }

  void _onApply(BuildContext context) {
    setState(() {});
    context.pop();
    widget.onApply(filtersBuilder.build());
  }

  SizedBox _typeFilterWidget() {
    return SizedBox(
      width: double.infinity,
      child: CustomDropDownButton<MediaType>(
        initialValue: filtersBuilder.type,
        onChanged: (value) => filtersBuilder.setType = value,
        items: [
          const DropdownMenuItem(
            alignment: Alignment.centerRight,
            value: null,
            child: Text("همه ی موارد"),
          ),
          ...MediaType.values.map(
            (type) => DropdownMenuItem(
              alignment: Alignment.centerRight,
              value: type,
              child: Text(type.translate),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateFilterWidget() {
    return ExpansionTile(
      controlAffinity: ListTileControlAffinity.trailing,
      expandedAlignment: Alignment.centerRight,
      title: const Align(
        alignment: Alignment.centerRight,
        child: Text("تاریخ"),
      ),
      children: [
        PersianDateSelector(
          // TODO: improve date selector (initial date )
          label: ":از",
          onSelected: (value) {
            print(value);
          },
        ),
      ],
    );
  }
}

class _MediaFiltersBuilder {
  MediaType? type;
  String? before;
  String? after;

  set setType(MediaType? type) => this.type = type;
  set setBefore(String? before) => this.before = before;
  set setAfter(String? after) => this.after = after;

  int get filtersCount {
    int count = 0;
    if (type != null) count++;
    if (before != null) count++;
    if (after != null) count++;
    return count;
  }

  clearAll() {
    type = null;
    before = null;
    after = null;
  }

  MediaFilters build() {
    return (
      type: type,
      before: before,
      after: after,
    );
  }
}
