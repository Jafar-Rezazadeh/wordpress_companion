import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

extension WidgetList on List<Widget> {
  List<Widget> withSpaceBetween(double gapSize) {
    final separatedList = <Widget>[];

    separatedList.add(first);

    map(
      (e) {
        if (_isNotFirstAndLastItem(e)) {
          separatedList.addAll([Gap(gapSize), e]);
        }
      },
    ).toList();

    return separatedList;
  }

  bool _isNotFirstAndLastItem(Widget e) => indexOf(e) > 0 && indexOf(e) < length;
}
