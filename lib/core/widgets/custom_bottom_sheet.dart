import 'package:flutter/material.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/core/errors/failures.dart';

class CustomBottomSheet {
  static showFailureBottomSheet({
    required BuildContext context,
    required Failure failure,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => FailureWidget(failure: failure),
    );
  }
}
