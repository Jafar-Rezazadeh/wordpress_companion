import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utils/extensions.dart';
import '../widgets/hero_section.dart';
import "../widgets/management_section.dart";
import '../widgets/quick_access_buttons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _bodyLayout(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.black,
      surfaceTintColor: Colors.white,
      elevation: 5,
      shape: _appBarShape(),
      leading: _menuButton(),
      title: Text("وردپرس یار", style: Theme.of(context).textTheme.titleMedium),
      centerTitle: true,
      actions: [
        _profileAvatar(),
        const Gap(10),
      ],
    );
  }

  ShapeBorder _appBarShape() {
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    );
  }

  IconButton _menuButton() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.menu),
    );
  }

  Widget _profileAvatar() {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: const CircleAvatar(
        child: Icon(Icons.person),
      ),
    );
  }

  Widget _bodyLayout() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: _bodySections(),
        ),
      ),
    );
  }

  Widget _bodySections() {
    return Column(
      children: [
        const QuickAccessButtons(),
        const HeroSection(),
        const ManagementSection(),
        const Gap(50),
      ].withSpaceBetween(20),
    );
  }
}
