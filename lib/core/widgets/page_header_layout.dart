import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wordpress_companion/core/core_export.dart';

class PageHeaderLayout extends StatelessWidget {
  final Widget? leftWidget;
  final Widget? rightWidget;
  const PageHeaderLayout({
    super.key,
    this.leftWidget,
    this.rightWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: ColorPallet.border),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: rightWidget ?? const Placeholder(),
          ),
          const Gap(30),
          Expanded(
            flex: 3,
            child: leftWidget ?? const Placeholder(),
          )
        ],
      ),
    );
  }
}
