import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core_export.dart';

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
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 5,
          spreadRadius: 2,
        )
      ]),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        showUnselectedLabels: true,
        showSelectedLabels: false,
        elevation: 5,
        backgroundColor: ColorPallet.white,
        selectedItemColor: ColorPallet.midBlue,
        unselectedItemColor: ColorPallet.text,
        onTap: onTap,
        items: _bottomBavItems,
      ),
    );
  }

  List<BottomNavigationBarItem> get _bottomBavItems {
    return [
      BottomNavigationBarItem(
        activeIcon: _bottomNavActiveIcon(svgIconPath: categoriesSvg),
        icon: SvgPicture.asset(categoriesSvg),
        label: "دسته بندی ها",
      ),
      BottomNavigationBarItem(
        activeIcon: _bottomNavActiveIcon(svgIconPath: listOfItemsSvg),
        icon: SvgPicture.asset(listOfItemsSvg),
        label: "پست ها",
      ),
      BottomNavigationBarItem(
        activeIcon: _bottomNavActiveIcon(svgIconPath: mediaSvg),
        icon: SvgPicture.asset(mediaSvg),
        label: "رسانه",
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
