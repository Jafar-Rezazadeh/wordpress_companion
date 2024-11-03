import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/core_export.dart';

class SiteIconInput extends StatelessWidget {
  final int? initialValue;
  final Function(int value) onSelect;
  const SiteIconInput({
    super.key,
    this.initialValue,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text("نمادک سایت:"),
        const Gap(10),
        _imageInput(context),
      ],
    );
  }

  Widget _imageInput(BuildContext context) {
    return InkWell(
      onTap: () => _openSelectMedialDialog(context),
      borderRadius: BorderRadius.circular(smallCornerRadius),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: ColorPallet.border),
          borderRadius: BorderRadius.circular(smallCornerRadius),
        ),
        height: 48,
        width: 48,
        child: Image.network(
          "",
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.error,
            color: ColorPallet.text,
          ),
        ),
      ),
    );
  }

  void _openSelectMedialDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const Dialog(
        key: Key("select_media_dialog"),
        // TODO: make media feature and use it here to get image by id and select image
      ),
    );
  }
}
