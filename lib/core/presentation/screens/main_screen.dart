import 'package:flutter/material.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/core/presentation/widgets/main_app_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedPageIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: _selectedPageIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: _bodyLayout(),
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  Widget _bodyLayout() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: _bodySections(),
      ),
    );
  }

  Widget _bodySections() {
    return PageView(
      reverse: true,
      controller: pageController,
      onPageChanged: (value) => setState(() => _selectedPageIndex = value),
      children: const [
        Center(child: Icon(Icons.list_alt)),
        Center(child: Icon(Icons.category)),
        Center(child: Icon(Icons.video_library_rounded)),
        Center(child: Icon(Icons.comment)),
      ],
    );
  }

  Widget _bottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedPageIndex,
      showUnselectedLabels: false,
      selectedItemColor: ColorPallet.midBlue,
      unselectedItemColor: ColorPallet.text,
      onTap: _onBottomNavSelect,
      items: _bottomBavItems,
    );
  }

  void _onBottomNavSelect(value) {
    setState(() {
      _selectedPageIndex = value;
      pageController.animateToPage(
        _selectedPageIndex,
        duration: Durations.short4,
        curve: Curves.easeInOut,
      );
    });
  }

  List<BottomNavigationBarItem> get _bottomBavItems {
    return [
      BottomNavigationBarItem(
        activeIcon: Container(
          color: Colors.red,
          child: const Icon(Icons.list_alt),
        ),
        icon: const Icon(Icons.list_alt),
        label: "پست ها",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.category),
        label: "دسته بندی",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.video_library_rounded),
        label: "رسانه",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.comment),
        label: "دیدگاه ها",
      ),
    ];
  }
}
