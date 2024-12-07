import 'package:flutter/material.dart';
import 'package:flutter_handy_utils/extensions/widgets_separator_.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:wordpress_companion/core/core_export.dart';

class CustomBottomSheets {
  static Future<void> showFailureBottomSheet({
    required BuildContext context,
    required Failure failure,
  }) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: 0.8.sh,
      ),
      builder: (_) => Container(
        key: const Key("failure_bottom_sheet"),
        child: FailureWidget(failure: failure),
      ),
    );
  }

  static Future<void> showFilterBottomSheet({
    required BuildContext context,
    required Function() onApply,
    required Function() onClear,
    required List<Widget> children,
  }) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: 0.8.sh,
      ),
      builder: (dialogContext) => _FilterBottomSheetWidget(
        onApply: () {
          Navigator.of(dialogContext).pop();
          onApply();
        },
        onClear: () {
          Navigator.of(dialogContext).pop();
          onClear();
        },
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
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
      child: SingleChildScrollView(
        child: Column(
          children: children.withGapInBetween(20),
        ),
      ),
    );
  }
}
