import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordpress_companion/core/core_export.dart';

class CustomizedBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const CustomizedBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      selectedItemColor: ColorPallet.midBlue,
      unselectedItemColor: ColorPallet.text,
      onTap: onTap,
      items: _bottomBavItems,
    );
  }

  List<BottomNavigationBarItem> get _bottomBavItems {
    return [
      BottomNavigationBarItem(
        activeIcon: _bottomNavActiveIcon(svgIconPath: listOfItemsSvg),
        icon: SvgPicture.asset(listOfItemsSvg),
        label: "پست ها",
      ),
      BottomNavigationBarItem(
        activeIcon: _bottomNavActiveIcon(svgIconPath: categoriesSvg),
        icon: SvgPicture.asset(categoriesSvg),
        label: "دسته بندی",
      ),
      BottomNavigationBarItem(
        activeIcon: _bottomNavActiveIcon(svgIconPath: mediaSvg),
        icon: SvgPicture.asset(mediaSvg),
        label: "رسانه",
      ),
      BottomNavigationBarItem(
        activeIcon: _bottomNavActiveIcon(svgIconPath: commentsSvg),
        icon: SvgPicture.asset(commentsSvg),
        label: "دیدگاه ها",
      ),
    ];
  }

  Widget _bottomNavActiveIcon({required String svgIconPath}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ColorPallet.midBlue,
        borderRadius: BorderRadius.circular(smallCornerRadius),
      ),
      child: SvgPicture.asset(
        svgIconPath,
        colorFilter: ColorFilter.mode(ColorPallet.white, BlendMode.srcIn),
      ),
    ).animate().fadeIn(duration: Durations.long4);
  }
}
