import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordpress_companion/core/constants/constants.dart';
import 'package:wordpress_companion/features/media/presentation/pages/media_page.dart';
import 'package:wordpress_companion/features/posts/presentation/pages/posts_page.dart';
import '../cubits/global_profile_cubit/global_profile_cubit.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/main_app_bar.dart';
import '../../utils/custom_url_launcher.dart';

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
    super.initState();
    pageController = PageController(initialPage: _selectedPageIndex);
    context.read<GlobalProfileCubit>().getMyProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: _bodyLayout(),
      endDrawer: CustomDrawer(customUrlLauncher: CustomUrlLauncher()),
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  Widget _bodyLayout() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          edgeToEdgePaddingHorizontal,
          20,
          edgeToEdgePaddingHorizontal,
          5,
        ),
        child: _pageView(),
      ),
    );
  }

  Widget _pageView() {
    return PageView(
      reverse: true,
      controller: pageController,
      onPageChanged: (value) => setState(() => _selectedPageIndex = value),
      children: _pages,
    );
  }

  List<Widget> get _pages {
    return [
      Container(
        key: const Key("posts_page"),
        child: const PostsPage(),
      ),
      Container(
        key: const Key("categories_page"),
        child: const Center(child: Icon(Icons.category)),
      ),
      Container(
        key: const Key("media_page"),
        child: const MediaPage(),
      ),
      Container(
        key: const Key("comments_page"),
        child: const Center(child: Icon(Icons.comment)),
      ),
    ];
  }

  Widget _bottomNavBar() {
    return SizedBox(
      height: 80,
      child: CustomizedBottomNavBar(
        currentIndex: _selectedPageIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }

  void _onBottomNavTap(int value) {
    setState(() {
      _selectedPageIndex = value;

      pageController.animateToPage(
        _selectedPageIndex,
        duration: Durations.short4,
        curve: Curves.easeInOut,
      );
    });
  }
}
