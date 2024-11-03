import 'package:flutter/material.dart';
import 'package:flutter_handy_utils/extensions/widgets_separator_.dart';

import '../../../../../core/core_export.dart';

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
          onApply: () => _onApply(),
          onClear: () => _onClear(),
          children: [
            _typeFilterWidget(),
            _dateFilterWidget(),
          ],
        );
      },
    );
  }

  void _onApply() {
    setState(() {});
    Navigator.of(context).pop();
    widget.onApply(filtersBuilder.build());
  }

  void _onClear() {
    setState(() => filtersBuilder.clearAll());
    Navigator.of(context).pop();
    widget.onClear();
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
        _after(),
        _before(),
      ].withGapInBetween(20),
    );
  }

  CustomPersianDateSelector _after() {
    return CustomPersianDateSelector(
      key: const Key("after_date_selector"),
      initialDate: DateTime.tryParse(filtersBuilder.after ?? ""),
      label: ":بعد از",
      onSelected: (value) {
        filtersBuilder.setAfter = value?.toIso8601String();
      },
    );
  }

  CustomPersianDateSelector _before() {
    return CustomPersianDateSelector(
      key: const Key("before_date_selector"),
      initialDate: DateTime.tryParse(filtersBuilder.before ?? ""),
      label: ":قبل از",
      onSelected: (value) {
        filtersBuilder.setBefore = value?.toIso8601String();
      },
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
