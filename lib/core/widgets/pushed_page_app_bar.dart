import 'package:flutter/material.dart';
import '../core_export.dart';

class PushedPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final double bottomHeightSize;
  final String? title;
  final List<Widget> bottomLeadingWidgets;
  final List<Widget> bottomActionWidgets;

  const PushedPageAppBar({
    super.key,
    required this.context,
    this.bottomHeightSize = 80.0,
    this.title,
    this.bottomLeadingWidgets = const <Widget>[],
    this.bottomActionWidgets = const <Widget>[],
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 5,
      title: title != null ? Text(title ?? "") : null,
      centerTitle: true,
      shadowColor: Colors.black54,
      backgroundColor: ColorPallet.white,
      foregroundColor: ColorPallet.text,
      surfaceTintColor: ColorPallet.white,
      bottom: _hasBottomActions ? _bottomSection() : null,
    );
  }

  bool get _hasBottomActions =>
      bottomLeadingWidgets.isNotEmpty || bottomActionWidgets.isNotEmpty;

  PreferredSize _bottomSection() {
    return PreferredSize(
      preferredSize: Size(double.infinity, bottomHeightSize),
      child: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: ColorPallet.border)),
        ),
        alignment: Alignment.center,
        width: double.infinity,
        height: bottomHeightSize,
        padding: const EdgeInsets.symmetric(
          horizontal: edgeToEdgePaddingHorizontal,
        ),
        child: _bottomSectionContents(),
      ),
    );
  }

  Row _bottomSectionContents() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textDirection: TextDirection.rtl,
      children: [
        _leadings(),
        _secondaryActions(),
      ],
    );
  }

  Widget _leadings() {
    return Row(
      children: bottomLeadingWidgets,
    );
  }

  Widget _secondaryActions() {
    return Row(
      children: bottomActionWidgets,
    );
  }

  @override
  Size get preferredSize => Size(
        double.infinity,
        AppBar().preferredSize.height +
            (_hasBottomActions ? bottomHeightSize : 0),
      );
}
