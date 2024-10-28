import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:wordpress_companion/core/core_export.dart';

class FilterButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final int? numberOfAppliedFilters;
  const FilterButton({super.key, this.onPressed, this.numberOfAppliedFilters});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(mediumCornerRadius),
          color: ColorPallet.lightBlue,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _iconAndLabel(),
            if (numberOfAppliedFilters != null) _numberOfFilters(),
          ],
        ),
      ),
    );
  }

  Widget _iconAndLabel() {
    return const Row(
      children: [
        Icon(Icons.filter_list, color: Colors.white),
        Gap(10),
        Text("فیلتر", style: TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _numberOfFilters() {
    return Badge.count(
      backgroundColor: ColorPallet.midBlue,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(2),
      textStyle: TextStyle(
        color: ColorPallet.white,
        fontSize: 10.sp,
      ),
      count: numberOfAppliedFilters ?? 0,
    );
  }
}
