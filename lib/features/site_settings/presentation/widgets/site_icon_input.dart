import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/core_export.dart';

// TODO: make media feature and use it here
class SiteIconInput extends StatelessWidget {
  final int? initialValue;
  const SiteIconInput({super.key, this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text("نمادک سایت:"),
        const Gap(10),
        _imageInput(),
      ],
    );
  }

  Widget _imageInput() {
    return InkWell(
      onTap: () {},
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
}
