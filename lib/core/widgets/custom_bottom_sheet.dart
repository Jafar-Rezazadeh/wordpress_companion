import 'package:flutter/material.dart';
import 'package:flutter_handy_utils/extensions/widgets_separator_.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/core/errors/failures.dart';

class CustomBottomSheets {
  static showFailureBottomSheet({
    required BuildContext context,
    required Failure failure,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Container(
        key: const Key("failure_bottom_sheet"),
        child: FailureWidget(failure: failure),
      ),
    );
  }

  static showFilterBottomSheet({
    required BuildContext context,
    required Function() onApply,
    required Function() onClear,
    required List<Widget> children,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => _FilterBottomSheetWidget(
        onApply: onApply,
        onClear: onClear,
        children: children,
      ),
    );
  }
}

class _FilterBottomSheetWidget extends StatelessWidget {
  @override
  Key? get key => const Key("filter_bottom_sheet");
  final Function() onApply;
  final Function() onClear;
  final List<Widget> children;
  const _FilterBottomSheetWidget({
    required this.onApply,
    required this.onClear,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: edgeToEdgePaddingHorizontal,
      ),
      height: 0.8.sh,
      child: Column(
        children: [
          _actions(),
          _children(),
        ],
      ),
    );
  }

  Widget _actions() {
    return Expanded(
      flex: 1,
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Expanded(child: _applyFilterButton()),
          const Gap(20),
          Expanded(child: _clearFilterButton()),
        ],
      ),
    );
  }

  FilledButton _applyFilterButton() {
    return FilledButton(
      key: const Key("apply_filter_button"),
      onPressed: onApply,
      style: FilledButton.styleFrom(
        backgroundColor: ColorPallet.lightBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(mediumCornerRadius),
        ),
      ),
      child: const Text("اعمال فیلتر"),
    );
  }

  Widget _clearFilterButton() {
    return OutlinedButton(
      key: const Key("clear_filter_button"),
      onPressed: onClear,
      style: FilledButton.styleFrom(
        side: BorderSide(color: ColorPallet.lightBlue),
        foregroundColor: ColorPallet.lightBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(mediumCornerRadius),
        ),
      ),
      child: const Text("پاک کردن فیلتر"),
    );
  }

  Widget _children() {
    return Expanded(
      flex: 3,
      child: Column(
        children: children.withGapInBetween(20),
      ),
    );
  }
}
